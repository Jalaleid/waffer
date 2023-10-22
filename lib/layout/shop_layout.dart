// ignore_for_file: depend_on_referenced_packages, unused_import, avoid_web_libraries_in_flutter, non_constant_identifier_names, unused_element
import 'package:flutter/material.dart';
import 'package:market_app/layout/cubit/shop_layout_cubit.dart';
import 'package:market_app/layout/cubit/shop_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/modules/search/search_screen.dart';
import 'package:market_app/modules/shop_login/shop_login.dart';
import 'package:market_app/shared/components/components.dart';
import 'package:market_app/shared/network/local/cache_helper.dart';
import 'package:market_app/shared/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../shared/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            titleSpacing: 0,
            title: IconButton(
                onPressed: () {
                  NavigateTo(context, const SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Text(
                'ماركت',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeBottom(value);
            },
            currentIndex: cubit.currentIndex,
            selectedItemColor: PrimaryColor,
            unselectedItemColor: SecondryColor,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'الملف الشخصي'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopify), label: 'المنتجات'),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
            ],
          ),
        );
      },
    );
  }
}
