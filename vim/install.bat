rem install.bat
rem
rem Installs links for my vim files.

rem Remove all the old stuff
del %HOMEPATH%\vimfiles

rem Install the link so it will stay put automatically
mklink /d %HOMEPATH%\vimfiles %~dp0.vim
