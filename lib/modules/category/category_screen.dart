// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/components/components.dart';
import '../../layout/cubit/shop_layout_cubit.dart';
import '../../layout/cubit/shop_layout_state.dart';

class CategoryScreen extends StatelessWidget {
  String model;

  CategoryScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ShopLoadingCategoryProductsState)
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                model,
                textDirection: TextDirection.rtl,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0).w,
              child: SizedBox(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.h,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  children: List.generate(
                      ShopLayoutCubit.get(context)
                          .productsCategoryModel!
                          .products!
                          .length,
                      (index) => BuildproductGrid(
                          ShopLayoutCubit.get(context).productsCategoryModel!,
                          index,
                          context)),
                ),
              ),
            ),
          );
        });
  }
}
