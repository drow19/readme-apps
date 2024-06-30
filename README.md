# Workplaze Project

A Workplaze project created in flutter using GetIt and Provider.

## Getting Started

Please install and setup an editor before clone this project.

```
https://docs.flutter.dev/get-started/
```

## Tutorials

The Flutter tutorials teach you how to use the Flutter framework to build mobile applications for iOS and Android.

```
https://docs.flutter.dev/reference/tutorials
```

## How to use the project

**Step 1:**

Clone this repo by using the link with account has access permission this repository below:

```
https://github.com/drow19/readme-apps
```

```
git clone https://github.com/drow19/readme-apps.git
```

or

```
git clone git@github.com:drow19/readme-apps.git
```

Alternative, you can clone this repo by sourcetree with account has access permission this repository.
Download sourcetreeapp the link below:

```
https://www.sourcetreeapp.com/
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**
add `{flutter_path}\\.pub-cache\bin` to your system PATH

---

If terminal show warning "pub installs executables into {flutter_path}\\.pub-cache\bin, which is not on your path.
You can fix that by adding that directory to your system's "Path" environment variable.",take these steps to add mason_cli to the PATH environment variable:

- For window

  1.From the Start search bar, enter ‘env’ and select Edit environment variables for your account.

  2.Under User variables check if there is an entry called Path

    - If the entry exists, append the full path to {flutter_path}\\.pub-cache\bin using ; as a separator from existing values.

    - If the entry doesn’t exist, create a new user variable named Path with the full path to {flutter_path}\\.pub-cache\bin as its value.

\*\* {flutter_path} is Desired installation location for the Flutter SDK

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Hide Generated Files

In-order to hide generated files, navigate to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines under `ignore files and folders` section:

```
*.inject.summary;*.inject.dart;*.g.dart;
```

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add the following patterns:

```
**/*.inject.summary
**/*.inject.dart
**/*.g.dart
```

## Flutter Features:

- Splash
- Login
- Home
- Routing
- Dio
- Database
- Provider (State Management)
- Validation
- Code Generation
- Dependency Injection

### Libraries & Tools Used

- [Dio](https://github.com/flutterchina/dio)
- [Database](https://github.com/tekartik/sembast.dart)
- [Provider](https://github.com/rrousselGit/provider) (State Management)
- [Notifications](https://github.com/AndreHaueisen/flushbar)
- [Json Serialization](https://github.com/dart-lang/json_serializable)
- [Dependency Injection](https://github.com/fluttercommunity/get_it)

### Folder Structure

Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- constants/
|- data/
|- ui/
|- utils/
|- widgets/
|- main.dart
|- routes.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- data - Contains the data layer of your project, includes directories for local, network and shared pref/cache.
3- stores - Contains store(s) for state-management of your application, to connect the reactive data of your application with the UI.
4- ui — Contains all the ui of your project, contains sub directory for each screen.
5- util — Contains the utilities/common functions of your application.
6- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.
7- routes.dart — This file contains all the routes for your application.
8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- app_theme.dart
|- dimens.dart
|- preferences.dart
|- strings.dart
```

### Data

All the business logic of your application will go into this directory, it represents the data layer of your application. It is sub-divided into three directories `local`, `network` and `sharedperf`, each containing the domain specific logic. Since each layer exists independently, that makes it easier to unit test. The communication between UI and data layer is handled by using central repository.

```
data/
|- local/
    |- keys
    |- shared_preferences

|- network/
    |- base_api
    |- book_api

|- repositories
    |- book_repository

|- dio_client.dart

```

### Stores

The store is where all your application state lives in flutter. The Store is basically a widget that stands at the top of the widget tree and passes it's data down using special methods. In-case of multiple stores, a separate folder for each store is created as shown in the example below:

```
stores/
|- login/
    |- login_store.dart
    |- form_validator.dart
```

### UI

This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory as shown in the example below:

```
ui/
|- UI
   |- my_app.dart
   |- detail/
      |- detail_screen.dart
      |- detail_screen_provider.dart
   |- home/
      |- favorite/
         |- favorite_screen.dart
         |- favorite_screen_provider.dart
      |- home/
         |- home_screen.dart
         |- home_screen_provider.dart
      |- profile/
         |- profile_screen.dart
         |- profile_screen_provider.dart
      |- user/
         |- user_screen.dart
         |- user_screen_provider.dart
      |- main_screen.dart
      |- main_screen_provider.dart
   |- introduction/
      |- login/
         |- login_screen.dart
         |- login_screen_provider.dart
      |- register/
         |- register_screen.dart
         |- register_screen_provider.dart
      |- splash/
         |- splash_screen.dart
         |- splash_screen_provider.dart
   
```

### Utils

Contains the common file(s) and utilities used in a project. The folder structure is as follows:

```
utils/
|- favorite_helper.dart
|- extention
   |- extention.dart
|- permission
  |- m_permission_access.dart
```

### Widgets

Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.

```
widgets/
|- appbar/
|- button/
|- cache_image/
|- input_field/
```

### Routes

route.dart file contains all the routes for your application.

```dart
import 'package:flutter/material.dart';
import 'package:book_store_apps/ui/home_screen.dart';
import 'package:book_store_apps/ui/login_screen.dart';

class ReadmeRoute {
  ReadmeRoute._();

  static Map<String, WidgetBuilder> routes = {
    LoginPage.routeName: (context) => const LoginPage(),
    HomePage.routeName: (context) => const HomePage(),
  };
}

```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:workplaze/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'ui/splash/splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: SplashScreen(),
    );
  }
}
```

## Wiki

None

## Conclusion

None

# How to run flutter apps on android device

1. You need to connect device with USB Cable
2. Enable Developer Option & USB Debugging from device settings
3. If you’re not finding developer option, goto about phone, tap build number for multiple times
4. Execute `flutter devices` to check connected devices
5. Execute `flutter run` to run your app on device

# How to run flutter apps on Android device wirelessly (remotely)

1. Follow the above step & make sure you’ve successfully run the app
2. Then execute `adb tcpip 5555`
3. Check your device IP address (Make sure, all your device is connected on same network
4. execute `adb connect YOURIP:5555`
5. Remove USB & Execute `flutter devices` & `flutter run`

# Generate new files

## Generate new screen

```bash
$ mason make screen --name {{type_your_screen_name_here}}
```

### example

```bash
$ mason make screen --name leave-request
```

## Generate new stateful widget

```bash
$ mason make stateful_widget --name <type_your_widget_name_here>
```

### example

```bash
$ mason make stateful_widget --name date-picker
```

## Generate new stateless widget

```bash
$ mason make stateless_widget --name <type_your_widget_name_here>
```

### example

```bash
$ mason make stateless_widget --name date-picker
```

## Generate new provider

```bash
$ mason make provider --name <type_your_provider_name_here>
```

### example

```bash
$ mason make store --name leave-request
```

# Build Workplaze IOS

1. Pull from origin/develop
2. Change version on **pubspec.yaml** and **package.json**
3. Create branch release/<your version>(<build number>)
4. Run command `- npm run build --previous-version=<version+build number>` (ex. - npm run build --previous-version=0.0.4+61)
5. Go to **Xcode** and then run some emulator to check your app work fine
6. Select Device to “Any iOS device (arm64)”
7. On top of screen, Click Product => Archive => Validate => Distribute => Done

# See Log and make annotation model
1. See log :
- ```Log.colorGreen("message");``` or check in in file logger.dart
2. generate json annotaion
- run ```make runner``` in terminal
