// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:market_app/modules/shop_register/cubit/cubit.dart';
import 'package:market_app/modules/shop_register/cubit/states.dart';
import 'package:market_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/shop_layout_cubit.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../shop_login/shop_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopRegisterScreen extends StatelessWidget {
  var fromKey = GlobalKey<FormState>();
  var addresscontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSucsessState) {
            print(state.shopLoginmodel.message);
            print(state.shopLoginmodel.token!);
            CacheHelper.saveData(
                    key: 'token', value: state.shopLoginmodel.token!)
                .then((value) {
              token = state.shopLoginmodel.token!;
              NavigateAndFinish(context, const ShopLayout());
              ShopLayoutCubit.get(context).getHomeData();
            });
            showToast(
                text: state.shopLoginmodel.message!, state: ToastStats.SUCCESS);
          }
          if (state is ShopRegisterErrorState) {
            showToast(text: 'المعلومات خاطئة', state: ToastStats.ERROR);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Colors.transparent,
              //   elevation: 0,
              // ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0).r,
                    child: Form(
                      key: fromKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/logoo.png',
                              width: 200.w,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'سجل الآن',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'سجل الآن للحصول على افضل العروض',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            controller: namecontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14),
                              hintText: 'الاسم',
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الاسم يجب الا يكون فارغ';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            controller: phonecontroller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14),
                              hintText: 'رقم الهاتف',
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'رقم الهاتف يجب الا يكون فارغا';
                              }
                              return null;
                            },
                          ),
                          Text(
                            'يجب ان يكون الرقم سوري  وغير مكرر *',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: addresscontroller,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14),
                              hintText: 'العنوان',
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.location_on),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'العنوان يجب الأ يكون فارغا';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordcontroller,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            obscureText:
                                ShopRegisterCubit.get(context).isPassword,
                            onFieldSubmitted: (value) {
                              if (fromKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).UserRegister(
                                    password: passwordcontroller.text,
                                    address: addresscontroller.text,
                                    fullName: namecontroller.text,
                                    phoneNumber: phonecontroller.text);
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14),
                              hintText: 'كلمة المرور',
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.lock),
                              prefixIcon: InkWell(
                                onTap: () {
                                  ShopRegisterCubit.get(context)
                                      .changePasswoedVisibility();
                                },
                                child:
                                    Icon(ShopRegisterCubit.get(context).suffix),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'كلمة المرور يجب الا تكون فارغة';
                              }
                              if (value.length <= 5) {
                                return 'كلمة المرور يجب الا تكون اقل من 6 محارف';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) {
                              return SizedBox(
                                height: 50.h,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (state is ShopRegisterSucsessState) {}
                                    if (fromKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .UserRegister(
                                              password: passwordcontroller.text,
                                              address: addresscontroller.text,
                                              fullName: namecontroller.text,
                                              phoneNumber:
                                                  phonecontroller.text);
                                    }
                                  },
                                  child: Text(
                                    'تسجيل',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    NavigateAndFinish(
                                        context, ShopLoginScreen());
                                  },
                                  child: Text(
                                    'سجل دخول من هنا',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: PrimaryColor),
                                  )),
                              Text('هل لديك حساب؟',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
