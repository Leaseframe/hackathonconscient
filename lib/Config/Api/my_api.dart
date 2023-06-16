import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CallApi{

  final String _url = 'https://www.leaseframe.com/hackathon/';

  final localStor = GetStorage();

  // envoi de data via l'api 

  postDatas(data, apiUrl) async {

    var fullUrl = _url + apiUrl ;
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
    );
  }

    // suppression des besoins

  getDatas(apiUrl) async {

    var fullUrl = _url + apiUrl ;
    
    return await http.get(
        Uri.parse(fullUrl),
    );
  } 

}