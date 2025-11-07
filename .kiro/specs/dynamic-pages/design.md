# Design Document - Dynamic Pages Feature

## Overview

The dynamic pages feature integrates React frontend components with Django backend routes to create a complete dealer review system. The architecture follows a client-server model where React components fetch data from Django REST API endpoints and render dynamic content based on user authentication state.

## Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Browser (Client)                         │
│  ┌────────────┐  ┌────────────┐  ┌──────────────┐          │
│  │  Dealers   │  │   Dealer   │  │ PostReview   │          │
│  │ Component  │  │ Component  │  │  Component   │          │
│  └─────┬──────┘  └─────┬──────┘  └──────┬───────┘          │
│        │               │                 │                   │
└────────┼───────────────┼─────────────────┼───────────────────┘
         │               │                 │
         │ HTTP GET      │ HTTP GET        │ HTTP POST
         │               │                 │
┌────────▼───────────────▼─────────────────▼───────────────────┐
│                   Django Server (Backend)                     │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              URL Router (urls.py)                     │   │
│  │  /dealers/ → index.html                              │   │
│  │  /dealer/:id → index.html                            │   │
│  │  /postreview/:id → index.html                        │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │           API Endpoints (djangoapp/urls.py)          │   │
│  │  /djangoapp/get_dealers/ → get_dealerships()         │   │
│  │  /djangoapp/dealer/:id → get_dealer_details()        │   │
│  │  /djangoapp/reviews/dealer/:id → get_dealer_reviews()│   │
│  │  /djangoapp/add_review → add_review()                │   │
│  │  /djangoapp/get_cars → get_cars()                    │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              Views (views.py)                         │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │          REST API Client (restapis.py)                │   │
│  └──────────────────────────────────────────────────────┘   │
└────────┬───────────────┬─────────────────┬───────────────────┘
         │               │                 │
         │ HTTP          │ HTTP            │ HTTP
         │               │                 │
