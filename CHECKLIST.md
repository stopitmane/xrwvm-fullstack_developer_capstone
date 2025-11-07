# Lab Completion Checklist

## ☐ Prerequisites Setup

- [ ] Docker Desktop installed and running
- [ ] Node.js and npm installed
- [ ] Python 3.x installed
- [ ] All code changes completed (already done ✅)
- [ ] Frontend built (already done ✅)
- [ ] Database migrated (already done ✅)

## ☐ Start Services (3 Terminals)

### Terminal 1: MongoDB Backend
- [ ] Open new terminal
- [ ] Run: `cd xrwvm-fullstack_developer_capstone\server\database`
- [ ] Run: `docker-compose up`
- [ ] Wait for: "Server is running on port 3030"
- [ ] Keep terminal open ✓

### Terminal 2: Sentiment Analyzer
- [ ] Open new terminal
- [ ] Run: `cd xrwvm-fullstack_developer_capstone\server\djangoapp\microservices`
- [ ] Run: `pip install -r requirements.txt`
- [ ] Run: `python app.py`
- [ ] Wait for: "Running on http://0.0.0.0:5050"
- [ ] Keep terminal open ✓

### Terminal 3: Django Server
- [ ] Open new terminal
- [ ] Run: `cd xrwvm-fullstack_developer_capstone\server`
- [ ] Run: `python manage.py runserver`
- [ ] Wait for: "Starting development server at http://127.0.0.1:8000/"
- [ ] Keep terminal open ✓

## ☐ Test Application

- [ ] Open browser
- [ ] Navigate to: http://localhost:8000/
- [ ] Navigate to: http://localhost:8000/dealers
- [ ] Verify dealers list displays
- [ ] Verify state dropdown works

## ☐ Take Screenshots

### Screenshot 1: get_dealers.png
- [ ] Go to http://localhost:8000/dealers
- [ ] Press Windows + Shift + S
- [ ] Capture full page with URL bar visible
- [ ] Save as: get_dealers.png

### Screenshot 2: get_dealers_loggedin.png
- [ ] Click login/register
- [ ] Create account or login
- [ ] Go to http://localhost:8000/dealers
- [ ] Verify "Review Dealer" column appears
- [ ] Press Windows + Shift + S
- [ ] Save as: get_dealers_loggedin.png

### Screenshot 3: dealersbystate.png
- [ ] On dealers page, click state dropdown
- [ ] Select any state (e.g., California, Texas)
- [ ] Verify filtered results
- [ ] Press Windows + Shift + S
- [ ] Save as: dealersbystate.png

### Screenshot 4: dealer_id_reviews.png
- [ ] Click on any dealer name
- [ ] Verify dealer details page loads
- [ ] Verify reviews are displayed
- [ ] Verify sentiment icons show (positive/neutral/negative)
- [ ] Press Windows + Shift + S
- [ ] Save as: dealer_id_reviews.png

### Screenshot 5: dealership_review_submission.png
- [ ] Make sure you're logged in
- [ ] On dealer details page, click "Post Review" button
- [ ] Fill in all fields:
  - [ ] Review text
  - [ ] Purchase date
  - [ ] Car make/model (from dropdown)
  - [ ] Car year
- [ ] **DO NOT SUBMIT YET**
- [ ] Press Windows + Shift + S
- [ ] Save as: dealership_review_submission.png

### Screenshot 6: added_review.png
- [ ] Now click "Post Review" button to submit
- [ ] Wait for page to redirect to dealer details
- [ ] Verify your new review appears
- [ ] Verify sentiment icon is displayed
- [ ] Press Windows + Shift + S
- [ ] Save as: added_review.png

## ☐ Verify Screenshots

- [ ] All 6 screenshots saved
- [ ] URL bar visible in all screenshots
- [ ] Screenshots are clear and readable
- [ ] File names match exactly:
  - [ ] get_dealers.png
  - [ ] get_dealers_loggedin.png
  - [ ] dealersbystate.png
  - [ ] dealer_id_reviews.png
  - [ ] dealership_review_submission.png
  - [ ] added_review.png

## ☐ Submit Lab

- [ ] Upload all 6 screenshots to lab submission
- [ ] Verify all screenshots uploaded correctly
- [ ] Submit lab

## ☐ Cleanup (After Submission)

- [ ] Stop Django server (Ctrl+C in Terminal 3)
- [ ] Stop Sentiment Analyzer (Ctrl+C in Terminal 2)
- [ ] Stop MongoDB Backend (Ctrl+C in Terminal 1)
- [ ] Close all terminal windows

---

## 🎉 Done!

Congratulations on completing the lab!

---

## ❓ Troubleshooting

### If dealers page is empty:
- Check Terminal 1 - MongoDB backend must be running
- Check browser console for errors (F12)
- Verify URL: http://localhost:8000/dealers (with trailing 's')

### If "Post Review" doesn't appear:
- Make sure you're logged in
- Check sessionStorage in browser dev tools

### If car make dropdown is empty:
- Django database might need reinitialization
- Check Terminal 3 for errors

### If sentiment doesn't show:
- Check Terminal 2 - Sentiment analyzer must be running
- Check Terminal 3 for errors when submitting review

### Need Help?
- Check SIMPLE_START.md for basic instructions
- Check START_HERE.md for detailed instructions
- Check WHAT_WAS_DONE.md for technical details
