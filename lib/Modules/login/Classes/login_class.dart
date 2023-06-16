import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetbook/Rootes/root_page.dart';
import 'package:http/http.dart' as http;

class LoginClass extends GetxController{
  final local = GetStorage();

 goToRegister(){
     Get.toNamed(Routes.REGISTER);
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController email_field = TextEditingController();
  TextEditingController mdp_field = TextEditingController();

  Login() async {
    if(formKey.currentState!.validate())
    { 
      showLoading();

      var data = {"emails": email_field.text,"password": mdp_field.text};
      Uri url  = Uri.parse("https://www.leaseframe.com/hackathon/connexion.php");
      var resp = await http.post(url , body: data);
      var respbody = jsonDecode(resp.body);

      if(respbody['status'] == 'success')
      {
        Future.delayed(Duration(milliseconds: 2000), () {
          hideLoading();

          local.write("user_id_connect", respbody['id_user']);

          Get.offAllNamed(Routes.WELCOME);
            
        });
      }
      else if(respbody['status'] == 'fail_email')
      {
        hideLoading();
        showErrorDialog(description: "Désolé ce mail n'existe pas veuillez saisir le bon!");       
      }
      else if(respbody['status'] == 'fail_mdp')
      {
        hideLoading();
        showErrorDialog(description: "Désolé ce mot de pass n'est pas le votre. Veuillez réessayer");       
      }
      else
      {
        hideLoading();
        showErrorDialog(description: "Désolé une erreur technique est survenue lors de la connexion réessayer svp!");
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