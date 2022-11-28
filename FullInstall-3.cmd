@echo off
CHCP 65001
title FullInstall
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

:FULL-INSTALL
if exist "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Setup1.4.lnk" (
  del "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Setup1.4.lnk"
  echo Fichier supprimé !
)
if exist "C:\Users\%username%\Desktop\Setuptest" (
  cd "C:\Users\%username%\Desktop\SetupTest"(
    if exist "C:\Users\%username%\Desktop\SetupTest\iaca.txt"(
  echo "Fichier Iaca trouvé !"
  ) else (
    rem powershell wget -outf C:\Users\%username%\Desktop\SetupTest\IACA.txt {github path}
    rem powershell wget -outf C:\Users\%username%\Desktop\SetupTest\FullInstall-3.cmd {github path}
  )
  else (
  mkdir "C:\Users\%username%\Desktop\SetupTest"
  cd "C:\Users\%username%\Desktop\SetupTest"
  rem installation des dépendances
  rem powershell wget -outf C:\Users\%username%\Desktop\SetupTest\FullInstall-3.cmd {github path}
  rem powershell wget -outf C:\Users\%username%\Desktop\SetupTest\IACA.txt {github path}
    )
  )
)

echo L'installeur automatique vient de reprendre : 
pause
GOTO LABEL-4


:LABEL-4
rem Ninite, installeur de logiciels automatique *ça non plus*
powershell wget -outf ninite.exe https://ninite.com/firefox-gimp-libreoffice-vlc-winrar/ninite.exe
powershell start ./ninite.exe
echo ninite INSTALLING !
powershell wget -outf GeoGebra-Windows-Installer-6-0-745-0.exe https://download.geogebra.org/installers/6.0/GeoGebra-Windows-Installer-6-0-745-0.exe
powershell start ./GeoGebra-Windows-Installer-6-0-745-0.exe
echo Geogebra en cours d'installation ...
echo GEOGEBRA INSTALLING !
echo photofiltre en cours de téléchargement ... 
powershell wget -outf photofiltre11.4.1_fr_setup.exe http://www.photofiltre-studio.com/pf11/photofiltre11.4.1_fr_setup.exe
taskkill /IM "GeoGebra.exe" /F
powershell start ./photofiltre11.4.1_fr_setup.exe
echo Photofiltre INSTALLING !
powershell wget -outFile ScratchSetup.exe https://www.dropbox.com/s/chssfsjsi7jw5gf/Scratch%203.29.1%20Setup.exe?dl=1
powershell start ./ScratchSetup.exe
Scratch INSTALLING !

cls
pause

echo Suppression des fichiers d'installation ...
echo . .
echo . . .
powershell Remove-Item -Path ./photofiltre11.4.1_fr_setup.exe
echo Installeur de photofiltre supprimé ! 
echo Installeur de géogebra supprimé ! 
powershell Remove-Item -Path ./ninite.exe 
echo l'installeur de ninite supprimé !
powershell Remove-Item -Path ./GeoGebra-Windows-Installer-6-0-745-0.exe -force
powershell Remove-Item -Path ./ScratchSetup.exe
powershell Remove-Item -Path "C:\Users\%username%\Desktop\SetupTest"
cls

GOTO LABEL-5

:LABEL-5
cls
rem Uninstalleur de logiciels tout cela tout cela *cé pa de moi ça*
powershell wget -outf geek.zip https://geekuninstaller.com/geek.zip

powershell Expand-Archive -Path ./geek.zip -DestinationPath C:\Users\$env:UserName\Desktop

powershell start C:\Users\$env:UserName\Desktop\geek.exe

cls
del "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\FullInstall-3.lnk"
echo Suppression du raccourci dans startup effectuée !
echo L'installation totale vient de se terminer !
pause>nul


:Admin
rem Return si lancé sans droits admin
echo Ce script doit etre lance en Administrateur.
pause >nul

:ERROR
rem au cas ou y'a un bog
CLS
GOTO MENU
