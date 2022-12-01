@echo off
CHCP 65001
title College Setup

reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f
 
:Menu
cls
echo. 
echo.
echo.
echo                             Bienvenue sur le logiciel d'installation                                     
echo.
echo                               Voici les options d'installations. 
echo.
echo.
echo.
echo       [1] Changement de Nom de l'host / Insertion Domaine  [2] Installation logiciels
echo.
echo.        
echo       [3] Installation de Office Scan                      [4] Installation IACA   
echo.
echo.


SET /P M=Type Option Number then press ENTER:
if /i "%M%"=="1" GOTO LABEL-1
if /i "%M%"=="2" GOTO LABEL-4
if /i "%M%"=="3" GOTO LABEL-2
if /i "%M%"=="4" GOTO LABEL-3
if /i "%M%"=="5" GOTO LABEL-5

cls
GOTO MENU

:LABEL-1
rem Ici, cela touche au domaine et cela change le nom pour s'adapter a IACA
SET /P choice=Type the new Computer Name (without space) then press ENTER:
SET /P choiceverif= "%choice% est-il correct ? (yes / no / cancel):"
if /i "%choiceverif%"=="no" GOTO DomainChangerNo
if /i "%choiceverif%"=="cancel" GOTO DomainChangerCancel

echo Modifications en cours...
powershell Rename-Computer -NewName "%choice%" -force
echo Modification faite !

SET /P domain=Type the DomainName (without space) then press ENTER:
powershell Add-Computer -DomainName %domain% -Credential "Admin1" -Restart

cls
GOTO MENU


:DomainChangerNo
cls
GOTO LABEL-1

:DomainChangerCancel
echo Commande annulee.
pause
cls
GOTO Menu

rem Pour l'installation de OfficeScan, tout cela tout cela
:LABEL-2
cls
if exist "C:\Users\%username%\Desktop\SetupCollege" (
  cd "C:\Users\%username%\Desktop\SetupCollege"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupCollege"
  cd "C:\Users\%username%\Desktop\SetupCollege"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
)
SET /P choice=Vous etes sur le point de lancer l'installation de l'antivirus (Yes or No) :
GOTO AVAST-%choice%


:AVAST-Yes
cls

netsh exec C:\Users\%UserName%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
rem powershell start "\\192.168.224.3\OFC SCAN\autopcp.exe"
start C:\Users\%UserName%\Desktop\SetupCollege\iaca.txt

echo apres installation complete, l'ordinateur va redémarrer...
pause
powershell Restart-Computer -Force


:AVAST-No
echo Commande annulee !
pause
cls
GOTO MENU

rem installation IACA
:LABEL-3
if exist "C:\Users\%username%\Desktop\SetupCollege\iaca.txt" (
  cd "C:\Users\%username%\Desktop\SetupCollege"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupCollege"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
  )
SET /P choice=Vous etes sur le point de lancer l'installation de IACA (Yes or No) :


GOTO IACA-%choice%


:IACA-Yes
cls
netsh exec C:\Users\%username%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
powershell start "\\0511038A-DC1\Netlogon\Client.exe"
echo Un redemarrage est necessaire afin de continuer...
pause 
powershell Restart-Computer -Force


:IACA-No
echo Commande annulee.
Pause
cls
GOTO MENU

:LABEL-4
rem installation des dépendances
if exist "C:\Users\%username%\Desktop\SetupCollege" (
  echo SetupCollege already exist 
) else (
mkdir "C:\Users\%username%\Desktop\SetupCollege"
cd "C:\Users\%username%\Desktop\SetupCollege"
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\PhotoFiltre.exe https://github.com/MoraruLeQuag/CollegeSetup/raw/main/PhotoFiltre.exe
powershell wget -outf c:\Users\%username%\Desktop\SetupCollege\Scratch.exe https://github.com/MoraruLeQuag/CollegeSetup/raw/main/Scratch.exe
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\Ninite_Setup.exe https://github.com/MoraruLeQuag/CollegeSetup/raw/main/Ninite_Setup.exe
)

