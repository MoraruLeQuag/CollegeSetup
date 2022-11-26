@echo off
CHCP 65001
title College Nicolas Appert Setup

reg query HKU\S-1-5-19 1>nul 2>nul || (echo Erreur&goto :Admin)

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
echo                  Veuillez les suivre dans l'ordre pour subir le moins de soucis.
echo.
echo.
echo.
echo       [1] Changement de Nom de l'host / Insertion Domaine  [2] Installation de Office Scan
echo.
echo.
echo       [3] Installation IACA                                [4] Installation logiciels 
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
SET /P choice=Vous etes sur le point de lancer l'installation de l'antivirus (Yes or No) :
GOTO AVAST-%choice%


:AVAST-Yes
cls
SET /P M=Type Le chemin est-il correct ? "\\192.168.224.3\ofcscan\autoPccP.exe" (yes or no) : 

GOTO VALIDE-%M%

:Valide-Yes
cls
rem powershell start "\\192.168.224.3\OFC SCAN\autopcp.exe"
netsh exec C:\Users\Admin\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
start C:\Users\Admin\Desktop\SetupCollege\iaca.txt

echo apres installation complete, l'ordinateur va redemarrer...
pause
powershell Restart-Computer -Force


:AVAST-No
echo Commande annulee !
pause
cls
GOTO MENU

rem installation IACA
:LABEL-3
SET /P choice=Vous etes sur le point de lancer l'installation de IACA (Yes or No) :


GOTO IACA-%choice%


:IACA-Yes
cls
netsh exec C:\Users\Admin\Desktop\SetupCollege\iaca.txt
echo Découverte Réseau activée !
rem powershell start "\\0511038A-DC1\Netlogon\Client.exe"
start C:\Users\Admin\Desktop\SetupCollege\iaca.txt
echo Un redemarrage est necessaire afin de continuer...
pause 
powershell Restart-Computer -Force


:IACA-No
echo Commande annulee.
Pause
cls
GOTO MENU

:LABEL-4
rem Ninite, installeur de logiciels automatique
powershell wget -outf ninite.exe https://ninite.com/firefox-gimp-libreoffice-vlc-winrar/ninite.exe
powershell start ./ninite.exe
echo ninite installed !
powershell wget -outf GeoGebra-Windows-Installer-6-0-745-0.exe https://download.geogebra.org/installers/6.0/GeoGebra-Windows-Installer-6-0-745-0.exe
powershell start ./GeoGebra-Windows-Installer-6-0-745-0.exe
echo Geogebra en cours d'installation ...
echo GEOGEBRA INSTALLED !
echo photofiltre en cours de téléchargement ... 
powershell wget -outf photofiltre11.4.1_fr_setup.exe http://www.photofiltre-studio.com/pf11/photofiltre11.4.1_fr_setup.exe
powershell start ./photofiltre11.4.1_fr_setup.exe
echo Photofiltre INSTALLED !
powershell wget -ouf Scratch%203.29.1%20Setup.exe https://cdn-104.anonfiles.com/58E4AeJ2y9/68e9ff22-1669497636/Scratch%203.29.1%20Setup.exe
powershell start ./Scratch%203.29.1%20Setup.exe
taskkill /IM "GeoGebra.exe" /F
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
cls

goto Menu

:LABEL-5
cls
rem Uninstalleur de logiciels tout cela tout cela
powershell wget -outf geek.zip https://geekuninstaller.com/geek.zip

powershell Expand-Archive -Path ./geek.zip -DestinationPath C:\Users\$env:UserName\Desktop

powershell start C:\Users\$env:UserName\Desktop\geek.exe

cls
GOTO MENU



:Admin
rem Return si lancé sans droits admin
echo Ce script doit etre lance en Administrateur.
pause >nul

:ERROR
rem au cas ou y'a un bog
CLS
GOTO MENU

