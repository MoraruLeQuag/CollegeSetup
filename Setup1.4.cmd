@echo off
CHCP 65001
title College Nicolas Appert Setup

reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)

rem github template link : https://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@raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
:Menu
cls
echo. 
echo.
echo.
echo                             Bienvenue sur le logiciel d'installation
echo.
echo                                     College Nicolas Appert
echo. 
echo.
echo.
echo                             Voici les options d'installations. 
echo.
echo.
echo.
echo       [1] Changement de Nom de l'host / Insertion Domaine  [2] Installation de Office Scan
echo.
echo.
echo       [3] Installation IACA                                [4] Installation logiciels 
echo.
echo.       
echo                                  [5] Desinstalleur                                                               

echo.  
echo.

SET /P M=Type Option Number then press ENTER:
if /i "%M%"=="1" GOTO LABEL-1
if /i "%M%"=="2" GOTO LABEL-2
if /i "%M%"=="3" GOTO LABEL-3
if /i "%M%"=="4" GOTO LABEL-4
if /i "%M%"=="5" GOTO LABEL-5
if /i "%M%"=="6" GOTO LABEL-6
if /i "%M%"=="7" GOTO LABEL-7
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
del "C:\Users\%username%\Desktop\SetupTest"

powershell Add-Computer -DomainName 0511083A.local -Credential "Admin1" -Restart

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
if exist "C:\Users\%username%\Desktop\Setuptest" (
  cd "C:\Users\%username%\Desktop\SetupTest"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupTest"
  cd "C:\Users\%username%\Desktop\SetupTest"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupTest\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt

)
SET /P choice=Vous etes sur le point de lancer l'installation de l'antivirus (Yes or No) :
GOTO AVAST-%choice%


:AVAST-Yes
cls
SET /P M=Type Le chemin est-il correct ? "\\192.168.224.3\ofcscan\autoPccP.exe" (yes or no) : 

GOTO VALIDE-%M%

:Valide-Yes
cls
rem powershell start "\\192.168.224.3\OFC SCAN\autopcp.exe"
netsh exec C:\Users\%UserName%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
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
if exist "C:\Users\%username%\Desktop\Setuptest" (
  cd "C:\Users\%username%\Desktop\SetupTest"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupTest"
  cd "C:\Users\%username%\Desktop\SetupTest"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupTest\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt

)
SET /P choice=Vous etes sur le point de lancer l'installation de IACA (Yes or No) :


GOTO IACA-%choice%


:IACA-Yes
cls
netsh exec C:\Users\%username%\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
rem powershell start "\\0511038A-DC1\Netlogon\Client.exe"
start C:\Users\%username%\Desktop\SetupCollege\iaca.txt
echo Un redemarrage est necessaire afin de continuer...
pause 
powershell Restart-Computer -Force


:IACA-No
echo Commande annulee.
Pause
cls
GOTO MENU

:LABEL-4
if exist "C:\Users\%username%\Desktop\Setuptest" (
  cd "C:\Users\%username%\Desktop\SetupTest"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupTest"
  cd "C:\Users\%username%\Desktop\SetupTest"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupTest\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
)
rem Ninite, installeur de logiciels automatique *ça non plus*
powershell wget -outf C:\Users\%username%\Desktop\SetupTest\ninite.exe https://ninite.com/firefox-gimp-libreoffice-vlc-winrar/ninite.exe
powershell start C:\Users\%username%\Desktop\SetupTest\ninite.exe
echo ninite INSTALLING !
powershell wget -outf C:\Users\%username%\Desktop\SetupTest\GeoGebra-Windows-Installer-6-0-745-0.exe https://download.geogebra.org/installers/6.0/GeoGebra-Windows-Installer-6-0-745-0.exe
powershell start C:\Users\%username%\Desktop\SetupTest\GeoGebra-Windows-Installer-6-0-745-0.exe
echo Geogebra en cours d'installation ...
echo GEOGEBRA INSTALLING !
echo photofiltre en cours de téléchargement ... 
powershell wget -outf C:\Users\%username%\Desktop\SetupTest\photofiltre11.4.1_fr_setup.exe http://www.photofiltre-studio.com/pf11/photofiltre11.4.1_fr_setup.exe
taskkill /IM "GeoGebra.exe" /F
powershell start C:\Users\%username%\Desktop\SetupTest\photofiltre11.4.1_fr_setup.exe
echo Photofiltre INSTALLING !
powershell wget -outFile C:\Users\%username%\Desktop\SetupTest\ScratchSetup.exe https://www.dropbox.com/s/chssfsjsi7jw5gf/Scratch%203.29.1%20Setup.exe?dl=1
powershell start C:\Users\%username%\Desktop\SetupTest\ScratchSetup.exe
echo Scratch INSTALLING !

cls
pause

echo Suppression des fichiers d'installation ...
echo . .
echo . . .
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupTest\photofiltre11.4.1_fr_setup.exe
echo Installeur de photofiltre supprimé ! 
echo Installeur de géogebra supprimé ! 
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupTest\ninite.exe 
echo l'installeur de ninite supprimé !
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupTest\GeoGebra-Windows-Installer-6-0-745-0.exe -force
powershell Remove-Item -Path C:\Users\%username%\Desktop\SetupTest\ScratchSetup.exe
powershell Remove-Item -Path /F C:\Users\%username%\Desktop\SetupTest
cls

goto Menu

:LABEL-5
cls
rem Uninstalleur de logiciels tout cela tout cela *cé pa de moi ça*
powershell wget -outf geek.zip https://geekuninstaller.com/geek.zip

powershell Expand-Archive -Path ./geek.zip -DestinationPath C:\Users\$env:UserName\Desktop

powershell start C:\Users\$env:UserName\Desktop\geek.exe

cls
GOTO MENU

:LABEL-7
powershell start "https://youtu.be/dQw4w9WgXcQ"
cls
echo Oui. 
pause>nul
GOTO MENU

:LABEL-6
cls
color 4
SET /P M=Vous êtes sur le point de lancer l'installation automatique. Veuillez confirmer ... (yes / no)

GOTO choice-%M%

:choice-no
cls
GOTO MENU

:choice-yes
cls
if exist "C:\Users\%username%\Desktop\Setuptest" (
  cd "C:\Users\%username%\Desktop\SetupTest"
  ) else (
  mkdir "C:\Users\%username%\Desktop\SetupTest"
  cd "C:\Users\%username%\Desktop\SetupTest"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupTest\iaca.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
)
echo Téléchargement de l'installeur automatique...
powershell wget -ouft C:\Users\%username%\Desktop\SetupTest\FullInstall.cmd {github path}
start C:\Users\%username%\Desktop\SetupTest\FullInstall.cmd
exit

:Admin
rem Return si lancé sans droits admin
echo Ce script doit etre lance en Administrateur.
pause >nul

:ERROR
rem au cas ou y'a un bog
CLS
GOTO MENU
