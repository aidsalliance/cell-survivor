
var game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { preload: preload, create: create, update: update });

function preload() {

    game.load.atlas('breakin', 'assets/games/breakin/breakin-v2.png', 'assets/games/breakin/breakin-v2.json');
    game.load.image('cellfield', 'assets/misc/cellfield.jpg');

}

var ball;
var balls;
var paddle;
var bricks;

var lives = 3;
var score = 0;

var scoreText;
var livesText;
var introText;

var s;

var ballCount = 0;

function create() {

    game.physics.startSystem(Phaser.Physics.ARCADE);

    s = game.add.tileSprite(0, 0, 800, 600, 'cellfield');

    bricks = game.add.group();
    bricks.enableBody = true;
    bricks.physicsBodyType = Phaser.Physics.ARCADE;

    var brick;

    for (var y = 0; y < 2; y++)
    {
        for (var x = 0; x < 8; x++)
        {
            brick = bricks.create(120 + (x * 72), 380 + (y * 52), 'breakin', 'brick_' + ( (y+x)%2 * 2 + 1 ) + '_1.png');
            brick.scale.setTo(2,1);
            brick.body.bounce.set(1);
            brick.body.immovable = true;
        }
    }

    paddle = game.add.sprite(game.world.centerX, 500, 'breakin', 'ball_3.png');
    paddle.scale.setTo(4,4);
    paddle.anchor.setTo(0.5, 0.5);

    game.physics.enable(paddle, Phaser.Physics.ARCADE);

    paddle.body.collideWorldBounds = true;
    paddle.body.bounce.set(1);
    paddle.body.immovable = true;

    // ball = game.add.sprite(game.world.centerX, paddle.y - 16, 'breakin', 'ball_1.png');
    // ball.anchor.set(0.5);
    // ball.checkWorldBounds = true;

    // game.physics.enable(ball, Phaser.Physics.ARCADE);

    // ball.body.collideWorldBounds = true;
    // ball.body.bounce.set(1);

    scoreText = game.add.text(32, 550, 'score: ' + score, { font: "20px Arial", fill: "#ffffff", align: "left" });
    livesText = game.add.text(680, 550, '', { font: "20px Arial", fill: "#ffffff", align: "left" });
    introText = game.add.text(game.world.centerX, 400, '', { font: "40px Arial", fill: "#ffffff", align: "center" });
    introText.anchor.setTo(0.5, 0.5);

    balls = game.add.group();
    balls.enableBody = true;
    balls.physicsBodyType = Phaser.Physics.ARCADE;

    // this.ballTimer = this.game.time.create(false); // adds a timer to the game
    // this.ballTimer.start();

}

// function 

function update () {

    //  Fun, but a little sea-sick inducing :) Uncomment if you like!
    // s.tilePosition.x += (game.input.speed.x / 2);

    // paddle.body.x = game.input.x;

    // if (paddle.x < 24)
    // {
    //     paddle.x = 24;
    // }
    // else if (paddle.x > game.width - 24)
    // {
    //     paddle.x = game.width - 24;
    // }

    bricks.x = game.input.x / 3 - 120;


    game.physics.arcade.collide(balls, paddle, ballHitPaddle, null, this);
    // game.physics.arcade.collide(ball, bricks, ballHitBrick, null, this);
    game.physics.arcade.collide(balls, bricks, ballHitBrick, null, this);


    if(game.rnd.integerInRange(0,100) == 50)
    {
        document.title = ballCount;
        ballCount++;

        var ballColor = ([
            { start:'ball_1.png', anim:['ball_1.png', 'ball_4.png'] } // blue
          , { start:'ball_2.png', anim:['ball_2.png', 'ball_5.png'] } // red
        ])[ Math.random() > .5 ? 1 : 0 ]

        var newBall = balls.create(game.rnd.integerInRange(0, game.world.width), 0, 'breakin', ballColor.start); // = game.add.sprite(20, 20, 'breakin', 'ball_1.png');
        
        // ball.animations.add('spin', ballColor.anim, 50, true, false);

        newBall.anchor.set(0.5);
        newBall.checkWorldBounds = true;

        game.physics.enable(newBall, Phaser.Physics.ARCADE);

        newBall.body.collideWorldBounds = true;
        newBall.body.bounce.set(1);

        newBall.body.velocity.y = game.rnd.integerInRange(50,200);
        newBall.body.velocity.x = game.rnd.integerInRange(-200,200);

    }

}

function gameOver () {

    ball.body.velocity.setTo(0, 0);
    
    introText.text = 'Game Over!';
    introText.visible = true;

}

function ballHitBrick (_ball, _brick) {
    
    // console.log('brick: '+_brick._frame.name);
    // console.log('ball: '+_ball._frame.name);

    var brickColor = '3' === _brick._frame.name[6] ? 'red' : 'blue';
    var ballColor  = '1' === _ball._frame.name[5] || '4' === _ball._frame.name[5] ? 'blue' : 'red';

console.log(brickColor, _brick._frame.name, _brick._frame.name[6])

    if (brickColor !== ballColor)
    {
        _brick.kill();
    }
    else
    {
        score += 10;
        scoreText.text = 'score: ' + score;
    }

    _ball.kill();

    score += 10;

    if (score >= 200)
    {
        introText.text = 'Level 1 Complete';
        introText.visible = true;
        game.paused = true;
    }

    // scoreText.text = 'score: ' + score;

    //  Are they any bricks left?
    // if (bricks.countLiving() == 0)
    // {
    //     //  New level starts
    //     score += 1000;
    //     // scoreText.text = 'score: ' + score;
    //     introText.text = '';

    //     //  Let's move the ball back to the paddle
    //     ball.body.velocity.set(0);
    //     ball.x = paddle.x + 16;
    //     ball.y = paddle.y - 16;
    //     ball.animations.stop();

    //     //  And bring the bricks back from the dead :)
    //     bricks.callAll('revive');
    // }

}

function ballHitPaddle (_ball, _paddle) {

    gameOver();

    // var diff = 0;

    // if (_ball.x < _paddle.x)
    // {
    //     //  Ball is on the left-hand side of the paddle
    //     diff = _paddle.x - _ball.x;
    //     _ball.body.velocity.x = (-10 * diff);
    // }
    // else if (_ball.x > _paddle.x)
    // {
    //     //  Ball is on the right-hand side of the paddle
    //     diff = _ball.x -_paddle.x;
    //     _ball.body.velocity.x = (10 * diff);
    // }
    // else
    // {
    //     //  Ball is perfectly in the middle
    //     //  Add a little random X to stop it bouncing straight up!
    //     _ball.body.velocity.x = 2 + Math.random() * 8;
    // }


}

function gameOver () {
    
    introText.text = 'Game Over!';
    introText.visible = true;

    game.paused = true;

}
