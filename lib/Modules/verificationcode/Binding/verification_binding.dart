import 'package:get/get.dart';
import 'package:meetbook/Modules/verificationcode/Classes/verification_class.dart';

class VerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<VerificationClass>(
      VerificationClass(),
    );
  }

}