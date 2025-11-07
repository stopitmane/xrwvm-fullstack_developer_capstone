@echo off
echo Building frontend...
cd server\frontend

echo Installing npm packages...
call npm install

echo Building React app...
call npm run build

echo.
echo Frontend build complete!
echo.
pause
