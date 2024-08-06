import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp_4/views/home.dart';
import 'package:newsapp_4/views/login_page.dart';
import 'package:newsapp_4/views/sign_up_page.dart';
import 'features/app/splash_screen/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
      await Firebase.initializeApp(
      options: FirebaseOptions(
      apiKey: "AIzaSyCUwxnuA8oZyFf83JAjPHA4DGXLCOWqyOE",
      projectId: "newsapp-9bb11",
      storageBucket: "newsapp-9bb11.appspot.com",
      messagingSenderId: "605349195749",
      appId: "1:605349195749:web:cf36155d2cf2723105490c"
      ),);
  }else
    {
    await Firebase.initializeApp();
    }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newsapp_4',
      // debugShowCheckedModeBanner: false,
      // home: Home(),
      // theme: ThemeData(
      //   primaryColor: Colors.white,
      // ),
      routes: {
        '/': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => Home(),
      },


    );
  }
}

