import 'package:get/get.dart';
import 'package:meetbook/Modules/creneau/UI/creneau_ui.dart';
import 'package:meetbook/Modules/finalisationcode/Binding/finalisation_binding.dart';
import 'package:meetbook/Modules/finalisationcode/UI/finalisation_ui.dart';
import 'package:meetbook/Modules/home/UI/home_ui.dart';
import 'package:meetbook/Modules/login/Binding/login_binding.dart';
import 'package:meetbook/Modules/login/UI/login_ui.dart';
import 'package:meetbook/Modules/onboarding/Binding/onboarding_binding.dart';
import 'package:meetbook/Modules/onboarding/UI/onboarding_ui.dart';
import 'package:meetbook/Modules/profilescreen/UI/profilescreen_ui.dart';
import 'package:meetbook/Modules/register/Binding/register_binding.dart';
import 'package:meetbook/Modules/register/UI/register_ui.dart';
import 'package:meetbook/Modules/rendezvous/Binding/rendezvous_binding.dart';
import 'package:meetbook/Modules/rendezvous/UI/rendezvous_ui.dart';
import 'package:meetbook/Modules/reporting/UI/reporting_ui.dart';
import 'package:meetbook/Modules/start/Binding/start_binding.dart';
import 'package:meetbook/Modules/start/UI/start_ui.dart';
import 'package:meetbook/Modules/verificationcode/Binding/verification_binding.dart';
import 'package:meetbook/Modules/verificationcode/UI/verification_ui.dart';
import 'package:meetbook/Modules/welcome/Binding/welcome_binding.dart';
import 'package:meetbook/Modules/welcome/UI/welcome_ui.dart';

part 'root_name.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START;

  static final routes = [
    GetPage(
      name: _Paths.START,
      page: () =>  StartUI(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingUI(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterUI(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginUI(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATIONCODE,
      page: () => VerificationUI(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: _Paths.FINALISATIONCOMPTE,
      page: () => FinalisationUI(),
      binding: FinalisationBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeUI(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeUI(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.RDV,
      page: () => RendezvousUI(),
      binding: RendezvousBinding(),
    ),
    GetPage(
      name: _Paths.REPORTING,
      page: () => ReportingUI(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.CRENEAU,
      page: () => CreneauUI(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.CRENEAU,
      page: () => CreneauUI(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.COMPTE,
      page: () => ProfileScreenUI(),
      binding: WelcomeBinding(),
    ),
  ];
}