How the wad14-game was built
============================

We built the game in OS X. You should be able to follow these instructions if you use Linux (eg Ubuntu), or even Windows.


1. We installed basic development tools
---------------------------------------
You may have some of these installed already, so you might be able to skip some of these steps.

1.1 git and git flow
1.2 node and npm
1.3 yeoman, gulp, and phaser-coffee-gulp
1.4 ruby and gem
1.5 compass
1.6 Sublime Text


2. We used phaser-coffee-gulp to create a barebones Phaser game
---------------------------------------------------------------

2.1 `$ mkdir wad14-game && cd $_`
2.2 `$ sudo yo phaser-coffee-gulp`
2.3 we added these lines to "devDependencies" in package.json:
    "coffee-script": "~1.8.0",
    "gifsicle": "~1.0.3"
2.4 `$ gulp`


3. We set up the game to be hosted on GitHub Pages
--------------------------------------------------

3.1 `$ nano .gitignore` and comment-out or delete the 'build' directory
3.2 `$ cp build/index.html index.html`
3.3 `$ nano index.html` and add '<base href="build/">' to the <head>
3.4 `$ nano README.md` to start writing this 'How to' guide
3.5 `$ git flow init`, and choose `gh-pages` as the production branch
3.6 we copied a GPL ‘LICENSE’ file from a previous project
3.7 `$ git add .`
3.8 `$ git commit -am '+ 0.0.0  Initial setup, before versioning'`






Releases
--------

+ 0.0.0  Initial setup, before versioning
+ 0.0.2  Initial release, to test GitHub Pages

