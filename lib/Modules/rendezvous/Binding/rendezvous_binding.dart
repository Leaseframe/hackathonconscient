import 'package:get/get.dart';
import 'package:meetbook/Modules/rendezvous/Classes/rendezvous_class.dart';

class RendezvousBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RendezvousClass>(
      RendezvousClass(),
    );
  }

}