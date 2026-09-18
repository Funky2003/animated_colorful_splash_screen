import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBallSplashScreen extends StatefulWidget {
  const AnimatedBallSplashScreen({super.key});

  @override
  State<AnimatedBallSplashScreen> createState() => _AnimatedBallSplashScreenState();
}

class _AnimatedBallSplashScreenState extends State<AnimatedBallSplashScreen> with TickerProviderStateMixin {

  late final Tween<Offset> _greenOffset;
  late final AnimationController _greenAnimationController;

  late final Tween<Offset> _yellowOffset;
  late final AnimationController _yellowAnimationController;

  late final Tween<Offset> _pinkOffset;
  late final AnimationController _pinkAnimationController;

  late final Tween<Offset> _purpleOffset;
  late final AnimationController _purpleAnimationController;

  late final AnimationController _rotatingCircleAnimationController;

  bool _showColorBoxes = true;

  bool _showShapedColorBoxes = true;

  bool _shouldReduceBigCircleSize = false;

  bool _showTextAnimation = false;

  @override
  void initState() {

    ///Green box animation
    _greenAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    )..forward();
    _greenOffset = Tween(
      begin: const Offset(1.0, -1.0),
      end: Offset.zero
    );

    ///Yellow box animation
    _yellowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    )..forward();
    _yellowOffset = Tween(
      begin: const Offset(-1.0, 1.0),
      end: Offset.zero
    );

    ///Pink box animation
    _pinkAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
    )..forward();
    _pinkOffset = Tween(
      begin: const Offset(-1.0, -1.0),
      end: Offset.zero
    );

    ///Purple box animation
    _purpleAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
    )..forward();
    _purpleOffset = Tween(
      begin: const Offset(1.0, 1.0),
      end: Offset.zero
    );

    ///Rotating circle
    _rotatingCircleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600)
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _showColorBoxes = false;
        _showShapedColorBoxes = false;
      });

      await Future.delayed(Duration(seconds: 3));
      _rotatingCircleAnimationController.repeat();

      setState(() {
        _shouldReduceBigCircleSize = true;
      });

      await Future.delayed(Duration(seconds: 2));
      setState(() => _showTextAnimation = true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [

            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  AnimatedContainer(
                    height: _showTextAnimation ? 60.0 : 0,
                    width: _showTextAnimation ? 240.0 : 0,
                    duration: Duration(seconds: 1),
                    child: Center(
                      child: Text(
                        "Circle Splash",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 34.0
                        ),
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.yellow.withValues(alpha: 0),
                    child: Expanded(
                      child: AnimatedOpacity(
                        opacity: _showColorBoxes ? 0.0 : 1.0,
                        curve: Curves.easeInOut,
                        duration: const Duration(seconds: 6),
                        child: RotationTransition(
                          turns: _rotatingCircleAnimationController,
                          child: AnimatedContainer(
                            height: _shouldReduceBigCircleSize ? 25 : 400,
                            width: _shouldReduceBigCircleSize ? 25 : 400,
                            duration: const Duration(seconds: 1),
                            margin: const EdgeInsets.symmetric(vertical: 286),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: AlignmentGeometry.topLeft,
                                colors: [
                                  CupertinoColors.activeOrange,
                                  CupertinoColors.systemGreen,
                                  CupertinoColors.systemPurple,
                                  CupertinoColors.systemPink,
                                ]
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Container(
                height: 400,
                width: 400,
                margin: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 286),
                child: AnimatedOpacity(
                  opacity: _showShapedColorBoxes ? 1.0 : 0.0,
                  curve: Curves.easeInOut,
                  duration: const Duration(seconds: 4),
                  child: Stack(
                    children: [
                      SlideTransition(
                        position: CurvedAnimation(
                            parent: _yellowAnimationController,
                            curve: Curves.easeInOut
                        ).drive(_yellowOffset),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Transform.rotate(
                            angle: 150,
                            child: Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.activeOrange
                              ),
                            ),
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: CurvedAnimation(
                            parent: _purpleAnimationController,
                            curve: Curves.easeInOut
                        ).drive(_purpleOffset),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Transform.rotate(
                            angle: 150,
                            child: Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.systemPurple
                              ),
                            ),
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: CurvedAnimation(
                            parent: _pinkAnimationController,
                            curve: Curves.easeInOut
                        ).drive(_pinkOffset),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Transform.rotate(
                            angle: 150,
                            child: Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.systemPink
                              ),
                            ),
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: CurvedAnimation(
                          parent: _greenAnimationController,
                          curve: Curves.easeInOut
                        ).drive(_greenOffset),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Transform.rotate(
                            angle: 150,
                            child: Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGreen
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}
