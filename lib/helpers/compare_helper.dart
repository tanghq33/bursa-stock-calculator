import '../enums/sign_type.dart';

class CompareHelper {
  static bool between(double value, double x, SignType xSign, double y, SignType ySign) {
    if(xSign == SignType.Greater) {
      if (ySign == SignType.Smaller) {
        return (value > x && value < y);
      }
      else if(ySign == SignType.SmallerOrEqual) {
        return (value > x && value <= y);
      }
      else {
        throw new Exception('Invalid Y Sign!');
      }
    }
    else if(xSign == SignType.GreaterOrEqual) {
      if (ySign == SignType.Smaller) {
        return (value >= x && value < y);
      }
      else if(ySign == SignType.SmallerOrEqual) {
        return (value >= x && value <= y);
      }
      else {
        throw new Exception('Invalid Y Sign!');
      }
    }
    else {
      throw new Exception('Invalid X Sign!');
    }
  }
}