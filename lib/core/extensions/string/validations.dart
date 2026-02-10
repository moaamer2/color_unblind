extension Validations on String? {
  bool isEmail() {
    return RegExp(r'^[\w\-\.]+@[A-z0-9\-]+\.[A-z]{2,}$').hasMatch(this ?? '');
  }

  bool isPassword() {
    return RegExp('^(?=(.*[a-z]){${PasswordValidationConditions.numberOfLowercase},})(?=(.*[A-Z]){${PasswordValidationConditions.numberOfUppercase},})(?=(.*[0-9]){${PasswordValidationConditions.numberOfDigits},})(?=(.*[!@#\$%^&*()\\-_+.]){${PasswordValidationConditions.numberOfSpecialCharacters},}).{${PasswordValidationConditions.minLength},}\$').hasMatch(this ?? '');
  }

  bool isName() {
    return hasValue && this!.length >= 2 && RegExp(r'^[a-zA-Z ]+$').hasMatch(this ?? '');
  }

  bool _isDoubleNumber() {
    return hasValue && RegExp(r'^[0-9]{1,}.?[0-9]{0,}$').hasMatch(this ?? '');
  }

  bool _isNumber() {
    return hasValue && RegExp(r'^[0-9]+$').hasMatch(this ?? '');
  }

  bool isPhoneNumber() {
    return hasValue && RegExp(r'^[0-9]+$').hasMatch(this ?? '');
  }

  String _strongLevel(String password){
    List numbers = ['0','1','2','3','4','5','6','7','8','9'];
    List symbols = ['~','!','@','#',r'$','%','^','&','*','(',')','_','-','=','+','[',']','{','}','.','?','؟','<','>',',',';',':','÷','×',r'"',r"'"];
    List lowerletters =  ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
    List upperletters = [];
    for (String element in lowerletters){
      upperletters.add(element.toUpperCase());
    }
    isnumbersexist(String pass){
      for(String i in numbers){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    issymbolsexist(String pass){
      for(String i in symbols){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    islowerlettersexist(String pass){
      for(String i in lowerletters){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    isupperlettersexist(String pass){
      for(String i in upperletters){
        for(int j = 0;j<pass.length;j++){
          if(pass[j] == i){
            return true;
          }
        }
      }
      return false;
    }
    if((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==true)){
      return "very strong";
    }
    else if(((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==true)) || ((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==true)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==true))){
      return "strong";
    }
    else if(((islowerlettersexist(password)==true)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==true)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==true)&&(issymbolsexist(password)==false)) || ((islowerlettersexist(password)==false)&&(isupperlettersexist(password)==false)&&(isnumbersexist(password)==false)&&(issymbolsexist(password)==true))){
      return "weak";
    }
    else{
      return "medium";
    }
  }

  bool get hasValue => this != null && this!.isNotEmpty;
  String get strongLevel => _strongLevel(this ?? '');
  bool get isDouble => _isDoubleNumber();
  bool get isNumber => _isNumber();
}

abstract class PasswordValidationConditions {
  static const int minLength = 8;
  static const int numberOfDigits = 1;
  static const int numberOfSpecialCharacters = 1;
  static const int numberOfUppercase = 1;
  static const int numberOfLowercase = 1;
}
