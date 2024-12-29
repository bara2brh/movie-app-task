# Movie Explorer App

A Flutter app that allows users to explore movies using a public movie API (TMDB).

## Prerequisites

Before you can run this app, make sure you have the following installed:

- Flutter (version >= 3.0.0)
- Dart (version >= 2.10.0)
- A code editor (like VS Code, IntelliJ, or Android Studio)
- Android Studio or Xcode for running the app on an emulator or physical device

## Setup

### 1. Clone the repository:

Clone this repository to your local machine:

```bash 
git clone https://github.com/bara2brh/movie-app-task.git 
```

### 2. Install dependencies:
Navigate into the project directory and install the necessary packages:

```bash
cd movie-explorer 
flutter pub get
```

### 4. Run the app:
Now that everything is set up, you can run the app using the following command:
```bash
flutter run
```

### Features
Home Screen:

Display a list of movies fetched from the API.
Show movie posters, titles, and ratings.
Implement pagination to load more movies as the user scrolls.
Search Functionality:

Add a search bar at the top to filter movies by title.
Show real-time search results while typing.
Provide an option to clear and reset results.
Movie Details Screen:

On tapping a movie, navigate to a details screen displaying:
Poster image
Title
Overview/description
Release date
Rating
Include a back button to return to the home screen.
State Management:

Use a state management solution (e.g., Provider, Riverpod, or BLoC) to manage the app's state.
Error Handling:

Show an error message if the API call fails or returns no results.
Provide a retry option for failed requests.
Loading States:

Display a loading indicator during data fetching.
Show a "No results found" message for empty searches.
UI Design:

Build a clean and responsive design.
Ensure compatibility across devices (phones and tablets).
Bonus (Optional):
Favorites Feature:
Add a "Favorites" feature to save movies locally using shared_preferences.

Notes
The app uses BLoC for state management.
Data is fetched asynchronously from the movie API.
This app is optimized for both Android and iOS platforms.