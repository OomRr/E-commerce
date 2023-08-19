class LoginModel {
  late bool status;
  late String message;
  UserData? data;
  LoginModel.fromJson(Map<String, dynamic> json)
  {

    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?UserData.fromJson(json['data']):null;

  }
}

class UserData {
 late int id;
 late String token;
 late String image;
 late String phone;
 late String email;
 late String name;
 late int points;
 late int credit;

/*  UserData(
      {this.id,
      this.token,
      this.image,
      this.phone,
      this.email,
      this.name,
      this.points,
      this.credit});*/

  UserData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    points = json['points'];
    token = json['token'];
    credit = json['credit'];
    email = json['email'];
  }
}
