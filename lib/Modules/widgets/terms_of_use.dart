import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meetbook/Modules/widgets/policy_dialog.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "En Créant votre compte, vous acceptez nos\n",
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
              text: "règles et conditions ",
              style: TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showModal(
                    context: context,
                    configuration: FadeScaleTransitionConfiguration(),
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'terme_et_condition.md',
                      );
                    },
                  );
                },
            ),
            TextSpan(text: "Ou notre "),
            TextSpan(
              text: "Politique de confidentialité! ",
              style: TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'terme_et_condition.md',
                      );
                    },
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}