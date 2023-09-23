import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/modules/favorites/favorites.dart';
import 'package:shop/modules/products/products.dart';
import 'package:shop/modules/settings/settings_screen.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/constants/constants.dart';

import '../../../models/cate.dart';
import '../../../modules/category/categories.dart';
part 'shop_state.dart';
class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  bool isDark = false;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart,
      ),
        label: 'Home'

    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
        label: 'Favorites'

    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.category,
      ),
      label: 'Category'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
        label: 'Settings'

    ),
  ];
  List<Widget> screens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      const CategoriesScreen();
    }
    if (index == 2) {
      const FavoritesScreen();
    }
    emit(ShopBottomNav());
  }
  void getHomeData() {
    emit(ShopHomeLoading());

    DioHelper.getDate(url: 'home',token: token,query: {}).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      //print(homeModel?.status);
      emit(ShopHomeSuccess());
    }).catchError((e){
        emit(ShopHomeFailure(e.toString()));
       // print(e.toString());
    });
  }
  void getCategoryData() {
    emit(ShopCategoryLoading());

    DioHelper.getDate(url: 'categories',token: token,query: {}).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print(categoriesModel?.data?.total);
      emit(ShopCategorySuccess());
    }).catchError((e){
        emit(ShopCategoryFailure(e.toString()));
      //  print(e.toString());
    });
  }
}
