import 'package:flutter/material.dart';
import 'package:meetbook/Config/palette/palette.dart';
import 'package:meetbook/Modules/login/Classes/login_class.dart';

// ignore: must_be_immutable
class NoAccountText extends StatelessWidget {
  LoginClass controller;
  NoAccountText({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Si vous n'avez pas de compte? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () {
            controller.goToRegister();
          },
          child: Text(
            "S'inscrire",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: Color(0xFFFF7643)),
          ),
        ),
      ],
    );
  }
}