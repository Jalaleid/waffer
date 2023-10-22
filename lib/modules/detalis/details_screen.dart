// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/products_model.dart';
import '../../shared/components/constants.dart';

class DetailsScreen extends StatelessWidget {
  Products model;
  DetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            model.itemName!,
            textDirection: TextDirection.rtl,
          ),
        ),
        //backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              model.imagePath! != ""
                  ? FadeInImage.assetNetwork(
                      height: 300.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/loading.gif',
                      image: '${BaseURL!}/${model.imagePath!}')
                  : Image.asset(
                      'assets/images/wfer.png',
                      height: 120.h,
                    ),
              // model.imagePath != ""
              //     ? Image(
              //         image: NetworkImage('${BaseURL!}/${model.imagePath}'),
              //         fit: BoxFit.fill,
              //         height: 300.h,
              //         width: double.infinity,
              //       )
              //     : Image.asset(
              //         'assets/images/wfer.png',
              //         height: 120.h,
              //       ),
              Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                  top: 10.h,
                  left: 10.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      model.itemName!,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    Text(
                      model.m1!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey.shade500),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    // m2 m1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100.h,
                          width: 150.w,
                          //margin: EdgeInsets.all(5).w,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15).r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'المجموعة الفرعية الثانية',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                model.m3! == '' ? "لا يوجد" : model.m3!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width: 150.w,
                          margin: EdgeInsets.all(5).w,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15).r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'المجموعة الفرعية الاولى',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                model.m2! == '' ? "لا يوجد" : model.m2!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    // انتاج فقط الموزع
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100.h,
                          width: 150.w,
                          //margin: EdgeInsets.all(5).w,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15).r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'الموزع',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                model.supplier! == ''
                                    ? "لا يوجد"
                                    : model.supplier!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width: 150.w,
                          margin: EdgeInsets.all(5).w,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15).r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'الانتاج',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                model.local! ? "محلي" : "محلي",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100.h,
                          width: 150.w,
                          margin: EdgeInsets.all(5).w,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15).r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'تاريخ النشر',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                model.createdAt!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width: 150.w,
                          margin: EdgeInsets.all(5).w,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15).r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'تاريخ التعديل',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                model.updatedAt!,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
