import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetbook/Rootes/root_page.dart';

class ProfileScreenClass extends GetxController{

  final keyChangeMail = GlobalKey<FormState>();
  TextEditingController email_field = TextEditingController();

   ChangeMails() async {
    if(keyChangeMail.currentState!.validate())
    { 
      showLoading();

      var data = {"emails": email_field.text};
      Uri url  = Uri.parse("https://www.leaseframe.com/hackathon/register_etape1.php");
      var resp = await http.post(url , body: data);
      var respbody = jsonDecode(resp.body);

      if(respbody['status'] == 'success')
      {
        Future.delayed(Duration(milliseconds: 2000), () {
          hideLoading();

          Get.toNamed(Routes.VERIFICATIONCODE,arguments: email_field.text);
            
        });
      }
      else if(respbody['status'] == 'confEmail')
      {
        hideLoading();
        showErrorDialog(description: "Cet Email existe déjà !");       
      }
      else
      {
        hideLoading();
        showErrorDialog(description: "Désolé une erreur technique est survenue lors de la création de compte réessayer svp!");
      }
    }
  }

  showLoading({String title = "Encours de traitement...."}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 40,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  hideLoading(){
    Get.back();
    if(Get.isBottomSheetOpen!)
    {
      Get.back();
    }
  }

  showErrorDialog({String title = "Oops Error",String description = "Veuillez saisir vos identifiants"}) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}