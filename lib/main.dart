import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/layout.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/modules/onBoarding/on_boarding.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/constants/constants.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/styles/themes.dart';

import 'network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget widget;
  isDark ??= false;
  if (onBoarding != null) {
    if (token != null) {
      widget = const Layout();
    } else {
      widget = Login();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  const MyApp({super.key, required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData(),
        ),
      ],
      child: MaterialApp(
        theme: buildThemeDataLight(),
        darkTheme: buildThemeDataDark(),
        home: startWidget,
      ),
    );
  }
}
