<h1 align="center">
Foodado Recipe App
</h1>

<p align="center">
This recipe application was developed using Flutter, utilizing the Spoonacular API to retrieve recipes based on user inputs. The application features an SQL database for recipe storage and utilizes SharedPreferences for saving user settings, both are being saved in the device's local storage. State management is handled through the use of Provider, and user authentication is currently being developed through Firebase integration. Featured on <a href="https://flutterawesome.com/a-simple-food-recipe-application/">FlutterAwesome</a> 2022. 
</p>

![](https://github.com/JoakimEineving/Foodado-V2/blob/main/assets/readme_assets/Foodado.gif)


## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/JoakimEineving/Recipe-App-V2.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Navigate to lib/components/models/api_service.dart and enter your apikey from the [spoonacular](https://spoonacular.com/food-api) API

```
String apiKey = "YOUR_API_KEY";
```

### Packages & Tools Used

* [SQFlite](https://pub.dev/packages/sqflite) (Storing recipes locally)
* [Provider](https://pub.dev/packages/provider) (State Management)
* [Path Provider](https://pub.dev/packages/path_provider)
* [Http](https://pub.dev/packages/http)
* [Introduction Screen](https://pub.dev/packages/introduction_screen)
* [Flutter_Html](https://pub.dev/packages/flutter_html)
* [Lottie](https://pub.dev/packages/lottie)
* [Appinio Swiper](https://pub.dev/packages/appinio_swiper)
* [Google Fonts](https://pub.dev/packages/google_fonts)
