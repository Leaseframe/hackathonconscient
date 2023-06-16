import 'package:get/get.dart';
import 'package:meetbook/Rootes/root_page.dart';

class StartClass extends GetxController{
  goToOnboardingPage(){
     Get.offAllNamed(Routes.ONBOARDING);
  }
  // @override
  // void onReady() {
  //   super.onReady();
  //   Future.delayed(const Duration(seconds: 10),(){
  //       Get.offAllNamed(Routes.ONBOARDING);
  //   });
  // }
}