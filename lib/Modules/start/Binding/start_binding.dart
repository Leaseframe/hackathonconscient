import 'package:get/get.dart';
import 'package:meetbook/Modules/start/Classes/start_class.dart';

class StartBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<StartClass>(
      StartClass(),
    );
  }

}