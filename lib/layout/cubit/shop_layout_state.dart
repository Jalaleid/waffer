import '../../models/profile_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates {}

class ShopLayoutChangBottomNavState extends ShopLayoutStates {}

class ShopLoadingHomeDataState extends ShopLayoutStates {}

class ShopSuccessHomeDataState extends ShopLayoutStates {}

class ShopErrorHomeDataState extends ShopLayoutStates {}

class ShopLoadingAllProductsState extends ShopLayoutStates {}

class ShopSuccessAllProductsState extends ShopLayoutStates {}

class ShopErrorAllProductsState extends ShopLayoutStates {}

class ShopLoadingCategoryProductsState extends ShopLayoutStates {}

class ShopSuccessCategoryProductsState extends ShopLayoutStates {}

class ShopErrorCategoryProductsState extends ShopLayoutStates {}

class ShopLoadingUserDataState extends ShopLayoutStates {}

class ShopSuccessUserDataState extends ShopLayoutStates {
  final ProfileModel profileModel;

  ShopSuccessUserDataState(this.profileModel);
}

class ShopErrorUserDataState extends ShopLayoutStates {
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopLayoutStates {}

class ShopSuccessUpdateUserState extends ShopLayoutStates {
  final ProfileModel profileModel;

  ShopSuccessUpdateUserState(this.profileModel);
}

class ShopErrorUpdateUserState extends ShopLayoutStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}

class ShopLayoutChangePasswordVisibilityState extends ShopLayoutStates {}
