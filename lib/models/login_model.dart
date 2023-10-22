class ShopLoginModel {
  int? status;
  String? phoneNumberError;
  String? passwordError;
  String? message;
  String? token;

  ShopLoginModel(
      {required this.status,
      required this.message,
      this.token,
      this.passwordError,
      this.phoneNumberError});

  ShopLoginModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    message = json['message'];
    phoneNumberError = json['phoneNumberError'];
    passwordError = json['passwordError'];
    token = json['token'];
  }
}
