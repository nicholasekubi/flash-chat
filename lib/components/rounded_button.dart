import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.title,
      required this.onPressedFunction,
      required this.colour,
      required this.heroTag});
  final String title;
  final Function() onPressedFunction;
  final Color colour;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Hero(
        tag: heroTag,
        child: Material(
          elevation: 5.0,
          color: colour,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: onPressedFunction,
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
