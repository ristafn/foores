import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:foores/view/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        nextScreen: MainScreen(),
        splash: Container(
          child: Column(
            children: <Widget>[
              Container(
                  width: 200.0,
                  height: 200.0,
                  child: Image.asset('assets/logo.png')),
              SizedBox(height: 10.0),
              Text(
                'Food Recipes',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lobster',
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        centered: true,
        animationDuration: Duration(seconds: 2),
        duration: 4000,
        splashIconSize: 300.0,
        backgroundColor: Colors.deepPurple,
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
      ),
    );
  }
}
