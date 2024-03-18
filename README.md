# BMCinema iOS App
It's an ios app that allows users to browse a list of now playing, popular, and upcoming movies from The Movie Database (TMDb) API. Users can view basic movie information and navigate to detailed screens for comprehensive movie details.

# Table of Contents
  * [Features](#features)
  * [Technologies](#technologies)
  * [App Structure](#app-structure)


# Features
## List Screen: 
I implemented three tabs using a native tab bar to display **now playing**, **popular**, and **upcoming** movies. For each tab, I fetched data from the TMDb API and displayed a list view of movies.

For each tab, I customized the UI design and information displayed to cater to the specific category:
1. Now Playing Movies list displays information such as title, overview, voteAverage, and voteCount.
2. Popular Movies list displays information such as title, overview, popularity, and voteAverage.
3. Upcoming Movies list displays information such as title, overview, and release data.

## Detail Screen: 
I implemented a detail screen that provides comprehensive information about the selected movie. When a user selects a movie from the list, I fetch additional details from the TMDb API, including genres. The detail screen also includes a button to navigate back to the list screen for easy navigation.

# Technologies

 ![Static Badge](https://img.shields.io/badge/iOS-17.2-blue)
 ![Static Badge](https://img.shields.io/badge/Swift-5.0-orange)
 ![Static Badge](https://img.shields.io/badge/Xcode-15.1-blue)

|        Technology        |           Framework in Project            |
| ------------------------ | ----------------------------------------- |
| Framework                | UIKit + SwiftUI             |
| Networking               | URLSession                                |
| Testing                  | XCTest                                    |
| Caching                  | URLSession Caching                        |


# App Structure

## MVVM Architecture: 
The project implements the MVVM architecture pattern for managing UI-related concerns, separating presentation logic from business logic.

## DDD Principles: 
The app's codebase is organized following Domain-Driven Design principles, separating concerns into domain, data, and presentation layers in each feature.

## Unit Tests: 
Critical components and functionalities of the app are covered by unit tests to ensure code reliability and correctness.

## Error Handling: 
Informative error messages are displayed to users when data retrieval or processing fails.

## UI/UX Design: 
The app's design and usability are carefully considered to provide a smooth and intuitive user experience.

## Caching: 
Caching is implemented using **URLSession** caching. There is also commented code to cache using **SwiftData** for previously fetched **NowPlaying** movie data.

## Code Quality: 
Best practices for code quality, readability, and maintainability are followed, adhering to Swift coding conventions.

