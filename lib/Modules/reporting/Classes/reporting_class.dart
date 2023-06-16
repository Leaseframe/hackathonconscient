import 'dart:convert';

import 'package:get/get.dart';
import 'package:meetbook/Config/Api/my_api.dart';

class ReportingClass extends GetxController{
  List DataRdv = [];

    Future<bool> infoRDV() async {

    var res = await CallApi().getDatas('getRdv.php');

      if(res.statusCode == 200){

        var dataRespCa = jsonDecode(res.body);

        DataRdv = dataRespCa;

      }
      else
      {
        DataRdv = [];
      }

    return Future.value(true);
  }
}