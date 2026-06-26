# i-Pack Mobile App

A modern Flutter mobile application for insurance policy management with a beautiful, responsive UI.

## Features

- **Platform-Independent Navigation**: Back icons adapt to iOS and Android platforms
- **Google Fonts**: Integrated Google Fonts (Inter) for consistent typography
- **Gesture Detection**: Interactive forgot password screen with gesture support
- **Responsive Design**: All screens adapt to different screen sizes
- **Responsive Fonts**: Font sizes scale based on screen dimensions
- **Smooth Animations**: Beautiful animations using flutter_animate
- **Material Design 3**: Modern UI with Material Design 3 components
- **Dark/Light Theme**: Support for both dark and light themes

## Screens

- **Splash Screen**: Animated splash with logo
- **Onboarding**: User onboarding flow
- **Login**: Secure login with validation
- **Register**: User registration with form validation
- **Forgot Password**: Password reset with gesture detection
- **Home**: Dashboard with policy overview
- **Policies**: View and manage insurance policies
- **Claims**: File and track insurance claims
- **Notifications**: View alerts and notifications
- **Profile**: User profile management

## Tech Stack

- **Framework**: Flutter 3.12.2+
- **State Management**: Flutter Bloc
- **Dependency Injection**: Get It + Injectable
- **Networking**: HTTP + Cached Network Image
- **Local Storage**: Shared Preferences
- **Animations**: Flutter Animate + Lottie
- **Icons**: Phosphor Icons + Flutter SVG

## Getting Started

### Prerequisites

- Flutter SDK 3.12.2 or higher
- Dart SDK
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository
```bash
git clone https://github.com/avinashquikboom-code/i-pack-mobile-app.git
```

2. Navigate to the project directory
```bash
cd i-pack-mobile-app
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── config/                 # Dependency injection configuration
├── core/                   # Core functionality
│   ├── constants/         # App constants
│   ├── failures/          # Failure handling
│   ├── theme/             # App theme and colors
│   └── usecases/          # Use case definitions
├── presentation/          # UI layer
│   ├── pages/            # Screen widgets
│   │   ├── auth/         # Authentication screens
│   │   ├── home/         # Home screen
│   │   └── ...
│   └── widgets/          # Reusable widgets
│       ├── buttons/      # Button components
│       ├── cards/        # Card components
│       └── navigation/   # Navigation components
└── main.dart             # App entry point
```

## Features Implemented

✅ Platform-independent back icons
✅ Google Fonts integration
✅ Gesture detection on forgot password screen
✅ Responsive screen layouts
✅ Responsive font sizing
✅ Screen animations
✅ Material Design 3 theming
✅ Dark/Light theme support

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
