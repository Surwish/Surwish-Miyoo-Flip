# Art Book Micro, an EmulationStation theme for "very tiny" screens
A simple theme for Emulation Station and RetroPie based on the look of a coffee table book.  Designed for 128x128 resolution screens.
Discussion is ongoing in this thread: https://retropie.org.uk/forum/topic/11728/new-theme-art-book

## Preview

### Animated Preview

![Animated Preview](https://i.imgur.com/XPr1qlC.gif)

### Views Supported

![System View](https://i.imgur.com/S8xJBWk.png)

## Details

- Designed for 128x128 resolution
- Uses support for theme variables to make the theme lightweight
- Full list of supported systems: https://docs.google.com/spreadsheets/d/1gzaP0klzaBaE5_oB1_hQwr46qOmQnacSvSU3o-p5Q7U/edit#gid=0
- System, basic, detailed views are supported
- Support for new "All Games", "Favorites", "Last Played" and "Custom Collections" features in latest version of EmulationStation

## Acknowledgments

- Some game console logo graphics are modified from the Carbom theme by Eric Hettervik
- ChangaOne font by Eduardo Tunni

## Scraping 
using selph's scraper: https://github.com/sselph/scraper

### Arcade
- Run either of the following commands in an arcade system's folder (i.e. /roms/mame-libretro, /roms/fba):
- If you want flyers... /opt/retropie/supplementary/scraper/scraper -mame=true -mame_src=gdb,adb,ss -mame_img=fly,b,t,s -max_height=540 -max_width=394 -image_dir=media -image_path=media
- If you want screenshots... /opt/retropie/supplementary/scraper/scraper -mame=true -mame_src=gdb,adb,ss -mame_img=s,t,fly,b -max_height=540 -max_width=394 -image_dir=media -image_path=media

### Console

- Run either of the following commands in a system's folder (i.e. /roms/nes): /opt/retropie/supplementary/scraper/scraper -console_src=ss -max_height=540 -max_width=505 image_dir=media -image_path=media -use_nointro_name=false 
- If you want boxart... /opt/retropie/supplementary/scraper/scraper -console_src=ss -max_height=540 -max_width=505 image_dir=media -image_path=media -use_nointro_name=false 
- If you want screenshots... /opt/retropie/supplementary/scraper/scraper -console_src=ss -console_img=s,b -max_height=540 -max_width=505 image_dir=media -image_path=media -use_nointro_name=false 
