import 'package:flutter/material.dart';
import '../../../views/login_page.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();

    // Navigate to main screen after 6 seconds
    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(), // Replace with your main screen
      ));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Red background
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: SizedBox(
            width: 100, // Set the width of the image
            height: 100, // Set the height of the image
            child: Image.asset(
              'images/news.png', // Your app icon
              color: Colors.white,
              colorBlendMode: BlendMode.modulate,
            ),
          ),
        ),
      ),
    );
  }
}
