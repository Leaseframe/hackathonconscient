import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Config/palette/palette.dart';
import 'package:meetbook/Modules/login/Classes/login_class.dart';
import 'package:meetbook/Modules/widgets/custom_surfix_icon.dart';
import 'package:meetbook/Modules/widgets/default_button.dart';
import 'package:meetbook/Modules/widgets/no_account_text.dart';

class LoginUI extends GetView<LoginClass>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color:Colors.black,
        ),
        title: Text("Connexion",style:TextStyle(color:Colors.black)),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.04),
                  Text(
                    "Content de vous revoir!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Pour Prendre un rendez-vous veuillez vous \nconnecter avec vos informations personnelles",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Get.height * 0.08),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        buildEmailFormField(controller.email_field),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildPasswordFormField(controller.mdp_field),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        Row(
                          children: [
                            // Checkbox(
                            //   value: remember,
                            //   activeColor: kPrimaryColor,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       remember = value;
                            //     });
                            //   },
                            // ),
                            // Text("Se souvenir de moi"),
                            Spacer(),
                            GestureDetector(
                              onTap: (){
                                
                              },
                              child: const Text(
                                "Mot de passe oublié!",
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DefaultButton(
                          text: "Se Connecter",
                          press: () {
                            controller.Login();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  NoAccountText(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField(mdp) {
    return TextFormField(
      obscureText: true,
      validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
      controller: mdp,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Entrer votre password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/svg/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(mails) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern);
        if (value!.isEmpty) {
          return 'Veuillez remplir ce champ';
        } else if(!regex.hasMatch(value)) {
          return 'Email invalide';
        }
        else{
          return null;
        }
      },
      controller: mails,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Entrer votre email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/svg/Mail.svg"),
      ),
    );
  }

}