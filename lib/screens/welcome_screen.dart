import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation animationCurve;
  late Animation animationTween;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    animationCurve =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);
    animationTween = ColorTween(begin: Colors.orange, end: Colors.white)
        .animate(animationCurve);

    controller.forward();

    animationCurve.addListener(() {
      setState(() {});
      print(animationTween.value);
    });
/*Using animationCurve.addListener and controller.addListener can achieve the same result as long as you use the animationCurve.value for both. The animation object here is just a layer added to the controller object to direct how the animation will progress over time. The animationCurve.values is what will respond to the CurvedAnimation object*/
    // animationCurve.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    //
    // controller.addListener(() {
    //   setState(() {});
    //   // print(controller.value);
    // });
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animationTween.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animationCurve.value * 100,
                  ),
                ),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).width / 9,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade700),
                      speed: Duration(milliseconds: 190),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                title: 'Log In',
                onPressedFunction: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                colour: Colors.lightBlueAccent,
                heroTag: 'loginButton'),
            RoundedButton(
                title: 'Register',
                onPressedFunction: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                colour: Colors.blueAccent,
                heroTag: 'registrationButton'),
          ],
        ),
      ),
    );
  }
}
