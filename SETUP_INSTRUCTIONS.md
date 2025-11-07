# Setup Instructions for Dynamic Pages

## Changes Made

### 1. Frontend (App.js)
Added the following imports and routes:
- `Dealers` component - displays list of dealers in table format
- `Dealer` component - shows individual dealer with reviews
- `PostReview` component - allows authenticated users to post reviews

### 2. Backend (djangoproj/urls.py)
Added URL patterns for:
- `/dealers/` - Dealers list page
- `/dealer/<dealer_id>` - Individual dealer details page
- `/postreview/<dealer_id>` - Post review page

### 3. API Routes (djangoapp/urls.py)
Added trailing slashes to get_dealers routes for proper URL handling

## Setup Steps

### Option 1: Using Batch Files (Recommended for Windows)

1. **Setup Environment:**
   ```cmd
   setup_environment.bat
   ```

2. **Build Frontend:**
   ```cmd
   build_frontend.bat
   ```

3. **Start Server:**
   ```cmd
   start_server.bat
   ```

### Option 2: Manual Setup

1. **Setup Django Environment:**
   ```cmd
   cd xrwvm-fullstack_developer_capstone\server
   pip install virtualenv
   python -m virtualenv djangoenv
   djangoenv\Scripts\activate.bat
   python -m pip install -U -r requirements.txt
   ```

2. **Run Migrations:**
   ```cmd
   python manage.py makemigrations
   python manage.py migrate
   ```

3. **Build Frontend:**
   ```cmd
   cd frontend
   npm install
   npm run build
   cd ..\..
   ```

4. **Start Django Server:**
   ```cmd
   python manage.py runserver
   ```

## Testing the Application

1. **View Dealers List:**
   - Navigate to: `http://localhost:8000/dealers`
   - You should see a table listing all dealers
   - Screenshot: `get_dealers.png`

2. **Login and View Dealers:**
   - Login with valid credentials
   - View dealers page with "Post Review" option visible
   - Screenshot: `get_dealers_loggedin.png`

3. **Filter by State:**
   - Use the state dropdown to filter dealers
   - Screenshot: `dealersbystate.png`

4. **View Dealer Reviews:**
   - Click on any dealer name to view reviews
   - URL format: `http://localhost:8000/dealer/<id>`
   - Screenshot: `dealer_id_reviews.png`

5. **Post a Review:**
   - Login first
   - Click "Post Review" link on dealer page
   - Fill in review details
   - Screenshot before submit: `dealership_review_submission.png`
   - Screenshot after submit: `added_review.png`

## Troubleshooting

### If Dealers List Not Visible:
- Ensure trailing slash in `djangoapp/urls.py` for get_dealers route
- Check that Mongo server is running
- Verify backend URL in `.env` file
- Restart Django server after updating `.env`
- Uncomment `import requests` in `djangoapp/restapis.py`

### If CarMake Dropdown Not Working:
1. Delete `db.sqlite3` from server directory
2. Remove `__pycache__` folder from djangoapp directory
3. Remove `__init__.py` if present in djangoapp
4. Run migrations:
   ```cmd
   python manage.py makemigrations
   python manage.py migrate --run-syncdb
   ```
5. Restart Django server

## Important Notes

- Make sure MongoDB is running before starting the Django server
- Update the backend URL in `.env` file if needed
- Always rebuild frontend after making changes to React components
- Restart Django server after updating `.env` file
