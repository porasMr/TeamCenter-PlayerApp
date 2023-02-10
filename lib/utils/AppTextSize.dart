import 'package:flutter/material.dart';
import 'package:team_center/utils/CommonMethod.dart';

class AppTextSize {
  static Widget textSize16(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5),
      maxLines: maxLine,
    );
  }

  static Widget textSize14(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14,
          fontWeight: weight,
          color: color,
          overflow: TextOverflow.ellipsis,
          fontFamily: fontName,
          letterSpacing: 0.5),
      maxLines: maxLine,
    );
  }

  static Widget textSize12(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 12,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5,
          decoration: TextDecoration.none),
      maxLines: maxLine,
    );
  }

  static Widget textSizeShortDesc12(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5,
          decoration: TextDecoration.none),
      maxLines: maxLine,
    );
  }

  static Widget textSizeShortDesc12WithoutMaxline(
      String text, Color color, FontWeight weight, String fontName) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5,
          decoration: TextDecoration.none),
    );
  }

  static Widget textSize10(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 10,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5),
      maxLines: maxLine,
    );
  }

  static Widget textSize8(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 8,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5),
      maxLines: maxLine,
    );
  }

  static Widget textSize20(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5),
      maxLines: maxLine,
    );
  }

  static Widget textSize24(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 24,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5),
      maxLines: maxLine,
    );
  }

  static Widget textSize18(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: weight,
        color: color,
        fontFamily: fontName,
        letterSpacing: 0.5,
      ),
      maxLines: maxLine,
    );
  }

  static Widget textSize28(String text, Color color, FontWeight weight,
      String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 28,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 0.5),
      maxLines: maxLine,
    );
  }

  static Widget textSize16WithExtraLineSpacing(String text, Color color,
      FontWeight weight, String fontName, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16,
          fontWeight: weight,
          color: color,
          fontFamily: fontName,
          letterSpacing: 1.0,
          height: 1.0),
      maxLines: maxLine,
      textAlign: CommonMethod.appLanguage() == "English"
          ? TextAlign.left
          : TextAlign.right,
    );
  }
}
