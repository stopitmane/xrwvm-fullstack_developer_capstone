# Simple Startup Instructions

## What You Need

You need **3 services** running at the same time:
1. MongoDB Backend (port 3030)
2. Sentiment Analyzer (port 5050)  
3. Django Server (port 8000)

---

## Quick Start (3 Commands in 3 Terminals)

### Terminal 1 - MongoDB Backend
```cmd
cd xrwvm-fullstack_developer_capstone\server\database
docker-compose up
```
**Wait for:** "Server is running on port 3030"

---

### Terminal 2 - Sentiment Analyzer
```cmd
cd xrwvm-fullstack_developer_capstone\server\djangoapp\microservices
pip install -r requirements.txt
python app.py
```
**Wait for:** "Running on http://0.0.0.0:5050"

---

### Terminal 3 - Django Server
```cmd
cd xrwvm-fullstack_developer_capstone\server
python manage.py runserver
```
**Wait for:** "Starting development server at http://127.0.0.1:8000/"

---

## Then Open Browser

Go to: **http://localhost:8000/dealers**

---

## Don't Have Docker?

If you don't have Docker installed:
1. Download Docker Desktop: https://www.docker.com/products/docker-desktop
2. Install it
3. Restart your computer
4. Run the commands above

Docker is required because the MongoDB backend needs it to work properly.

---

## Screenshots for Lab

Once everything is running, take these screenshots:

1. Go to http://localhost:8000/dealers → Screenshot (get_dealers.png)
2. Login → Go to dealers → Screenshot (get_dealers_loggedin.png)
3. Select a state → Screenshot (dealersbystate.png)
4. Click dealer name → Screenshot (dealer_id_reviews.png)
5. Click "Post Review" → Fill form → Screenshot (dealership_review_submission.png)
6. Submit → Screenshot (added_review.png)

**Use Windows + Shift + S to take screenshots!**
