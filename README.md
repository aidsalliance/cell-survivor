How the wad14-game was built
============================

We built the game in OS X. You should be able to follow these instructions if you use a Linux operating system (eg Ubuntu), or even Windows.


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







Releases
--------

+ 0.0.0    initial setup, before versioning
+ 0.0.2    initial release, to test GitHub Pages
+ 0.0.4    GitHub Pages works, tidy up before build proper
+ 0.0.5-1  start converting tryout to the real app
+ 0.0.5-2  preload and display background and sprite images
+ 0.0.5-3  basic game mechanic working


