The Making of Cell Survivor
===========================

We built [the game](http://aidsalliance.github.io/cell-survivor "Play the game here") in OS X. You should be able to repeat these steps if you use a Linux operating system (eg Ubuntu), or even Windows.


1. Installed basic development tools
------------------------------------
You may have some of these installed already, so you might be able to skip some of these steps.

__1.1__   git and git flow  
__1.2__   node and npm  
__1.3__   yeoman, gulp, and phaser-coffee-gulp  
__1.4__   ruby and gem  
__1.5__   compass  
__1.6__   Sublime Text with the [CoffeeScript plugin](https://github.com/Xavura/CoffeeScript-Sublime-Plugin "Install the Sublime Coffeescript plugin")  


2. Used phaser-coffee-gulp to create a barebones Phaser game
------------------------------------------------------------

__2.1__   `$ mkdir wad14-game && cd $_`  
__2.2__   `$ sudo yo phaser-coffee-gulp`  
__2.3__   added these lines to "devDependencies" in package.json:  
```json
      "coffee-script": "~1.8.0",
      "gifsicle": "~1.0.3"
```
__2.4__   `$ gulp`  


3. Set up the game to be hosted on GitHub Pages
-----------------------------------------------

__3.1__   `$ nano .gitignore` and comment-out or delete the ‘build’ directory  
__3.2__   `$ cp build/index.html index.html`  
__3.3__   `$ nano index.html` and add `<base href="build/">` to the `<head>`  
__3.4__   `$ nano README.md` to start writing this ‘How to’ guide  
__3.5__   `$ git flow init`, and choose `gh-pages` as the production branch  
__3.6__   copied a GPL ‘LICENSE’ file from a previous project  
__3.7__   `$ git add .`  
__3.8__   `$ git commit -am '+ 0.0.0  Initial setup, before versioning'`  
__3.9__   incremented version to '0.0.2' in package.json and bower.json  
__3.10__  `$ git flow release start 0.0.2`  
__3.11__  `$ git commit -am '+ 0.0.2  Initial release, to test GitHub Pages'`  
__3.12__  `$ git flow release finish 0.0.2`  
__3.13__  created a new repository in GitHub  
__3.14__  `$ git remote add origin https://github.com/aidsalliance/wad14-game.git`  
__3.15__  `$ git push -u origin gh-pages`  
__3.16__  `$ git push -u origin develop`  
__3.17__  `$ git push --tags`  
__3.18__  visited http://aidsalliance.github.io/wad14-game/ to check GitHub Pages  
__3.19__  tidied up ‘README.md’ and released version 0.0.4  


4. Pasted functionality from previous Phaser tryout into real app
-----------------------------------------------------------------

__4.1__   `$ gulp` to open the game in a browser window and start watching for changes  
__4.2__   `$ git flow feature start convert-tryout-to-real-app`  
__4.3__   version '0.0.5-1' in package.json and bower.json, and commit  
__4.4__   corrected HTML window title  
__4.5__   saved ‘wad14-game.sublime-project’ for easy access to ‘src/’ and ‘README.md’  
__4.6__   pasted in ‘ref/breakin.js’, a tryout we based on Phaser’s Breakout example  
__4.7__   pasted breakin’s images and slice-data in ‘src/assets/images/’  
__4.8__   restarted gulp, ctrl-c followed by `$ gulp`, to take in new files  
__4.9__   loaded the images and slice-data in ‘src/game/states/preloader.coffee’  
__4.10__  display the images in ‘src/game/states/game.coffee’ (browser console helps)  
__4.11__  bumped version to '0.0.5-2', track new files with `$ git add .`, and commit  
__4.12__  defined `Pathogen` and `Brick` classes in ‘src/game/classes/’  
__4.13__  bricks rotate around nucleus, pathogens appear at random from top and bounce  
__4.14__  collisions detected: bricks are destroyed correctly, nucleus hit ends game  
__4.15__  bumped version to '0.0.5-3', track new files and commit  
__4.16__  `$ git flow release start 0.0.6` released version '0.0.6', pushed to GitHub


5. Added four increasingly difficult levels, a score, and end-of-level messages
-------------------------------------------------------------------------------

__5.1__   `$ git flow feature start levels`  
__5.2__   moved compile-error logs to the Terminal, in ‘gulp/util/handleErrors.coffee’  
```coffee
  # Just log to console.
  notify.onError
    title: 'Compile Error'
    message: '<%= error.toString().substr( error.toString().indexOf("/src/") ) %>'
    notifier: (options, callback) ->
  .apply this, args
```
__5.3__   add/renamed states ‘splash’, ‘level-one’, ‘level-one-complete’, ‘game-over’  
__5.4__   bumped version to '0.0.7-1', track new files and commit  
__5.5__   created generic ‘Level’ and ‘Message’ classes  
__5.6__   pasted simple ‘score’ system from ‘breakin.js’  
__5.7__   added states ‘level-two/three/four’ and ‘level-two/three-complete’  
__5.8__   bumped version to '0.0.7-2', track new files and commit  
__5.9__   `$ git flow feature finish levels`, `$ git flow release start 0.1.0`  


6. Renamed game to ‘Cell Survivor’, and added real graphics and messages
------------------------------------------------------------------------

__6.1__   find/replace 'wad14-game' to 'cell-survivor' in all files  
__6.2__   `$ git flow release finish 0.1.0`, `$ git flow feature start messages`  
__6.3__   used the ‘Message’ class for all message screens  
__6.4__   added work-in-progress messages from ‘Game script.docx’  
__6.5__   bumped version to '0.1.1-1', track new files and commit  
__6.6__   moved all ‘Level’ arguments into a single ‘opt’ object  
__6.7__   special game-over screen for level four  
__6.8__   bumped version to '0.1.1-2', track new files and commit  
__6.9__   drew nucleus, pathogens, and bricks in Photoshop, converted to GIF  
__6.10__  drew background in Photoshop, converted to JPEG  
__6.11__  resized to 600x600 in ‘src/game/main.coffee’ and ‘src/sass/main.scss’  
__6.12__  added new images to ‘src/game/states/preloader.coffee’  
__6.13__  simplified collision-type detection, using `name` property  
__6.14__  slowed down game, to begin tuning difficulty  
__6.15__  bumped version to '0.1.1-3', track new files and commit  
__6.16__  release start 0.1.4, bumped to '0.1.4', release finish, pushed to GitHub


7. Responsive landscape/portrait, and outer-frame elements
----------------------------------------------------------

__7.1__   `$ git flow feature start frame`, bumped to '0.1.5-1'
__7.2__   remove pathogens which have traversed the screen, and commit
__7.3__   game wrapped in window-filling CSS table with #header and #footer elements
__7.4__   use `setBounds()` and `camera.y` to hide pathogens as they enter and leave
__7.5__   bumped version to '0.1.5-2' and commit  
__7.6__   installed jQuery via bower  
__7.7__   used jQuery to switch landscape and portrait modes, and resize canvas  
__7.8__   pathogens enter from left and exit right in portrait mode  
__7.9__   bumped version to '0.1.5-3', track and commit  
__7.10__  created vein-wall graphics and added to game  
__7.11__  created frame icons and added to game (not yet functional)  
__7.12__  bumped version to '0.1.5-4', track and commit  
__7.13__  made frame icons resize neatly, landscape and portrait  
__7.14__  added links to frame icons, with css animated hover state  
__7.15__  moved score from a game-overlay into the frame  
__7.16__  bumped version to '0.1.5-5', track and commit  
__7.17__  passed ‘powerups’ array to ‘Levels’ class  
__7.18__  bumped version to '0.1.5-6', track new files and commit  
__7.19__  amended some message text, and made level 3 easier  
__7.20__  feature finish, release 0.1.6, pushed to GitHub  


8. Powerup functionality and in-game popups
-------------------------------------------

__8.1__   `$ git flow feature start powerups`  
__8.2__   added `buildWall()`, called when levels start, and when a pill is clicked  
__8.3__   added a basic condom-shield graphic, which disappears after a short delay  
__8.4__   fixed basic shield and pill functionality, to work on all levels  
__8.5__   bumped version to '0.1.7-1', track and commit  
__8.6__   HIV appears on level 1, but cannot hit the cell wall or nucleus  
__8.7__   HIV ends level 2 when touched, and just breaks walls on levels 3 and 4  
__8.8__   `console.log()` text at various steps in the user journey  
__8.9__   bumped version to '0.1.7-2', track new files, and commit  
__8.10__  HTML and CSS popup, opacity 0, with dismiss-x  
__8.11__  popup appears at various steps in the user journey  
__8.12__  improved playability of levels, and increasing difficulty  
__8.13__  bumped version to '0.1.7-3', track new files, and commit  
__8.14__  feature finish, release 0.1.8, pushed to GitHub  


9. Added animation, soundtrack, sound effects, and ‘Cell Survivor’ logo
-----------------------------------------------------------------------

__9.1__   `$ git flow feature start animation`  
__9.2__   simple animation when HIV infects the nucleus  
__9.3__   `explode()` method works on viruses, bricks, and the nucleus  
__9.4__   bumped version to '0.1.9-1', tracked new files, and commit  
__9.5__   added colour to popup text  
__9.6__   added ten sfx, for in-game actions  
__9.7__   added background music  
__9.8__   After a player reaches level 3, the first three popups are never shown again  
__9.9__   bumped version to '0.1.9-2', tracked new files, and commit  
__9.10__  added background to message button, and created and added Cell Survivor logo  
__9.11__  bumped version to '0.1.9-3', tracked new files, and commit  
__9.12__  feature finish, release 0.1.10, pushed to GitHub  


10. Amends before initial launch version
----------------------------------------

__10.1__  `$ git flow feature start amends`  
__10.2__  “Visit the International HIV/AIDS Alliance home page” hover text on icon  
__10.3__  added the word ‘SCORE:’ above the score  
__10.4__  speeded up the HIV virus on level 1  
__10.5__  URL on game-over screens is now www.aidsalliance.org/worldAIDSday  
__10.6__  added a link to the ToU in the bottom-left corner of the screen  
__10.7__  created Terms of Use, at ‘tou.html’  
__10.8__  splash screen has age/parental guidance text  
__10.9__  Alliance branding on game over screen  
__10.10__ feature finish, release 0.1.12, pushed to GitHub  
__10.11__ fixed ‘tou.html’ links, hotfix 0.1.14, pushed to GitHub  
__10.12__ icons, metadata, Facebook and Twitter  
__10.13__ minor HTML fixes, hotfixes 0.1.16 and 0.1.18  
__10.14__ pink shield, hide ‘Well done for using…’ if not used  
__10.15__ hide first 3 popups if player reaches level 2  
__10.16__ keyboard input for rotation, and dismissing popups and levels  
__10.17__ hotfix 0.1.20, pushed to GitHub  
__10.18__ text amends, hotfix 0.1.22, pushed to GitHub  



Releases
--------

+ 0.0.2    initial release, to test GitHub Pages
+ 0.0.4    GitHub Pages works, tidy up before build proper
+ 0.0.6    basic game mechanic ready for testing
+ 0.1.0    score, levels, and CNAME, renamed game to ‘Cell Survivor’
+ 0.1.4    some real graphics
+ 0.1.6    vein walls, frame icons, responsive layout
+ 0.1.8    powerups and popups
+ 0.1.9-1  infection and explosion animations
+ 0.1.9-2  sfx and background music
+ 0.1.9-3  message button background and Cell Survivor logo
+ 0.1.10   animation, soundtrack, sfx and ‘Cell Survivor’ logo
+ 0.1.12   first round of amends before initial launch version
+ 0.1.14   hotfix ‘tou.html’ links
+ 0.1.16   icons, metadata, Facebook and Twitter
+ 0.1.18   minor fixes to the HTML files
+ 0.1.20   keyboard input
+ 0.1.22   text amends



