@echo off
echo Setting up Django environment...
cd server

echo Installing virtualenv...
pip install virtualenv

echo Creating virtual environment...
python -m virtualenv djangoenv

echo Activating virtual environment...
call djangoenv\Scripts\activate.bat

echo Installing requirements...
python -m pip install -U -r requirements.txt

echo Running migrations...
python manage.py makemigrations
python manage.py migrate

echo.
echo Environment setup complete!
echo To start the Django server, run: python manage.py runserver
echo.
pause
