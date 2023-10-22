// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/models/login_model.dart';

import 'package:market_app/modules/shop_register/cubit/states.dart';
import 'package:market_app/shared/network/end_points.dart';
import 'package:market_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopLoadingInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  Future<void> UserRegister(
      {String? phoneNumber,
      String? password,
      String? address,
      String? fullName}) async {
    try {
      // Set the state to loading

      emit(ShopRegisterLoadingState());

      // Make the API call using Dio
      final response = await DioHelper.postData(
        url: REGISTER,
        data: {
          'phoneNumber': phoneNumber,
          'password': password,
          'address': address,
          'fullName': fullName
        },
      );

      // Handle the response based on your API's behavior
      if (response.statusCode! > 199 && response.statusCode! < 206) {
        // Authentication success
        ShopLoginModel shopLoginModel;
        shopLoginModel = ShopLoginModel.fromJson(response.data);
        print(shopLoginModel.message);
        emit(ShopRegisterSucsessState(shopLoginModel));
      } else {
        // Authentication failure
        print('${response.statusCode} error failure');
        emit(ShopRegisterErrorState(response.statusMessage.toString()));
      }
    } catch (e) {
      // Handle any error that occurred during the API call
      print('api call $e');
      emit(ShopRegisterErrorState(onError.toString()));
    }
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswoedVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  // function to implement the google signin

// creating firebase instance
}
