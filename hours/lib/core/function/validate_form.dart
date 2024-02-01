import 'package:get/get.dart';

validationEmployeName(String name) {
  if (name.length < 3) {
    return "Enter more than 3 chracters";
  }
  return null;
}

validationEmail(String email) {
  if (!GetUtils.isEmail(email)) {
    return "Enter Valid Email";
  } else {
    return null;
  }
}

validationPassword(String passsword) {
  if (passsword.length < 3) {
    return "can't be less than 3 chacters";
  } else {
    return null;
  }
}
