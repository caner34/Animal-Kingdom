import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  bool isVisible;

  CustomButton([this.onPressed, this.buttonText = "Start Game", this.isVisible = true]);
  final GestureTapCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: RawMaterialButton(
        fillColor: Colors.green,
        splashColor: Colors.greenAccent,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.face,
                color: Colors.amber,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '$buttonText',
                maxLines: 1,
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ],
          ),
        ),
        onPressed: onPressed,
        shape: const StadiumBorder(),
      ),
      visible: isVisible,
    );
  }
}