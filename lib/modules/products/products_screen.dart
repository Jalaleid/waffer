import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_app/layout/cubit/shop_layout_cubit.dart';
import 'package:market_app/layout/cubit/shop_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/components/components.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    ShopLayoutCubit.get(context).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ShopLoadingAllProductsState)
            return Center(
              child: CircularProgressIndicator(),
            );

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.h,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  children: List.generate(
                      ShopLayoutCubit.get(context)
                          .productsModel!
                          .products!
                          .length,
                      (index) => BuildproductGrid(
                          ShopLayoutCubit.get(context).productsModel!,
                          index,
                          context)),
                ),
              ),
            ),
          );
        });
  }
}
