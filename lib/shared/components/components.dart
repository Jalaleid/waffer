// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_app/layout/cubit/shop_layout_cubit.dart';
import 'package:market_app/modules/shop_login/shop_login.dart';
import 'package:market_app/shared/network/local/cache_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/home_model.dart';
import '../../models/products_model.dart';
import '../../modules/category/category_screen.dart';
import '../../modules/detalis/details_screen.dart';
import 'constants.dart';

NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

NavigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void SignOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      NavigateAndFinish(context, ShopLoginScreen());
    }
  });
  ShopLayoutCubit.get(context).currentIndex = 2;
}

void showToast({
  required String text,
  required ToastStats state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStats { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStats state) {
  Color res;

  switch (state) {
    case ToastStats.SUCCESS:
      res = Colors.green;
      break;
    case ToastStats.ERROR:
      res = Colors.red;
      break;
    case ToastStats.WARNING:
      res = Colors.amber;
      break;
    default:
      res = Colors.grey;
  }
  return res;
}

Widget BuildproductGrid(ProductsModel model, int index, context) {
  return InkWell(
    onTap: () {
      NavigateTo(context, DetailsScreen(model: model.products![index]));
    },
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.grey.shade200,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)).r),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          model.products![index].imagePath! != ""
              ? FadeInImage.assetNetwork(
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: 'assets/images/small.gif',
                  image: '${BaseURL!}/${model.products![index].imagePath!}')
              : Image.asset(
                  'assets/images/wfer.png',
                ),
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 5.w, left: 5.w),
            child: Text(model.products![index].itemName!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(model.products![index].m1!,
                maxLines: 1,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w100)),
          ),
          SizedBox(
            height: 5.h,
          )
        ],
      ),
    ),
  );
}

Widget BuildproductList(ProductsModel model, int index, context) {
  return InkWell(
    onTap: () {
      NavigateTo(context, DetailsScreen(model: model.products![index]));
    },
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.grey.shade200,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)).r),
      elevation: 2,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)).r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            model.products![index].imagePath! != ""
                ? FadeInImage.assetNetwork(
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    placeholder: 'assets/images/small.gif',
                    image: '${BaseURL!}/${model.products![index].imagePath!}')
                : Center(
                    child: Image.asset(
                      'assets/images/wfer.png',
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(top: 5.h, right: 5.w, left: 5.w),
              child: Text(model.products![index].itemName!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(model.products![index].m1!,
                  maxLines: 1,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w100)),
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    ),
  );
}

Widget BuildCategoryGrid(HomeModel model, context) {
  return GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 10.w,
    crossAxisSpacing: 10.h,
    childAspectRatio: MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 2.45),
    children: List.generate(
        model.categories!.length,
        (index) => InkWell(
              onTap: () {
                NavigateTo(
                    context,
                    CategoryScreen(
                      model: model.categories![index],
                    ));
                ShopLayoutCubit.get(context).getCategoryProducts(
                    categoryName: model.categories![index]);
              },
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)).r,
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.dstATop),
                              image: new NetworkImage(
                                '${BaseURL!}/${model.categoriesImages![index]}',
                              ),
                            ),
                          ),
                          child: Container(
                            height: 130.h,
                            width: 200.w,
                            child: Center(
                              child: Text(
                                '${model.categories![index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
  );
}
