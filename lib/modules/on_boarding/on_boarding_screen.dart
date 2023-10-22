// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:market_app/modules/shop_login/shop_login.dart';
import 'package:market_app/shared/components/components.dart';
import 'package:market_app/shared/network/local/cache_helper.dart';
import 'package:market_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardingModel {
  final String title;
  final String img;
  final String body;

  BoardingModel({
    required this.body,
    required this.img,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      NavigateAndFinish(context, ShopLoginScreen());
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        body: "On Board Body 1",
        img: 'assets/images/Self checkout-rafiki.svg',
        title: "اختر ما يناسبك"),
    BoardingModel(
        body: "On Board Body 2",
        img: 'assets/images/Cash Payment-rafiki.svg',
        title: "اختر ما يناسبك"),
    BoardingModel(
        body: "On Board Body 3",
        img: 'assets/images/Shopping-rafiki.svg',
        title: "اختر ما يناسبك"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: Text(
                  // textDirection: TextDirection.ltr,
                  'تخطي',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: PrimaryColor),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0).w,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (value) {
                    if (value == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      isLast = false;
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: boarding.length,
                  itemBuilder: (context, index) =>
                      BuildBoardingItem(boarding[index]),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: PrimaryColor!,
                          dotHeight: 10.h,
                          dotWidth: 10.w,
                          expansionFactor: 3,
                          spacing: 5,
                          dotColor: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),
        ));
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SvgPicture.asset(
              model.img,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            model.body,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      );
}
