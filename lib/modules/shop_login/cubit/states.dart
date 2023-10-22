import 'package:market_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoadingInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSucsessState extends ShopLoginStates {
  final ShopLoginModel shoploginmodel;

  ShopLoginSucsessState(this.shoploginmodel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String errorLogin;

  ShopLoginErrorState(this.errorLogin);
}

class ShopchangePasswordVisibilityState extends ShopLoginStates {}
