## EmulationStation Theme: Cygnus  
Cygnus is a clean theme that displays large preview images, videos, marquees,  all title-oriented metadata and some useful user-oriented metadata. Cygnus comes in three colour schemes, 'cygnus' 'mono' and 'terminal'.  
  
**NOTE: Cygnus uses cutting edge features. You will need the latest official emulaionstation for the video, marquee, and carousel features to work correctly. Update from the RetroPie setup menu, manage packages, core, emulationstation.**  
  
### Installing Cygnus  
  
ssh onto your RetroPie install and enter the following:  
  
`mkdir -p ~/.emulationstation/themes`  
`cd ~/.emulationstation/themes`  
`git clone --depth=1 https://github.com/TheRobotFactory/es-theme-cygnus.git cygnus`  
  
It will now be choosable from the ui options menu in emulationstation  
  
### Cygnus theme config file  
There are two files included below by the config.xml file, one is a colorset, the other is a template.  
Valid changes you can make here are as follows.  
  
#### Colorsets  
cygnus.xml             <--- This is the default blue colorscheme.  
mono.xml               <--- This is a black and grey colorscheme.  
terminal.xml           <--- This is a green colorscheme.  
  
#### Templates  
cygnus.xml             <--- All bells & whistles. Lots of metadata, lots of art.  
nometa.xml             <--- No metadata, all text except gamelist removed.  
simpleart.xml          <--- Large art, no overlayed boxart or marquee images.  
simpleart-nometa.xml   <--- Minimal theme with just a gamelist and large art.  
  
### Platform Specific Themes  
Cygnus comes with a large number of defined systems, more than even the default carbon theme. these will either be used when you install the emulator for a sytem and add some roms or you can choose them yourself for your existing systems.  
  
This is useful if you want to override the display of systems to match your region and things like that. For example, by default Cygnus uses a picture of the USA SNES console and logo for the snes system; you can chage this behaviour by telling it to use either the 'sfc' theme or the 'snes-pal' theme to get the correct console and logo for you.  
  
Create a file in `/opt/retropie/configs/all/platforms.cfg` if it doesn't already exist. Edit the file and add lines to it in the format \<system\>_theme="\<themename\>" so in our example above I could add  
  
`snes_theme="sfc"`  
or  
`snes_theme="snes-pal"`  
  
other useful ones are:-  
  
`megadrive_theme="genesis"`  
`pcengine_theme="tg16"`  
`nes_theme="famicom"`  
  
There are lots of these, look at the folder names for a list of all the available systems!  
  
### Screenshots  
![Cygnus](https://atari8bit.net/wp-content/uploads/cygnus.jpg)  
![mono](https://atari8bit.net/wp-content/uploads/mono.jpg)  
![terminal](https://atari8bit.net/wp-content/uploads/terminal.jpg)  
  
![basic](https://atari8bit.net/wp-content/uploads/basic.jpg)  
![detail](https://atari8bit.net/wp-content/uploads/detail.jpg)  
![video](https://atari8bit.net/wp-content/uploads/video.jpg)  
  
### Credits  
All xml, and some images created by Steve Boswell (ChoccyHobNob).  
  
Based on the "Eudora" theme by AmadhiX, which is in turn based on the "Carbon" theme by Eric Hettervik, which is in turn based on "Simple" by Nils Bonenberger.  Some system logos and line art images are borrowed from these themes.  
  
The following fonts are used under the licenses included with the font files:  
"Titillium Web", "Adobe Blank"  
