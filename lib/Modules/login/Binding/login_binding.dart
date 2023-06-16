import 'package:get/get.dart';
import 'package:meetbook/Modules/login/Classes/login_class.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginClass>(
      LoginClass(),
    );
  }

}