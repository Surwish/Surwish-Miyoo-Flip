# MetaPixel
Theme for Emulationstation and RetroPie

MetaPixel now supports Video Previews.

About
-----

This theme was originally built on top of the great 'Pixel' theme by Eric Hettervik (Rookervik - https://retropie.org.uk/forum/user/rookervik). I used both the 'Pixel' and 'Simple' themes to work out how the XML worked, then completely rewrote everything to reduce the amount of code duplication, and make things fit my coding style.

I liked the 'Pixel' theme the most out of all the themes available to EmulationStation, but it was lacking metadata, so I made my own version of the theme with metadata. Using smaller boxes for the border, I was able to fit a lot more information onto the screen. I also added info and screenshots for each system to the System View screen. I think it makes things look nice.


Images
------

*RetroPie Settings System View*
![Image](http://i.imgur.com/V3vHnVJ.png)

*SNES System View*
![Image](http://i.imgur.com/du9o2nK.png)

*Mega Drive Detailed View*
![Image](http://i.imgur.com/Z1tEebt.png)

*Jaguar Simple View*
![Image](http://i.imgur.com/M552yWk.png)

[For more images view the album on Imgur](http://imgur.com/a/oqujr)


Artwork
-------

- All Console & Logo graphics made by Eric Hettervik. Assets are NOT for use in other themes or projects. All Graphics Copyright ©2017 Eric Hettervik
- 'Simple View' and 'System View' background images made by Eric Hettervik.
- 'Detailed View' background image made by me, based on Eric Hettervik's design.
- All border images made by me.
- Hidden, Child-Friendly and Favourite icon SVGs made by Zigurana (https://retropie.org.uk/forum/user/zigurana).
- All screenshot artwork owned be their respective owners.


Notes
-----

- This theme has not been tested with a 4/3 ratio. You may come across some ugliness with the metadata on the Detailed view.
- This theme probably won't look very good on smaller screens (such as hand-helds) due to the amount of content on the Detailed View.
- I have left out the "lastplayed" and "playcount" (because I don't use them) metadata, but there is space there to add them back in if you want them.
- Child-Friendly icons now work.
- I have only created folders for the consoles that I use, as I have limited free time to do this, but it is simple to create your own System folders:

	1. Copy an existing folder.
	2. Rename the folder to the new system.
	3. Put the new console and logo images into the folder (the 'Pixel' theme has many more than I have, so look there first).
	4. Open the theme.xml within the new system folder and change the color of the 'background' and 'gamelist' (note for gamelist: the '88' at the end of the color refers to the transparency value. 'FF' is fully opaque and '00' is completely transparent).
	5. Create new screenshots using your favourite image editor.
	6. Change 'system_description' in theme.xml (all descriptions from thegamesdb).

- Many new folders have been created by other users on the RetroPie forum. These are listed in the changelog
- New fonts have been added, but they don't have the same size as the default font. If you want to use these other fonts, you will need to work out the sizing for yourself (sorry).


Changelog
---------

2016-10-20
v1.3
- Added Video Preview Support

2016-10-20
v1.2
- Added folders:
	- By @CourierSS
		- amiga
		- atari800
		- atari2600
		- atari5200
		- atari7800
		- atarilynx
		- atarist
		- colecovision
		- daphne
		- gameandwatch
		- msx
		- neogeo
		- ngp
		- ngpc
		- residualvm
		- sg-1000
		- virtualboy
		- wonderswan
		- wonderswancolor
	- By @SnipedintheHead
		- arcade
- Added more images to:
	- fba
	- mame
- Added more fonts

2016-09-26
v1.1
- Fixed Child-Friendly icons
- Removed forceUppercase on gamelists

2016-08-01
v1.0 Initial version

---

Theme 'metapixel' v1.3 - 2017-05-18
(c) Matt Kennedy - info@cutmonkey.net - http://cutmonkey.net/
For use with EmulationStation (http://www.emulationstation.org/)
