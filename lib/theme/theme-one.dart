import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//-- ! start section ! this color code using for changing background color of Scaffold --
const backgroundColor= Color(0xFFF1F1F1);
//-- ! end section ! this color code using for changing background color of Scaffold --

//-- ! start section ! this color code using for changing the card shadow --
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
//-- ! end section ! this color code using for changing the card shadow --

//-- ! start section ! gradient colors which use for coloring the containers --
const yellowGradient= [

  Color(0xFFECA601),
Color(0xFFE47801),
];
const orangeGradient= [

  Color(0xFFEC5845),
  Color(0xFFED6248),
];
const purpleGradient= [
  Color(0xFF954DB8),
  Color(0xFF4A279A),


];
//--! end section ! gradient colors which use for coloring the containers --
const textTittleColor = Color(0xFF000000);
const textSubTittleColor = Color(0xFFB9BDC6);
const white = Color(0xFFFFFFFF);
const accentColor = Color(0xFF231D4C);
const colorPrimary = Color(0xFFFF725E);
const colorPrimaryDark = Color(0xFFF16854);

var kTitleStyle = GoogleFonts.questrial(
  fontSize: 15.0,
  color: textTittleColor,
  fontWeight: FontWeight.w100,
);

var kSubtitleStyle = GoogleFonts.questrial(
  fontSize: 12.0,
  color: textSubTittleColor,
);