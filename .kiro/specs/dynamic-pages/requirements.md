# Requirements Document

## Introduction

This feature adds dynamic pages to the fullstack car dealership application, enabling users to view dealers, see dealer reviews, and post reviews. The system integrates React frontend components with Django backend routes to provide a complete dealer review workflow.

## Glossary

- **Application**: The fullstack car dealership web application
- **Frontend**: The React-based user interface
- **Backend**: The Django server and API endpoints
- **Dealer_Component**: React component displaying list of dealers
- **Review_Component**: React component showing dealer reviews
- **PostReview_Component**: React component for submitting reviews
- **Django_Server**: The Django web server running on port 8000
- **Build_Process**: The npm build process that compiles React code

## Requirements

### Requirement 1

**User Story:** As a user, I want to view a list of all car dealers, so that I can browse available dealerships

#### Acceptance Criteria

1. WHEN the user navigates to /dealers, THE Application SHALL display a table listing all dealers
2. THE Dealer_Component SHALL fetch dealer data from the get_dealers API endpoint
3. WHEN the user selects a state from the dropdown, THE Application SHALL filter dealers by that state
4. THE Application SHALL display dealer information including name and location
5. WHEN the user clicks on a dealer name, THE Application SHALL navigate to that dealer's detail page

### Requirement 2

**User Story:** As a user, I want to view reviews for a specific dealer, so that I can read customer feedback

#### Acceptance Criteria

1. WHEN the user navigates to /dealer/:id, THE Application SHALL display the dealer details page
2. THE Review_Component SHALL fetch and display all reviews for the specified dealer
3. THE Application SHALL display review content, sentiment, and reviewer information
4. WHERE the user is authenticated, THE Application SHALL display a "Post Review" link
5. THE Application SHALL show sentiment indicators (positive, neutral, negative) for each review

### Requirement 3

**User Story:** As an authenticated user, I want to post a review for a dealer, so that I can share my experience

#### Acceptance Criteria

1. WHEN an authenticated user navigates to /postreview/:id, THE Application SHALL display the review submission form
2. THE PostReview_Component SHALL provide input fields for review details including car make and model
3. WHEN the user submits a review, THE Application SHALL send the review data to the add_review API endpoint
4. THE Application SHALL analyze review sentiment using the sentiment analyzer service
5. WHEN the review is successfully posted, THE Application SHALL redirect to the dealer page showing the new review

### Requirement 4

**User Story:** As a developer, I want proper routing configured, so that the application serves pages correctly

#### Acceptance Criteria

1. THE Backend SHALL serve index.html for /dealers/, /dealer/<id>, and /postreview/<id> routes
2. THE Frontend SHALL define React routes matching the backend URL patterns
3. THE Application SHALL handle URL parameters for dealer_id correctly
4. THE Backend SHALL include trailing slashes in API endpoint routes for consistency
5. THE Django_Server SHALL serve static files and templates properly

### Requirement 5

**User Story:** As a developer, I want the frontend built and integrated, so that changes are reflected in the application

#### Acceptance Criteria

1. WHEN the developer runs npm build, THE Build_Process SHALL compile React components into static files
2. THE Django_Server SHALL serve the built React application from the static directory
3. THE Application SHALL load all required JavaScript and CSS assets
4. WHEN frontend code changes, THE Build_Process SHALL regenerate the build output
5. THE Django_Server SHALL restart automatically when static files are updated
