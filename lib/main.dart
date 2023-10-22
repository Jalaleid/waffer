// ignore_for_file: unnecessary_null_comparison, must_be_immutable, depend_on_referenced_packages, duplicate_ignore, avoid_print

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/layout/cubit/shop_layout_cubit.dart';
import 'package:market_app/layout/cubit/shop_layout_state.dart';
import 'layout/shop_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/shop_login/shop_login.dart';
import 'shared/components/constants.dart';
import 'shared/network/bloc_observe.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();

  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget? widget;

  if (onBoarding != null) {
    widget = ShopLayout();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLayoutCubit()..getHomeData(),
      //..getAllProducts(),
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {
          if (state is ShopSuccessHomeDataState && onBoarding != null) {
            startWidget = const ShopLayout();
          } else if (state is ShopErrorHomeDataState && onBoarding != null) {
            startWidget = ShopLoginScreen();
          }
        },
        builder: (context, state) {
          ScreenUtil.init(context);
          return MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
