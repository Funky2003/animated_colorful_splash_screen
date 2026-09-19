import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AnimatedJetStartupScreen extends StatefulWidget {
  const AnimatedJetStartupScreen({super.key});

  @override
  State<AnimatedJetStartupScreen> createState() => _AnimatedJetStartupScreenState();
}

class _AnimatedJetStartupScreenState extends State<AnimatedJetStartupScreen> with TickerProviderStateMixin {

  late final AnimationController _greenBoxAnimationController;
  late Tween<Offset> _greenBoxOffset;

  late final AnimationController _blueBoxAnimationController;
  late Tween<Offset> _blueBoxOffset;

  late final AnimationController _bottomContainerAnimationController;
  late Tween<Offset> _bottomContainerOffset;

  late final AnimationController _jetAnimationController;
  late Tween<Offset> _jetOffset;
  bool _shouldAnimateJet = false;

  @override
  void initState() {
    super.initState();

    ///Green box
    _greenBoxAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    )..forward();
    _greenBoxOffset = Tween(
      begin: const Offset(0.6, 0),
      end: Offset.zero,
    );

    ///Blue box
    _blueBoxAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
    )..forward();
    _blueBoxOffset = Tween(
      begin: const Offset(-0.6, 0),
      end: Offset.zero,
    );

    ///Bottom container
    _bottomContainerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4)
    )..forward();
    _bottomContainerOffset = Tween(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    );

    ///Jet
    _jetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    );
    _jetOffset = Tween(
      begin: const Offset(0, 0),
      end: Offset.zero,
    );


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        _shouldAnimateJet = true;
      });

      if (_shouldAnimateJet) {
        setState(() {
          _jetOffset = Tween(
            begin: Offset.zero,
            end: const Offset(0, -5)
          );
        });

        _jetAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _greenBoxAnimationController.dispose();
    _blueBoxAnimationController.dispose();
    _bottomContainerAnimationController.dispose();
    _jetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xEEFF7171),
              const Color(0xEEFF5050),
            ]
          )
        ),
        child: Stack(
          children: [
            SlideTransition(
              position: CurvedAnimation(
                parent: _bottomContainerAnimationController,
                curve: Curves.easeIn
              ).drive(_bottomContainerOffset),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    SlideTransition(
                      position: CurvedAnimation(
                          parent: _jetAnimationController,
                          curve: Curves.easeIn
                      ).drive(_jetOffset),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: CupertinoColors.systemYellow
                        ),
                        child: Image.asset("assets/images/jet.png"),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 430,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Launch and Grow\nyour startup",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 36.0
                            ),
                            textAlign: TextAlign.center,
                          ),

                          Text(
                            "The average company forecasts a growth\n178% in revenues for their first year, 100%\nfor second, and 71% for third.",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                              height: 2.5
                            ),
                            textAlign: TextAlign.center,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xEEFF7171),
                                        const Color(0xEEFF5050),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xEEFF6A6A)..withValues(alpha: .3),
                                        offset: const Offset(0, 8),
                                        blurRadius: 20
                                      )
                                    ]
                                  ),
                                  child: FilledButton(
                                    onPressed: () {
                                      ///Todo: Move forward
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.transparent
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///Leave a space
                          const SizedBox(height: 4.0)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.deepOrange
                  ),
                  child:  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SlideTransition(
                          position: CurvedAnimation(
                            parent: _greenBoxAnimationController,
                            curve: Curves.easeIn
                          ).drive(_greenBoxOffset),
                          child: Container(
                            width: 180,
                            height: 180,
                            margin: const EdgeInsets.only(
                              right: 40.0
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.lightGreenAccent,
                              image: DecorationImage(
                                image: AssetImage("assets/images/Moon_wind.png")
                              )
                            ),
                          ),
                        ),
                      ),

                      SlideTransition(
                        position: CurvedAnimation(
                          parent: _blueBoxAnimationController,
                          curve: Curves.easeIn
                        ).drive(_blueBoxOffset),
                        child: Container(
                          height: 180,
                          width: 180,
                          margin: const EdgeInsets.only(top: 100.0, left: 15),
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            image: DecorationImage(
                              image: AssetImage("assets/images/Cloud_zap.png")
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
