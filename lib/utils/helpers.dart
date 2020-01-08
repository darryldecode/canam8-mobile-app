import 'package:color/color.dart';

class Helpers {

  static String substringEllipsis(String string, int maxChars) {

    if(string.length < maxChars) return string;

    String newString = string.substring(0,maxChars);

    if(string.length > maxChars) {
      newString += '...';
    }

    return newString;
  }

  static Map<String,num> hexToRGB(String hexColor) {
    HexColor hex = new HexColor(hexColor.replaceAll('#', ''));

    return hex.toRgbColor().toMap();
  }
}