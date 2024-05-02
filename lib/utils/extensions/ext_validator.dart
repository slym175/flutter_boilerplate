import 'package:flutter/cupertino.dart';
import 'package:metalbox/utils/extensions/ext_context.dart';

extension ExtString on String? {
  String get validator => this ?? '';

  String? validatorTextField(
    BuildContext context, {
    String? msg,
    TextInputType type = TextInputType.text,
    String? textConfirm,
    int? minLength,
  }) {
    if (validator.isEmpty) {
      return msg ?? context.locale.notEmpty;
    }

    /// check phone
    final phone = int.tryParse(validator);
    if (phone == null && type == TextInputType.phone) {
      return msg ?? context.locale.phoneError;
    }
    if (validator.length != 10 && type == TextInputType.phone) {
      return msg ?? context.locale.phoneError;
    }
    if (!validator.startsWith('0') && type == TextInputType.phone) {
      return msg ?? context.locale.phoneError;
    }

    /// check email
    final isEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!isEmail.hasMatch(validator) && type == TextInputType.emailAddress) {
      return msg ?? context.locale.emailError;
    }

    /// check password
    if (minLength != null &&
        validator.length < minLength &&
        type == TextInputType.visiblePassword) {
      return msg ?? context.locale.passwordLength(minLength ?? 0);
    }

    /// check confirmation password
    if (textConfirm != null &&
        this != textConfirm &&
        type == TextInputType.visiblePassword) {
      return msg ?? context.locale.passwordConfirmationError;
    }

    return msg;
  }
}
