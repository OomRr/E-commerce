class HomeModel{
   late bool status;
   late HomeDataModel data;
   HomeModel.fromJson(Map<String,dynamic>json){
     status=json['status'];
     data=HomeDataModel.fromJson(json['data']);
   }
}
class HomeDataModel{
    List<dynamic> products=[];
    List<dynamic> banners=[];
   HomeDataModel.fromJson(Map<String,dynamic>json)
   {
     json['banners'].forEach((element){
       banners.add(element);
     });
     json['products'].forEach((element){
       products.add(element);
     });
   }
}
class BannerModel{
  late int id;
  late String image;
  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
  }
}
 class  ProductModel{
  late int id;
  late dynamic price;
  late num old_price;
  late num discount;
  late String image;
  late String name;
  late bool in_cart;
  late bool in_favorites;
  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_cart=json['in_cart'];
    in_favorites=json['in_favorites '];
  }
}
