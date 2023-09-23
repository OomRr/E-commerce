part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}
class ShopHomeLoading extends ShopState {}
class ShopHomeSuccess extends ShopState {}
class ShopHomeFailure extends ShopState {
  final String e;

  ShopHomeFailure(this.e);
}class ShopCategoryLoading extends ShopState {}
class ShopCategorySuccess extends ShopState {}
class ShopCategoryFailure extends ShopState {
  final String e;

  ShopCategoryFailure(this.e);
}
class ShopBottomNav extends ShopState {}