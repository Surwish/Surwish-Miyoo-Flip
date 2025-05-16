# Art Book Pocket, an EmulationStation theme for small screens
A simple theme for Emulation Station and RetroPie based on the look of a coffee table book.  Designed for 320x240 resolution screens.
Discussion is ongoing in this thread: https://retropie.org.uk/forum/topic/11728/new-theme-art-book

## Preview

### Video Walkthrough
https://www.youtube.com/watch?v=k_fKUiH_j-8

### Screenshots

*Detailed View (Snap)*

![Detailed View](https://i.imgur.com/LOOs3o6.png)

*Detailed View (Boxart)*

![Detailed View](https://i.imgur.com/k05yfPC.png)

*Basic View*

![Basic View](https://i.imgur.com/tSdKotv.png)

## Details

- Designed for 320x240 resolution
- Uses support for theme variables to make the theme lightweight
- Full list of supported systems: https://docs.google.com/spreadsheets/d/1gzaP0klzaBaE5_oB1_hQwr46qOmQnacSvSU3o-p5Q7U/edit#gid=0
- System, basic, detailed and video views are supported
- Support for new "All Games", "Favorites", "Last Played" and "Custom Collections" features in latest version of EmulationStation

## Acknowledgments

- Some game console logo graphics are modified from the Carbom theme by Eric Hettervik
- ChangaOne font by Eduardo Tunni

## Scraping 
using selph's scraper: https://github.com/sselph/scraper

### Arcade
- Run the following commands in an arcade system's folder (i.e. /roms/mame-libretro, /roms/fba): 
- First Scrape Flyers (from theGamesDB): /opt/retropie/supplementary/scraper/scraper -mame=true -mame_src=gdb,adb,ss -mame_img=fly,b,t,s -max_height=540 -max_width=394 -image_dir=media -image_path=media
- Then if you want Videos and Marquees (from ScreenScraper) run this: /opt/retropie/supplementary/scraper/scraper -mame=true -mame_src=ss,gdb,adb -download_videos=true -download_marquees=true -image_dir=media -image_path=media -video_dir=media -video_path=media -marquee_dir=media -marquee_path=media

### Console

- Run this command in a system's folder (i.e. /roms/nes): /opt/retropie/supplementary/scraper/scraper -console_src=ss -max_height=540 -max_width=505 -download_videos=true -download_marquees=true -image_dir=media -image_path=media -video_dir=media -video_path=media -marquee_dir=media -marquee_path=media -use_nointro_name=false 
- Other Notes: 
- If you only want images (no video/marquee) then you can modfiy the command to this: /opt/retropie/supplementary/scraper/scraper -console_src=ss -max_height=540 -max_width=505 image_dir=media -image_path=media -use_nointro_name=false 
- If you want higher quality art, add -img_format=png to the end of the command (that will download pngs instead of jpgs but will also result in larger filesizes - which may add lag if you are on a pi0)

### Game & Watch

- Run this command in the /roms/gameandwatch folder: /opt/retropie/supplementary/scraper/scraper -console_src=ss -console_img=clabel,b,s -img_format=png -max_height=540 -max_width=505 -image_dir=media -image_path=media
