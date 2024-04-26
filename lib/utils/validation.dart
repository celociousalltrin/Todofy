extension ValidateString on String {
  dynamic get titleValidation {
    if (length > 2 && length < 10) {
      return null;
    }
    return "Tittle needs to be in length of 2 to 10";
  }

  dynamic get descriptionvalidation {
    if (length > 2) {
      return null;
    }
    return "Description needs to have Character more than 3";
  }

  dynamic get emailValidation {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (emailRegex.hasMatch(this)) {
      return null;
    }
    return "Email needs to be valid";
  }

  dynamic get passwordValidation {
    RegExp passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (passwordRegex.hasMatch(this)) {
      return null;
    }
    return "Password needs to be valid";
  }
}
