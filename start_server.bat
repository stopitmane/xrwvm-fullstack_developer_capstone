@echo off
echo Starting Django server...
cd server

echo Activating virtual environment...
call djangoenv\Scripts\activate.bat

echo Starting server on port 8000...
python manage.py runserver

pause
