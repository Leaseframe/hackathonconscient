import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meetbook/Config/Utils/values.dart';
import 'package:meetbook/Modules/verificationcode/Classes/verification_class.dart';
import 'package:meetbook/Modules/widgets/custom_button.dart';
import 'package:meetbook/Modules/widgets/spaces.dart';

class VerificationUI extends StatefulWidget {
  const VerificationUI({super.key});

  @override
  State<VerificationUI> createState() => _VerificationUIState();
}

class _VerificationUIState extends State<VerificationUI> {
  late Timer timers;
  int starts = 59;

  VerificationClass controller = VerificationClass();

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double marginFromSafeArea = 24;
    var textTheme = Theme.of(context).textTheme;
    var heightOfScreen = MediaQuery.of(context).size.height - marginFromSafeArea;
    
    var data = Get.arguments;
    final DataDoc  = data;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: heightOfScreen * 0.6,
                child: _buildVerification(DataDoc),
              ),
              Container(
                height: heightOfScreen * 0.3,
                child: _buildCodeCard(controller.code_un,controller.code_deux,controller.code_trois,controller.code_quatre,controller.formKey),
              ),
              Center(
                child: Text(
                  "${StringConst.RESEND_CODE}$starts",
                  style: textTheme.subtitle1!.copyWith(
                    color: AppColors.violetShade1,
                  ),
                ),
              ),
              SizedBox(height: heightOfScreen * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerification(mails) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    var heightOfScreen = MediaQuery.of(context).size.height - 24;
    //var textTheme = Theme.of(context).textTheme;

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
                  ImagePath.VERIFICATION,
                  width: widthOfScreen,
                  height: heightOfScreen * 0.4,
                ),
                SpaceH8(),
                ListBody(
                  mainAxis: Axis.vertical,
                  children: <Widget>[
                    Text(
                      StringConst.VERIFICATION,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    SpaceH12(),
                    Text(
                      StringConst.ENTER_CODE,
                      textAlign: TextAlign.center,
                    ),
                    SpaceH12(),
                    Text(
                      StringConst.ENVOYE + " ${mails}",
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

  Widget _buildCodeCard(code_un,code_deux,code_trois,code_quatre,keyForm) {
    //var textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.MARGIN_16,
        vertical: Sizes.MARGIN_16,
      ),
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
              Form(
                key: keyForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 64,
                      height: 68,
                      child: TextFormField(
                        controller: code_un,
                        onChanged: (value) {
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "0",
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 64,
                      height: 68,
                      child: TextFormField(
                        controller: code_deux,
                        onChanged: (value) {
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "0",
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 64,
                      height: 68,
                      child: TextFormField(
                        controller: code_trois,
                        onChanged: (value) {
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "0",
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 64,
                      height: 68,
                      child: TextFormField(
                        controller: code_quatre,
                        onChanged: (value) {
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "0",
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                )
              ),
              CustomButton(
                title: StringConst.VERIFY,
                onPressed: () {
                  controller.Verification();
                },
                textStyle: TextStyle(
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timers = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (starts < 1) {
            starts = 59;
          } else {
            starts = starts - 1;
          }
        },
      ),
    );
  }

}