
class Validator {
  static String email(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return "This is not a Email Address";
    else
      return null;
  }

  static String password(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return "Please Enter Your Password Again";
    else
      return null;
  }

  static String name(String value) {
    Pattern pattern = r"^[a-zA-Z]+\ ?[a-zA-Z]*";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return "Invalid Name";
    else
      return null;
  }

  static String number(String value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return "Please Enter a Valid value";
    else
      return null;
  }
}