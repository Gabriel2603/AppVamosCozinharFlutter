import 'package:flutter/material.dart';
import 'package:telas/models/settings.dart';
import 'package:telas/screens/cadastros_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/settings_screen.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'models/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _avaibleMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];
  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _avaibleMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegana = settings.isVegan && !meal.isVegan;
        final filterVegetariana = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegana &&
            !filterVegetariana;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeal.contains(meal)
          ? _favoriteMeal.remove(meal)
          : _favoriteMeal.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeal.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Vamos Cozinhar?",
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.red,
          secondary: Colors.purple,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: "RobotoCondensed",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
            fontFamily: "RobotoCondensed",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "Raleway",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      ),
      routes: {
        AppRouts.HOME: (context) => TabsScreen(favoriteMeals: _favoriteMeal),
        AppRouts.CATEGORIES_MEALS: (context) =>
            CategoriesMealsScreen(meals: _avaibleMeals),
        AppRouts.MEAL_DETAIL: (context) =>
            MealDetailScreen(onToggleFavorite: _toggleFavorite, isFavorite: _isFavorite),
        AppRouts.SETTINGS: (context) => SettingsScreen(
              onSettingsChanged: _filterMeals,
              settings: settings,
            ),
        AppRouts.CADASTROS: (context) => CadastrosScreen(),
      },
      //Para caso a aplicação tenta entrar em uma tela mas não encontra o
      //caminho ai pode usar para criar uma tela de erro
      //onGenerateRoute: (settings) {
      //  if (settings.name == "/alguma-coisa") {
      //    return null;
      //  } else if (settings.name == "/outra-coisa") {
      //    return null;
      //  } else {
      //    return MaterialPageRoute(builder: (_) {
      //      return CategoriesMealsScreen();
      //    });
      //  }
      //},
      //onUnknownRoute: (settings) {
      //  return MaterialPageRoute(builder: (_) {
      //      return CategoriesMealsScreen();
      //    });
      //},
    );
  }
}
