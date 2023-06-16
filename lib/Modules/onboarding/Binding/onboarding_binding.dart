import 'package:get/get.dart';
import 'package:meetbook/Modules/onboarding/Classes/onboarding_class.dart';

class OnboardingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<OnboardingClass>(
      OnboardingClass(),
    );
  }

}