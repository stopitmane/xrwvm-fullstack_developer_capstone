# Complete Startup Guide

## Prerequisites
- Node.js and npm installed
- Python 3.x installed
- **Docker Desktop installed (HIGHLY RECOMMENDED)**

## Important Note About MongoDB

The MongoDB backend service is configured to use Docker. You have two options:

### Option A: Use Docker (RECOMMENDED - Much Easier!)
- Install Docker Desktop from https://www.docker.com/products/docker-desktop
- The docker-compose.yml file will handle everything automatically

### Option B: Manual Setup (More Complex)
- Install MongoDB locally
- Modify `server/database/app.js` to connect to local MongoDB
- This requires additional configuration

## Step-by-Step Startup Instructions

### Step 1: Start MongoDB Backend Service (Using Docker)

Open a **NEW terminal window** and run:
```cmd
cd xrwvm-fullstack_developer_capstone\server\database
docker-compose up
```

This will:
- Start MongoDB container
- Start the Node.js backend service on port 3030
- Keep this terminal window open!

**Expected output:** "Server is running on port 3030"

**Note:** First time will take longer as it downloads Docker images.

---

### Step 2: Start Sentiment Analyzer Service

Open **ANOTHER NEW terminal window** and run:
```cmd
cd xrwvm-fullstack_developer_capstone
start_sentiment_analyzer.bat
```

This will:
- Install Python packages (Flask, nltk)
- Start the sentiment analyzer on port 5050
- Keep this terminal window open!

**Expected output:** "Running on http://0.0.0.0:5050"

---

### Step 3: Start Django Server

Open **ANOTHER NEW terminal window** and run:
```cmd
cd xrwvm-fullstack_developer_capstone
start_server.bat
```

This will:
- Activate the Django virtual environment
- Start Django server on port 8000
- Keep this terminal window open!

**Expected output:** "Starting development server at http://127.0.0.1:8000/"

---

### Step 4: Access the Application

Open your browser and navigate to:
- **Home Page:** http://localhost:8000/
- **Dealers Page:** http://localhost:8000/dealers

---

## Summary: You Need 3 Terminal Windows Running

1. **Terminal 1:** MongoDB Backend (port 3030)
2. **Terminal 2:** Sentiment Analyzer (port 5050)
3. **Terminal 3:** Django Server (port 8000)

## Troubleshooting

### If MongoDB Backend fails:
- Make sure Node.js is installed: `node --version`
- Make sure npm is installed: `npm --version`
- Check if port 3030 is already in use

### If Sentiment Analyzer fails:
- Make sure Python is installed: `python --version`
- Make sure pip is installed: `pip --version`
- Check if port 5050 is already in use

### If Django Server fails:
- Make sure migrations are run (already done)
- Check if port 8000 is already in use
- Verify the other two services are running first

### If you see "No dealers" on the dealers page:
- Verify MongoDB backend is running (Terminal 1)
- Check the browser console for errors
- Verify the .env file has correct backend_url

---

## Screenshots Needed for Lab

Once all services are running, capture these screenshots:

1. **get_dealers.png** - Navigate to http://localhost:8000/dealers
2. **get_dealers_loggedin.png** - Login first, then view dealers page
3. **dealersbystate.png** - Select a state from dropdown
4. **dealer_id_reviews.png** - Click on a dealer name
5. **dealership_review_submission.png** - Click "Post Review" and fill form
6. **added_review.png** - After submitting review

**Remember:** Include the URL bar in your screenshots!

---

## Stopping the Services

To stop all services:
1. Go to each terminal window
2. Press `Ctrl + C`
3. Close the terminal windows
