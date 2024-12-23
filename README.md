# Weather App

A scalable weather application designed with a clean architecture approach.
The app is organized into three distinct layers: **Data**, **Domain**, and **Presentation**, ensuring modularity, testability, and ease of maintenance. 
Every layer is thoroughly covered with **unit** and **widget tests** to ensure high reliability and code quality.

---

## Architecture Overview

The application is structured into the following layers:

### 1. **Data Layer**
Located in the `packages` folder, this layer handles:
- **API Client**: Responsible for interacting with external APIs to fetch weather-related data.
- **Storage Client**: Manages local persistence using a caching mechanism for app settings or other data.

### 2. **Domain Layer**
This layer serves as the business logic of the application and includes:
- **Models**: Define the core data structures used throughout the app.
- **Repositories**: Act as an intermediary between the data and presentation layers, abstracting data sources (e.g., API, storage) from the rest of the app.

### 3. **Presentation Layer**
This layer focuses on the user interface and application state:
- Utilizes the [**Bloc**](https://bloclibrary.dev/) library for effective state management.
- Includes widgets, views, and UI logic, ensuring a clear separation of concerns from the underlying data.

---

## Features

- **Search**: Search desired location to fetch accurate weather data.
- **Weather Forecast**: Fetch and display accurate weather data for various locations.
- **Settings Management**: Customize data units (Metric or Imperial) with stateful persistence.
- **Comprehensive Testing**: Every layer is covered with:
  - **Unit Tests**: Ensures the functionality of individual components, such as models, repositories, and utilities.
  - **Widget Tests**: Validates the UI elements and interactions.
- **Clean Architecture**: Highly modular structure ensures better code readability and testability.

