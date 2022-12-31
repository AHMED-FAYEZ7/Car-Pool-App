extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+(@Kau.edu.sa)|(@stu.Kau.edu.sa)")
        .hasMatch(this);
  }

  bool isValidPhone() {
    return RegExp(
        r'^(05)+[0-9]{8}$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
        .hasMatch(this);
  }
}