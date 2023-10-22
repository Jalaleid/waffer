// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, depend_on_referenced_packages, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:market_app/layout/cubit/shop_layout_cubit.dart';
import 'package:market_app/layout/cubit/shop_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:market_app/models/home_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ShopLayoutCubit.get(context).getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            // If something wrong happened.
            return Center(child: Text('An error occurred!'));
          } else {
            return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ShopLoadingAllProductsState ||
                    state is ShopLoadingHomeDataState)
                  return const Center(child: CircularProgressIndicator());

                return HomeBuilder(
                    ShopLayoutCubit.get(context).homeModel!, context);
              },
            );
          }
        });
  }

  Widget HomeBuilder(HomeModel model, context) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: model.Banners!.length,
              itemBuilder: (context, index, realIndex) =>
                  '${BaseURL!}/${model.Banners![index]}' != ""
                      ? FadeInImage.assetNetwork(
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          placeholder: 'assets/images/small.gif',
                          image: '${BaseURL!}${'${model.Banners![index]}'}')
                      : Image.asset(
                          'assets/images/wfer.png',
                          height: 120.h,
                        ),
              options: CarouselOptions(
                  pauseAutoPlayOnTouch: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  viewportFraction: 1.0,
                  height: 230.h,
                  initialPage: 2,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  disableCenter: true),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'المنتجات الجديدة',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 230.h,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: List.generate(
                  ShopLayoutCubit.get(context).productsModel!.products!.length,
                  (index) => BuildproductList(
                      ShopLayoutCubit.get(context).productsModel!,
                      index,
                      context),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الأصناف',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).w,
              child: BuildCategoryGrid(model, context),
            ),
          ],
        ),
      );
}