if exist "C:\Users\%username%\Desktop\SetupCollege\PhotoFiltre.exe https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/PhotoFiltre.exe"(
  echo L'auto-Installeur de photofiltre existe déjà !
) else (
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\PhotoFiltre.exe https://github.com/MoraruLeQuag/CollegeSetup/raw/main/PhotoFiltre.exe
)

if exist "C:\Users\%username%\Desktop\SetupCollege\Scratch.exe https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/PhotoFiltre.exe"(
  echo L'auto-Installeur de Scratch existe déjà !
) else (
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\Scratch.exe https://github.com/MoraruLeQuag/CollegeSetup/raw/main/Scratch.exe
)

if exist "C:\Users\%username%\Desktop\SetupCollege\Ninite_Setup.exe https://github.com/MoraruLeQuag/CollegeSetup/raw/main/Ninite_Setup.exe"(
  echo L'auto-Installeur de Ninite existe déjà !
) else (
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\Ninite_Setup.exe https://github.com/MoraruLeQuag/CollegeSetup/raw/main/Ninite_Setup.exe
)

rem la vie c'est de la merde
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\ninite.exe https://ninite.com/firefox-gimp-libreoffice-vlc-winrar/ninite.exe
powershell start C:\Users\%username%\Desktop\SetupCollege\ninite_setup.exe
echo ninite INSTALLING !
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\GeoGebra-Windows-Installer-6-0-745-0.exe https://download.geogebra.org/installers/6.0/GeoGebra-Windows-Installer-6-0-745-0.exe
powershell start C:\Users\%username%\Desktop\SetupCollege\GeoGebra-Windows-Installer-6-0-745-0.exe
echo Geogebra en cours d'installation ...
echo GEOGEBRA INSTALLING !
echo photofiltre en cours de téléchargement ... 
powershell wget -outf C:\Users\%username%\Desktop\SetupCollege\photofiltre11.exe http://www.photofiltre-studio.com/pf11/photofiltre11.4.1_fr_setup.exe
taskkill /IM "GeoGebra.exe" /F
powershell start C:\Users\%username%\Desktop\SetupCollege\PhotoFiltreSetup.exe 
pause
powershell wget -outFile C:\Users\%username%\Desktop\SetupCollege\ScratchSetup.exe https://www.dropbox.com/s/chssfsjsi7jw5gf/Scratch%203.29.1%20Setup.exe?dl=1
powershell start c:\Users\%username%\Desktop\SetupCollege\ScratchSetup.exe
echo Scratch INSTALLING !
pause

if exist C:\Users\$env:UserName\Desktop\geek.exe (
echo Geek est déjà installé !
echo.
echo Tous les logiciels sont installés ! 
GOTO Cleanup
)
else
(
powershell wget -outf geek.zip https://geekuninstaller.com/geek.zip
powershell Expand-Archive -Path ./geek.zip -DestinationPath C:\Users\$env:UserName\Desktop
echo geek uninstalleur installé !
)
cls
pause
GOTO Cleanup

:Cleanup
echo Suppression des fichiers d'installation ...
echo . .
echo . . .
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\photofiltre11.exe
echo Installeur de photofiltre supprimé ! 
echo Installeur de géogebra supprimé ! 
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\ninite.exe 
echo l'installeur de ninite supprimé !
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\GeoGebra-Windows-Installer-6-0-745-0.exe -force
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupCollege\ScratchSetup.exe
powershell Remove-Item -Path /F C:\Users\%username%\Desktop\SetupCollege
cls
echo Installation des logiciels terminée !
pause

goto Menu

:LABEL-5
powershell start "https://youtu.be/dQw4w9WgXcQ"
cls
echo Oui. 
pause>nul
GOTO MENU


:Admin
rem Return si lancé sans droits admin
echo Ce script doit être lance en Administrateur.
pause >nul

:ERROR
rem au cas ou y'a un bog
CLS
GOTO MENU
