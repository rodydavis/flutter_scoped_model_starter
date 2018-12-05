import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Duration duration;

  const SplashScreen({@required this.duration});

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        new AnimationController(duration: widget.duration, vsync: this)
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
