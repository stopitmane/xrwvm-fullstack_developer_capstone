@echo off
echo Starting Sentiment Analyzer Service...
cd server\djangoapp\microservices

echo Installing Python packages...
pip install -r requirements.txt

echo Starting sentiment analyzer on port 5050...
python app.py

pause
