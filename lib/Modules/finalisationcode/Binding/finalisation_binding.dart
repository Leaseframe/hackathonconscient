import 'package:get/get.dart';
import 'package:meetbook/Modules/finalisationcode/Classes/finalisation_class.dart';

class FinalisationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<FinalisationClass>(
      FinalisationClass(),
    );
  }

}