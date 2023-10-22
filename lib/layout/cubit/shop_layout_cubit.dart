// ignore: duplicate_ignore
// ignore: depend_on_referenced_packages
// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/models/home_model.dart';
import 'package:market_app/models/products_model.dart';
import 'package:market_app/modules/settings/settings_screen.dart';
import 'package:market_app/shared/components/constants.dart';
import 'package:market_app/shared/network/end_points.dart';
import 'package:market_app/shared/network/remote/dio_helper.dart';
import '../../models/profile_model.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/products/products_screen.dart';
import 'shop_layout_state.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 2;

  List<Widget> bottomScreen = [
    SettingsScreen(),
    ProductsScreen(),
    HomeScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopLayoutChangBottomNavState());
  }

  HomeModel? homeModel;
  Future<void> getHomeData() async {
    try {
      // Set the state to loading
      emit(ShopLoadingHomeDataState());

      // Make the API call using Dio
      final response = await DioHelper.getData(url: HOME, token: token);

      // Handle the response based on your API's behavior
      if (response.statusCode! > 199 && response.statusCode! < 206) {
        // Authentication success
        homeModel = HomeModel.fromJson(response.data);
        print(response.data);

        emit(ShopSuccessHomeDataState());
      } else {
        // Authentication failure
        print('${response.statusCode} error failure');
        emit(ShopErrorHomeDataState());
      }
    } catch (e) {
      // Handle any error that occurred during the API call
      print('api call home $e');
      emit(ShopErrorHomeDataState());
    }
  }

  ProductsModel? productsModel;
  // void getAllProducts() {
  //   emit(ShopLoadingAllProductsState());

  //   DioHelper.getData(
  //     url: PRODUCTS,
  //     token: token,
  //   ).then((value) {
  //     productsModel = ProductsModel.fromJson(value.data);
  //     print('status is Home Data');

  //     emit(ShopSuccessAllProductsState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorAllProductsState());
  //   });
  // }

  Future<void> getAllProducts() async {
    try {
      // Set the state to loading
      emit(ShopLoadingAllProductsState());

      // Make the API call using Dio
      final response = await DioHelper.getData(url: PRODUCTS, token: token);

      // Handle the response based on your API's behavior
      if (response.statusCode! > 199 && response.statusCode! < 206) {
        // Authentication success
        productsModel = ProductsModel.fromJson(response.data);
        print(response.data);
        emit(ShopSuccessAllProductsState());
      } else {
        // Authentication failure
        print('${response.statusCode} error failure');
        emit(ShopErrorAllProductsState());
      }
    } catch (e) {
      // Handle any error that occurred during the API call
      print('api call all $e');
      emit(ShopErrorAllProductsState());
    }
  }

  ProductsModel? productsCategoryModel;
  Future<void> getCategoryProducts({required String categoryName}) async {
    try {
      print(categoryName);
      // Set the state to loading
      emit(ShopLoadingCategoryProductsState());

      // Make the API call using Dio
      final response = await DioHelper.getData(
        url: '$CATEGORYVIEW?query=$categoryName',
        token: token,
      );

      // Handle the response based on your API's behavior
      if (response.statusCode! > 199 && response.statusCode! < 206) {
        // Authentication success
        productsCategoryModel = ProductsModel.fromJson(response.data);
        print(response.data);
        emit(ShopSuccessCategoryProductsState());
      } else {
        // Authentication failure
        print('${response.statusCode} error failure');
        emit(ShopErrorCategoryProductsState());
      }
    } catch (e) {
      // Handle any error that occurred during the API call
      print('api call cate $e');
      emit(ShopErrorHomeDataState());
    }
  }

  ProfileModel? UserModel;
  Future<void> getUserData() async {
    try {
      // Set the state to loading
      emit(ShopLoadingUserDataState());

      // Make the API call using Dio
      final response = await DioHelper.getData(url: PROFILFE, token: token);

      // Handle the response based on your API's behavior
      if (response.statusCode! > 199 && response.statusCode! < 206) {
        // Authentication success
        UserModel = ProfileModel.fromJson(response.data);

        print(UserModel!.message);
        emit(ShopSuccessUserDataState(UserModel!));
      } else {
        // Authentication failure
        print('${response.statusCode} error failure');
        emit(ShopErrorUserDataState(response.statusMessage.toString()));
      }
    } catch (e) {
      // Handle any error that occurred during the API call
      print('api call $e');
      emit(ShopErrorUserDataState(e.toString()));
    }
  }

  Future<void> updateUserData(
      {String? phoneNumber,
      String? address,
      String? fullName,
      String? oldPassword,
      String? newPassword}) async {
    try {
      // Set the state to loading
      emit(ShopLoadingUserDataState());
      print(token);

      // Make the API call using Dio
      final response = await DioHelper.putData(
          url: UPDATE_PROFILE,
          data: {
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'address': address,
            'oldPassword': oldPassword,
            'newPassword': newPassword,
          },
          token: token);

      // Handle the response based on your API's behavior
      if (response.statusCode! > 199 && response.statusCode! < 206) {
        // Authentication success
        //UserModel = ShopLoginModel.fromJson(response.data);
        print(UserModel!.message);
        emit(ShopSuccessUserDataState(UserModel!));
        getUserData();
      } else {
        // Authentication failure
        print('${response.statusCode} error failure');
        emit(ShopErrorUpdateUserState(response.statusMessage.toString()));
      }
    } catch (e) {
      // Handle any error that occurred during the API call
      print('api call ${e}');
      emit(ShopErrorUpdateUserState(e.toString()));
    }
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswoedVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopLayoutChangePasswordVisibilityState());
  }

  IconData suffixNew = Icons.visibility_off_outlined;
  bool isPasswordNew = true;

  void changePasswoedVisibilityNew() {
    isPasswordNew = !isPasswordNew;
    suffixNew = isPasswordNew
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShopLayoutChangePasswordVisibilityState());
  }
}
