@echo off
echo Starting MongoDB Backend Service...
cd server\database

echo Installing npm packages...
call npm install

echo Starting backend on port 3030...
node app.js

pause
