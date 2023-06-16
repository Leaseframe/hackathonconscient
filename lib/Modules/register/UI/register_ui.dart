import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Config/Utils/values.dart';
import 'package:meetbook/Modules/register/Classes/register_class.dart';
import 'package:meetbook/Modules/widgets/custom_button.dart';
import 'package:meetbook/Modules/widgets/spaces.dart';

class RegisterUI extends GetView<RegisterClass>{
  @override
  Widget build(BuildContext context) {
    double marginFromSafeArea = 24;
    var heightOfScreen = MediaQuery.of(context).size.height - marginFromSafeArea;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: heightOfScreen * 0.6,
                child: _buildInscription(context),
              ),
              Container(
                height: heightOfScreen * 0.3,
                child: _buildCodeCard(context,controller.email_field),
              ),
              SizedBox(height: heightOfScreen * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInscription(cnt) {
    var widthOfScreen = Get.width;
    var heightOfScreen = Get.height - 24;
    //var textTheme = Theme.of(cnt).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: Sizes.MARGIN_16),
      child: Stack(
        children: <Widget>[
          Image.asset(
            ImagePath.TWINKLE,
            width: widthOfScreen,
            height: heightOfScreen * 0.4,
          ),
          Container(
            height: heightOfScreen * 0.6,
            child: Column(
              children: <Widget>[
                Image.asset(
                  ImagePath.REGISTER,
                  width: widthOfScreen,
                  height: heightOfScreen * 0.4,
                ),
                SpaceH8(),
                ListBody(
                  mainAxis: Axis.vertical,
                  children: <Widget>[
                    const Text(
                      StringConst.REGISTRATION,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    SpaceH12(),
                    const Text(
                      StringConst.MAIL_SEND,
                      textAlign: TextAlign.center,
                    ),
                    SpaceH12(),
                    const Text(
                      StringConst.RECEVOIR_CODE,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeCard(cxt,emails) {
    //var textTheme = Theme.of(cxt).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.MARGIN_16,
        vertical: Sizes.MARGIN_16,
      ),
      child: Form(
        key: controller.formKey,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.RADIUS_8),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Sizes.MARGIN_20,
              vertical: Sizes.MARGIN_20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 5,right: 5),
                  child: Material(
                    elevation: 10.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: TextFormField(
                      controller: emails,
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20 * 0.75,
                          horizontal:20
                        ),
                        fillColor: Colors.white,
                        hintText: "Ex : example@gmail.com",
                        suffixIcon: Icon(
                          Icons.email,
                          size: 25.0,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  title: StringConst.GET_CODE,
                  onPressed: (){
                    controller.Register();
                  },
                  textStyle: TextStyle(
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
