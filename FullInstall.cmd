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
    powershell wget -outf C:\Users\%username%\Desktop\SetupTest\IACA.txt https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
  )
  else (
  mkdir "C:\Users\%username%\Desktop\SetupTest"
  cd "C:\Users\%username%\Desktop\SetupTest"
  rem installation des dépendances
  powershell wget -outf C:\Users\%username%\Desktop\SetupTest\FullInstall-2.cmd {github path}
  powershell wget -outf C:\Users\%username%\Desktop\SetupTest\IACA.txt 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@https://raw.githubusercontent.com/MoraruLeQuag/CollegeSetup/main/iaca.txt
    )
  )
)
echo Chemin dans startup atteint !
pause
cls
rem Ici, cela touche au domaine et cela change le nom pour s'adapter a IACA
SET /P choice=Type the new Computer Name (without space) then press ENTER:

echo Modifications en cours...
powershell Rename-Computer -NewName "%choice%" -force
echo Modification faite !

mklink /h "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\FullInstall-2.lnk" "C:\Users\%username%\Desktop\SetupTest\FullInstall-2.cmd" 
pause
echo Redémarrage en attente ... Appuyez sur Entrée pour continuer...
powershell Add-Computer -DomainName 0511083A.local -Credential "Admin1" -Restart

