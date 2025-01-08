# Cinemapedia App

## Summary

**Cinemapedia App** is a Flutter application built with a **Domain-Driven Design (DDD)** architecture. It allows users to discover, browse, and get detailed information about movies, including ratings, and more. The app integrates seamless animations and efficient state management to provide a modern and engaging user experience.

<p align="center">
  <img src="https://via.placeholder.com/200" alt="app-evidence" width="200"/>
</p>  

## Features

Key features of the project include:

- **Domain-Driven Design (DDD)** architecture for scalable and maintainable code.
- **Movie discovery** with details like synopsis, cast, and recommendations.
- **Animations** for enhanced user interaction using the `animate_do` package.
- **Dynamic content** fetched using the `dio` HTTP client.
- **Offline storage** with `isar` for caching and quick access to data.
- **Navigation** with `go_router` for declarative routing.
- **Responsive layouts** using the `flutter_staggered_grid_view` package.
- **State management** powered by `flutter_riverpod`.

## Framework

This project was developed using the [Flutter](https://flutter.dev/) framework.

### Folder Structure

The app follows a **Domain-Driven Design (DDD)** approach with an additional `public/` directory for reusable UI components:

```plaintext
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── utils/
├── features/
│   ├── cinema/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── value_objects/
│   │   │   ├── repositories/
│   │   │   ├── services/
│   │   ├── application/
│   │   │   ├── use_cases/
│   │   │   ├── providers/ (for Riverpod or Provider)
│   │   ├── infrastructure/
│   │   │   ├── models/
│   │   │   ├── repositories/
|   |   |   |── mappers/
│   │   │   ├── data_sources/
│   │   ├── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       ├── controllers/
|   |       |__ delegates/
├── public/
│   ├── home/
│   │   ├── pages/
│   │   ├── widgets/
├── shared/
│   ├── widgets/
│   ├── themes/
│   ├── localization/
│   ├── router/
│   ├── services/
```
The `public/` directory contains shared UI elements such as the home section, which is organized into pages and widgets for modularity and reusability.

## Development Setup

Follow these steps to set up and run the project:

### 1. Clone the repository:
Clone the project from the GitHub repository:
```bash
git clone https://github.com/your-username/cinemapedia_app.git
```

### 2. Navigate to the project directory:
Move into the project folder: 
```bash
cd cinemapedia_app
```

### 3. Create Environment Variables:
Set up the necessary environment variables for the project.

1. Copy the `.env` and `.env.prod` example files provided in the repository:
    ```bash
    cp .env.example .env
    cp .env.example .env.prod
    ```

2. Edit the `.env` file to include your API key:
    ```bash
    API_KEY=YourApiKey
    ```

### 4. Install Dependencies:
Download the required packages and dependencies:
```bash
flutter pub get
```

### 5. Generate Necessary Files:
Run the build runner to generate required files, such as models or serializers:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 6. Run the App:
Launch the app on an emulator or a connected device:
```bash
flutter run
```
The app will automatically reload when you make changes to the source files.

## YAML Configuration
Ensure the following dependencies are included in the `pubspec.yaml` file:
```yaml 
dependencies:
  flutter:
    sdk: flutter
  animate_do: ^3.3.4
  card_swiper: ^3.0.1
  dio: ^5.7.0
  flutter_dotenv: ^5.2.1
  flutter_riverpod: ^2.6.1
  flutter_staggered_grid_view: ^0.7.0
  go_router: ^14.6.2
  intl: ^0.20.1
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  isar_generator: ^3.1.0+1
  build_runner: ^2.4.13
  analyzer: ^5.13.0

flutter:
  uses-material-design: true
  assets:
  - .env
```

## Building the app
To build the project for release, run the following command:
```
flutter build apk
```
This will generate the APK file for Android. For iOS, you can use:
```
flutter build ios
```

## Contribute to this project
You can contribute to this project by submitting issues or pull requests in the [GitHub repository](https://github.com/GonzaloQu3dena/cinemapedia_app). We welcome new ideas, features, and improvements!




