part of 'root_page.dart';

abstract class Routes {
  Routes._();
  static const START          = _Paths.START;
  static const WELCOME        = _Paths.WELCOME;
  static const HOME           = _Paths.HOME;
  static const ONBOARDING     = _Paths.ONBOARDING;
  static const REGISTER       = _Paths.REGISTER;
  static const LOGIN           = _Paths.LOGIN;
  static const VERIFICATIONCODE = _Paths.VERIFICATIONCODE;
  static const FINALISATIONCOMPTE = _Paths.FINALISATIONCOMPTE;
  static const RDV             = _Paths.RDV;
  static const REPORTING       = _Paths.REPORTING;
  static const CRENEAU         = _Paths.CRENEAU;
  static const COMPTE          = _Paths.COMPTE;
}

abstract class _Paths {
  _Paths._();
  static const START           = '/start';
  static const WELCOME         = '/welcome';
  static const HOME            = '/home';
  static const ONBOARDING      = '/onboarding';
  static const REGISTER        = '/register';
  static const LOGIN           = '/login';
  static const VERIFICATIONCODE = '/verificationcode';
  static const FINALISATIONCOMPTE = '/finalisationcode';
  static const RDV             = '/rendezvous';
  static const REPORTING       = '/reporting';
  static const CRENEAU         = '/creneau';
  static const COMPTE          = '/profilescreen';
  
}