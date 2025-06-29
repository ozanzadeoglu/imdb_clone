import 'package:flutter/material.dart';

@immutable
class ColorConstants {
  const ColorConstants._();

  static const thamarBlack = Color(0xff191919); //background color
  static const lead = Color(0xff212121);//components in front of background colors. smooth transition but difference is noticable
  static const kinglyCloud = Color(0xffdfdfdf);//grayish color in texts that in front of dark colors and icons
  static const leeryLemon = Color(0xfff3c616);//yellowish color in logos, headlines buttons
  static const white = Color(0xffffffff);//white on search button etc
  static const kettleman = Color(0xff616161);//grayish color in texts that in front of white'ish colors.
  static const offBlack = Color(0xff303030);//components generally in front of lead. Appbar, actors in movie etc
  static const millionGrey = Color(0xff999999);//grayish color in front of other greyish colors.
  static const iconRed = Color(0xffFF0000);
  static const iconBlue = Color(0xff0047AB);
  static const iconYellow = Color(0xffFFC300);
  static const vermillonCinnabar = Color(0xffe14447);//pale red used in remove button of bookmark alert dialog.
}
