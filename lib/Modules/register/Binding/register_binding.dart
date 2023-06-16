import 'package:get/get.dart';
import 'package:meetbook/Modules/register/Classes/register_class.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RegisterClass>(
      RegisterClass(),
    );
  }

}