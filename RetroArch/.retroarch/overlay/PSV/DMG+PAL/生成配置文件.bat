@echo off
dir /B . | findstr .png >list.txt
for /f "delims=" %%i in (list.txt) do (
echo.overlays = 1 > %%i.cfg
echo.>> %%i.cfg
echo.overlay0_overlay = %%i >> %%i.cfg
echo.>>%%i.cfg
echo.overlay0_full_screen = true >> %%i.cfg
echo.>> %%i.cfg
echo.overlay0_descs = 0 >> %%i.cfg
)
del list.txt

