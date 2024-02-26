import 'package:flutter/material.dart';
import 'package:study_language_ai_flutter_project/common/component/alert_function.dart';

typedef NextButtonValidator = bool Function();

class NextEndAlert extends StatelessWidget {
  final VoidCallback? onConfirmPressed;
  final String alertMessage;
  final NextButtonValidator validator;
  final String validatorFalseMessage;

  const NextEndAlert({
    required this.onConfirmPressed,
    required this.alertMessage,
    required this.validator,
    required this.validatorFalseMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 8 * 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: InkWell(
            onTap: () {
              alert_function(
                  onConfirmPressed: onConfirmPressed,
                  alertMessage: alertMessage,
                  validator: validator,
                  validatorFalseMessage: validatorFalseMessage,
                  context: context,
              );
            },
            child: Ink(
              child: Text(
                'Next',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.greenAccent, fontSize: 20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
