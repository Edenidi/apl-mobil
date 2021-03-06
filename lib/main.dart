import 'package:flutter/material.dart';
import 'package:flutter_app/recipeBox.dart';
import 'package:flutter_app/recipeListScreen.dart';
import 'package:flutter_app/recipeScreen.dart';
import 'package:flutter_app/recipeformscreen.dart';

import 'ma_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RecipeBox.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: pageacceuil(),//we call the function, in the file 'my_page'

    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/' :
        return MaterialPageRoute(builder: (context) => RecipeListScreen());
      case '/recipe':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation)=> RecipeScreen(recipe: settings.arguments),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(curve: Curves.ease, parent: animation);
              return FadeTransition(
                opacity:animation,
                child: child,
              );
            }
        );
      case '/newRecipe':
        return MaterialPageRoute(builder: (context) => RecipeFormScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title:Text("Error"), centerTitle: true),
              body: Center(
                child: Text("Page not found"),
              )
            )
        );
    }
  }
}
