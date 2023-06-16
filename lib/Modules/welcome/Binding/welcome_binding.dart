import 'package:get/get.dart';
import 'package:meetbook/Modules/creneau/Classes/creneau_class.dart';
import 'package:meetbook/Modules/home/Classes/home_class.dart';
import 'package:meetbook/Modules/reporting/Classes/reporting_class.dart';
import 'package:meetbook/Modules/welcome/Classes/welcome_class.dart';

class WelcomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<WelcomeClass>(
      WelcomeClass(),
    );

    Get.put<HomeClass>(
      HomeClass(),
    );

    Get.put<ReportingClass>(
      ReportingClass(),
    );

    Get.put<CreneauClass>(
      CreneauClass(),
    );
    
  }
}