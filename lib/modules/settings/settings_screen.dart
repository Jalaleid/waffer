// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/layout/cubit/shop_layout_cubit.dart';
import 'package:market_app/layout/cubit/shop_layout_state.dart';
import 'package:market_app/shared/components/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    ShopLayoutCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController addresscontroller = TextEditingController();
    TextEditingController phonecontroller = TextEditingController();
    TextEditingController newpasswordcontroller = TextEditingController();
    TextEditingController oldpasswordcontroller = TextEditingController();

    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {
      if (state is ShopErrorUpdateUserState) {
        showToast(text: 'المعلومات خاطئة', state: ToastStats.ERROR);
      }
    }, builder: (context, state) {
      if (state is ShopLoadingUserDataState ||
          state is ShopLoadingUpdateUserState)
        return Center(
          child: CircularProgressIndicator(),
        );
      var model = ShopLayoutCubit.get(context).UserModel;

      namecontroller.text = model!.name!;
      phonecontroller.text = model.phoneNumber!;
      addresscontroller.text = model.address!;

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0).w,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  textAlign: TextAlign.end,
                  controller: namecontroller,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.person),
                    hintText: "الاسم",
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الاسم يجب الأ يكون فارغا';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  textAlign: TextAlign.end,
                  controller: addresscontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15).r,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.location_on_sharp),
                    hintText: "العنوان",
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'العنوان يجب الأ يكون فارغا';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  textAlign: TextAlign.end,
                  controller: phonecontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.phone),
                    hintText: "رقم الهاتف",
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب الأ يكون الهاتف فارغا';
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
                  textAlign: TextAlign.end,
                  controller: oldpasswordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: ShopLayoutCubit.get(context).isPassword,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.lock),
                    hintText: "كلمة السر القديمة",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    prefixIcon: InkWell(
                      onTap: () {
                        ShopLayoutCubit.get(context).changePasswoedVisibility();
                      },
                      child: Icon(ShopLayoutCubit.get(context).suffix),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'كلمة السر يجب الأ تكون فارغة';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  textAlign: TextAlign.end,
                  controller: newpasswordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: ShopLayoutCubit.get(context).isPasswordNew,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.lock),
                    hintText: "كلمة السر الجديدة  (اختياري)",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    prefixIcon: InkWell(
                      onTap: () {
                        ShopLayoutCubit.get(context)
                            .changePasswoedVisibilityNew();
                      },
                      child: Icon(ShopLayoutCubit.get(context).suffixNew),
                    ),
                  ),
                ),
                Text(
                  'كلمة المرور يجب الا تكون اقل من 6 محارف *',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopLayoutCubit.get(context).updateUserData(
                              fullName: namecontroller.text,
                              phoneNumber: phonecontroller.text,
                              newPassword: namecontroller.text,
                              oldPassword: oldpasswordcontroller.text,
                              address: addresscontroller.text);
                          newpasswordcontroller.clear();
                          oldpasswordcontroller.clear();
                        }
                      },
                      child: Text(
                        'تحديث الملف الشخصي',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                      onPressed: () {
                        SignOut(context);
                      },
                      child: Text("تسجيل خروج",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white))),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