┌────────▼───────────────▼─────────────────▼───────────────────┐
│              External Services                                │
│  ┌──────────────────┐  ┌──────────────────────────┐         │
│  │  MongoDB Backend │  │  Sentiment Analyzer      │         │
│  │  (Port 3030)     │  │  Service (Port 5050)     │         │
│  └──────────────────┘  └──────────────────────────┘         │
└───────────────────────────────────────────────────────────────┘
```

### Request Flow

1. **Page Load**: Browser requests `/dealers/` → Django serves `index.html` with React bundle
2. **Component Mount**: React Router matches route → Renders appropriate component
3. **Data Fetch**: Component calls Django API endpoint → Django fetches from external services
4. **Render**: Component receives JSON data → Updates UI with dealer/review information

## Components and Interfaces

### Frontend Components

#### 1. Dealers Component (`Dealers.jsx`)

**Purpose**: Display list of all dealers with state filtering

**State Management**:
- `dealersList`: Array of dealer objects
- `states`: Array of unique state values for dropdown

**Key Methods**:
- `get_dealers()`: Fetches all dealers from `/djangoapp/get_dealers/`
- `filterDealers(state)`: Filters dealers by selected state

**UI Elements**:
- Table displaying dealer information (ID, Name, City, Address, Zip, State)
- State dropdown filter
- Review icon (visible only when authenticated)
- Clickable dealer names linking to detail page

**Authentication Handling**:
- Checks `sessionStorage.getItem("username")` for login state
- Conditionally renders "Review Dealer" column

#### 2. Dealer Component (`Dealer.jsx`)

**Purpose**: Display individual dealer details and reviews

**State Management**:
- `dealer`: Dealer object with details
- `reviews`: Array of review objects
- `unreviewed`: Boolean flag for dealers with no reviews
- `postReview`: JSX element for post review button

**Key Methods**:
- `get_dealer()`: Fetches dealer details from `/djangoapp/dealer/:id`
- `get_reviews()`: Fetches reviews from `/djangoapp/reviews/dealer/:id`
- `senti_icon(sentiment)`: Returns appropriate sentiment icon

**UI Elements**:
- Dealer header with name and address
- Post review button (authenticated users only)
- Review cards with sentiment icons
- Loading and empty states

**Sentiment Display**:
- Positive: Green icon
- Neutral: Yellow icon
- Negative: Red icon

#### 3. PostReview Component (`PostReview.jsx`)

**Purpose**: Allow authenticated users to submit dealer reviews

**State Management**:
- `dealer`: Dealer object
- `review`: Review text content
- `model`: Selected car make/model
- `year`: Car year
- `date`: Purchase date
- `carmodels`: Array of available car models

**Key Methods**:
- `get_dealer()`: Fetches dealer information
- `get_cars()`: Fetches available car makes/models
- `postreview()`: Submits review to `/djangoapp/add_review`

**Validation**:
- All fields required before submission
- Alert shown if any field is empty
- Year range validation (2015-2023)

**Data Submission**:
```javascript
{
  "name": "User Full Name",
  "dealership": dealer_id,
  "review": "Review text",
  "purchase": true,
  "purchase_date": "YYYY-MM-DD",
  "car_make": "Make",
  "car_model": "Model",
  "car_year": year
}
```

### Backend Components

#### 1. URL Configuration (`djangoproj/urls.py`)

**Routes for React Pages**:
- `path('dealers/', TemplateView.as_view(template_name="index.html"))`
- `path('dealer/<int:dealer_id>', TemplateView.as_view(template_name="index.html"))`
- `path('postreview/<int:dealer_id>', TemplateView.as_view(template_name="index.html"))`

**Purpose**: Serve React SPA for all dynamic page routes

#### 2. API Endpoints (`djangoapp/urls.py`)

**Dealer Endpoints**:
- `GET /djangoapp/get_dealers/` - List all dealers
- `GET /djangoapp/get_dealers/<state>/` - Filter dealers by state
- `GET /djangoapp/dealer/<dealer_id>` - Get dealer details

**Review Endpoints**:
- `GET /djangoapp/reviews/dealer/<dealer_id>` - Get dealer reviews
- `POST /djangoapp/add_review` - Submit new review

**Car Data Endpoint**:
- `GET /djangoapp/get_cars` - Get car makes and models

#### 3. View Functions (`views.py`)

**get_dealerships(request, state="All")**:
- Fetches dealers from MongoDB backend
- Supports state filtering
- Returns JSON response with dealer array

**get_dealer_details(request, dealer_id)**:
- Fetches single dealer by ID
- Returns dealer object in JSON

**get_dealer_reviews(request, dealer_id)**:
- Fetches reviews for specific dealer
- Calls sentiment analyzer for each review
- Enriches review data with sentiment
- Returns reviews array with sentiment

**add_review(request)**:
- Validates user authentication
- Parses review data from request body
- Posts to MongoDB backend
- Returns success/error status

**get_cars(request)**:
- Queries CarMake and CarModel from database
- Initializes data if empty
- Returns car models with make information

#### 4. REST API Client (`restapis.py`)

**get_request(endpoint, **kwargs)**:
- Generic GET request handler
- Builds query parameters from kwargs
- Calls MongoDB backend service
- Returns JSON response

**analyze_review_sentiments(text)**:
- Calls sentiment analyzer service
- Returns sentiment classification (positive/neutral/negative)

**post_review(data_dict)**:
- Posts review to MongoDB backend
- Returns confirmation response

## Data Models

### Dealer Object
```javascript
{
  "id": integer,
  "full_name": string,
  "city": string,
  "address": string,
  "zip": string,
  "state": string
}
```

### Review Object
```javascript
{
  "id": integer,
  "name": string,
  "dealership": integer,
  "review": string,
  "purchase": boolean,
  "purchase_date": string,
  "car_make": string,
  "car_model": string,
  "car_year": integer,
  "sentiment": string  // Added by backend after analysis
}
```

### Car Model Object
```javascript
{
  "CarMake": string,
  "CarModel": string
}
```

## Error Handling

### Frontend Error Handling

**Network Errors**:
- Components check response status before processing
- Display loading states during fetch operations
- Show "No reviews yet!" for empty review lists

**Validation Errors**:
- PostReview validates all required fields
- Alert shown for missing data
- Prevents submission until valid

**Authentication Errors**:
- Check sessionStorage for username
- Conditionally render authenticated features
- Redirect to login if needed

### Backend Error Handling

**API Endpoints**:
- Return appropriate HTTP status codes (200, 400, 401, 403)
- Include error messages in JSON response
- Log errors for debugging

**Database Errors**:
- Try-catch blocks in view functions
- Return error status on exceptions
- Initialize car data if database empty

**External Service Errors**:
- Handle network exceptions in restapis.py
- Print error messages to console
- Return None or empty data on failure

## Testing Strategy

### Frontend Testing

**Component Testing**:
1. Test Dealers component renders dealer list
2. Test state filter functionality
3. Test authentication-based UI rendering
4. Test navigation links work correctly

**Integration Testing**:
1. Test API calls return expected data
2. Test error states display properly
3. Test form submission and validation
4. Test sentiment icons display correctly

### Backend Testing

**API Endpoint Testing**:
1. Test get_dealers returns dealer list
2. Test state filtering works correctly
3. Test dealer_id parameter handling
4. Test authentication requirements for add_review

**View Function Testing**:
1. Test JSON response format
2. Test error handling for invalid inputs
3. Test sentiment analysis integration
4. Test database initialization

### End-to-End Testing

**User Workflows**:
1. Navigate to dealers page → See dealer list
2. Filter by state → See filtered results
3. Click dealer name → See dealer details and reviews
4. Login → See post review option
5. Submit review → See new review with sentiment

**Screenshot Verification**:
1. Dealers list page (logged out)
2. Dealers list page (logged in)
3. Dealers filtered by state
4. Dealer detail page with reviews
5. Post review form
6. Dealer page with newly added review

## Build and Deployment

### Frontend Build Process

**Build Command**: `npm run build`

**Output**: 
- Static files in `server/frontend/build/`
- Django serves from `STATIC_ROOT`

**Build Steps**:
1. Compile React components
2. Bundle JavaScript with webpack
3. Optimize and minify assets
4. Copy to Django static directory

### Django Configuration

**Static Files**:
- `STATIC_URL` configured in settings
- `static()` helper serves built files
- Templates served from configured directory

**Template Configuration**:
- `index.html` for React SPA routes
- `Home.html` for landing page

### Environment Variables

**Required in `.env`**:
- `backend_url`: MongoDB service URL (default: http://localhost:3030)
- `sentiment_analyzer_url`: Sentiment service URL (default: http://localhost:5050)

## Security Considerations

**Authentication**:
- Session-based authentication using Django auth
- Username stored in sessionStorage
- CSRF exemption for API endpoints (using @csrf_exempt)

**Authorization**:
- add_review checks `request.user.is_anonymous`
- Returns 403 for unauthorized requests
- Frontend hides post review UI for unauthenticated users

**Input Validation**:
- Frontend validates required fields
- Backend validates dealer_id parameters
- JSON parsing with error handling

## Performance Considerations

**Frontend Optimization**:
- React production build with minification
- Lazy loading of components via React Router
- Efficient state updates with hooks

**Backend Optimization**:
- Database queries optimized with select_related
- Caching opportunities for dealer list
- Async-ready with Django views

**Network Optimization**:
- Single page application reduces page loads
- API responses return only necessary data
- Static assets served efficiently by Django
