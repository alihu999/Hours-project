import 'package:get/get.dart';

validationEmployeName(String name) {
  if (name.length < 3) {
    return "Enter more than 3 chracters";
  } else if (!GetUtils.isUsername(name)) {
    return "not valid name";
  } else {
    return null;
  }
}
