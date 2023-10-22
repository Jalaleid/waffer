// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:market_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../layout/cubit/shop_layout_cubit.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../shop_register/shop_register.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var fromKey = GlobalKey<FormState>();
  var phoncontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucsessState) {
            CacheHelper.saveData(
                    key: 'token', value: state.shoploginmodel.token!)
                .then((value) {
              token = state.shoploginmodel.token!;
              NavigateAndFinish(context, const ShopLayout());
              ShopLayoutCubit.get(context).getHomeData();
            });
            showToast(
                text: state.shoploginmodel.message!, state: ToastStats.SUCCESS);
          } else if (state is ShopLoginErrorState) {
            showToast(text: 'المعلومات خاطئة', state: ToastStats.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0.h),
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
                          //algazzar.abdelrahman@gmail.com
                          'اهلا بعودتك',
                          style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'سجل دخول الآن لتحصل على افضل العروض',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoncontroller,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.all(14),
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
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordcontroller,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        onFieldSubmitted: (value) {
                          if (fromKey.currentState!.validate()) {
                            ShopLoginCubit.get(context);
                          }
                        },
                        obscureText: ShopLoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.all(14),
                          hintText: 'كلمة المرور',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(Icons.lock_outline),
                          prefixIcon: InkWell(
                            onTap: () {
                              ShopLoginCubit.get(context)
                                  .changePasswoedVisibility();
                            },
                            child: Icon(ShopLoginCubit.get(context).suffix),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'كلمة المرور يجب الا تكون فارغة';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) {
                          return SizedBox(
                            height: 45.h,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (state is ShopLoginSucsessState) {}
                                if (fromKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).login(
                                      phoncontroller.text,
                                      passwordcontroller.text);
                                }
                              },
                              child: Text(
                                'تسجيل دخول',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          );
                        },
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
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
                                    context, ShopRegisterScreen());
                                //NavigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(
                                'سجل من هنا',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: PrimaryColor),
                              )),
                          Text('هل ليس لديك حساب بالفعل؟',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      )
                    ],
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
