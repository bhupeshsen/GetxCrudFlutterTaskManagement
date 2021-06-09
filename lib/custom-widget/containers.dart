
import 'package:flutter/material.dart';
import 'package:medvarsity_task/theme/theme-one.dart';


class CustomContainer extends Container {
  CustomContainer({
    Key key,
    this.alignment,
    this.padding,
    this.color,
    this.type,
    this.decoration,
    this.foregroundDecoration,
    double width,
    double height,
    BoxConstraints constraints,
    this.margin,
    this.gradient,
    this.borderType,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.inverted = false,
  }) : constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints;

  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Decoration decoration;
  final Decoration foregroundDecoration;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final Matrix4 transform;
  final AlignmentGeometry transformAlignment;
  final Clip clipBehavior;
  final bool inverted;
  final String type;
  final Color gradient;
  final String borderType;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: this.alignment,
      padding: this.padding,
      color: this.color,
      foregroundDecoration: this.foregroundDecoration,
      constraints: this.constraints,
      margin: this.margin,
      transform: this.transform,
      clipBehavior: this.clipBehavior,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,

          border: borderType=="yes" ? Border.all(
            width: 0, //                   <--- border width here
          ):Border.all(width: 0,color: Colors.white),

          borderRadius: type=="Rectangle" ?BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)) :  BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25)),

          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],


      ),
      child: this.child,
    );
  }
}
