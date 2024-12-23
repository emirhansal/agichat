extension ExtensionBool on String? {
  bool isValidEmail() {
    String? value = this;
    if (value == null) {
      return false;
    }
    if (value.isNotEmpty) {
      String pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
      RegExp regex = RegExp(pattern);
      return regex.hasMatch(value);
    } else {
      return false;
    }
  }

  bool isValidPhone() {
    String? value = this;
    if (value == null) {
      return false;
    }
    if (value.isNotEmpty) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regex = RegExp(pattern);
      return regex.hasMatch(value);
    } else {
      return false;
    }
  }

  bool isValidIBAN(String iban) {
    iban = iban.replaceAll(' ', '').replaceAll('-', '');
    RegExp regex = RegExp(r'^TR\d{2}\d{4}\d{1}[0-9A-Z]{16}$');

    if (!regex.hasMatch(iban)) {
      return false;
    }

    String ibanDigits = iban.substring(4) + iban.substring(0, 4);
    int ibanValue = 0;

    for (int i = 0; i < ibanDigits.length; i++) {
      int digit = int.parse(ibanDigits[i], radix: 36);
      ibanValue = (ibanValue * 10 + digit) % 97;
    }

    return ibanValue == 1;
  }

  bool isValidPassword() {
    String? value = this;
    if (value == null) {
      return false;
    }
    if (value.isNotEmpty) {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
      RegExp regExp = RegExp(pattern);
      return regExp.hasMatch(value);
    } else {
      return false;
    }
  }

  bool isValidTCIdentityNumber() {
    if (this == null || this!.isEmpty) {
      return false;
    }
    int identitiyNumber = int.parse(this!);
    if (identitiyNumber.toString().length == 11) {
      if (identitiyNumber.toString().substring(0, 1) != '0') {
        int top = 0;
        for (int i = 0; i < 10; i++) {
          String val = identitiyNumber.toString().substring(i, i + 1);
          top = top + int.parse(val);
        }
        top = top % 10;
        if (top == int.parse(identitiyNumber.toString().substring(10))) {
          return true;
        }
      }
    }
    return false;
  }

  bool isValidTaxNumber() {
    return (this != null && this!.length >= 10);
  }
}
