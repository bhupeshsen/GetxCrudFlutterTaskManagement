import 'package:flutter/material.dart';
import 'package:medvarsity_task/theme/theme-one.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = colorPrimaryDark,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      decoration: BoxDecoration(
//        border:  Border.all(color: Colors.orange),
          color: color,
          shape: BoxShape.rectangle,
          borderRadius:BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(5, 10), // changes position of shadow
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),

          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}