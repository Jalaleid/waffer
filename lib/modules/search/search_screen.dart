// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/modules/search/cubit/search_cubit.dart';
import 'package:market_app/modules/search/cubit/search_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchcontroller = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(15.0).w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        controller: searchcontroller,
                        decoration: InputDecoration(
                          label: Text(
                            'ابحث',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          SearchCubit.get(context).search(value);
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (state is SearchLoadingState)
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      if (state is SearchErrorState) Container(),
                      if (state is SearchSuccsessState)
                        SearchCubit.get(context).model!.products!.isEmpty
                            ? Container()
                            : SizedBox(
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.w,
                                  crossAxisSpacing: 10.h,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.4),
                                  children: List.generate(
                                      SearchCubit.get(context)
                                          .model!
                                          .products!
                                          .length,
                                      (index) => BuildproductGrid(
                                          SearchCubit.get(context).model!,
                                          index,
                                          context)),
                                ),
                              ),
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

  // Widget SearchItem(ProductsModel model, context, int index) {
  //   return InkWell(
  //     onTap: () {
  //       NavigateTo(context, DetailsScreen(model: model.products![index]));
  //     },
  //     child: Card(
  //       clipBehavior: Clip.antiAliasWithSaveLayer,
  //       shadowColor: Colors.grey.shade200,
  //       shape: ContinuousRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(30)).r),
  //       elevation: 2,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(Radius.circular(15)).r,
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Image.network(
  //               '${BaseURL!}/${model.products![index].imagePath!}',
  //               height: 120.h,
  //               width: double.infinity,
  //               fit: BoxFit.fill,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 5.h, right: 5.w, left: 5.w),
  //               child: Text(model.products![index].itemName!,
  //                   textAlign: TextAlign.center,
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .bodyMedium!
  //                       .copyWith(fontSize: 14.sp)),
  //             ),
  //             SizedBox(
  //               height: 10.h,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 10.w),
  //               child: Text(model.products![index].m1!,
  //                   maxLines: 1,
  //                   textAlign: TextAlign.center,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .bodySmall!
  //                       .copyWith(fontSize: 10.sp)),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //}
}
