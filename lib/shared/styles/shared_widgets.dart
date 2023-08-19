import 'package:flutter/material.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

TextFormField buildTextFormField(
    {controller, validate, label, prefixIcon, type, suffixIcon, suffixPressed}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    keyboardType: type,
    decoration: InputDecoration(

        label: Text(label),
      //  border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
      //  suffixIcon: IconButton(icon: suffixIcon, onPressed: suffixPressed),
       // focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),

        ),
  );
}
void navigateAndReplace(BuildContext context ,widget) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false,
  );
}
void navigate(BuildContext context ,widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
void showSnackBar(BuildContext context,text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),),);
}
void signOut(BuildContext context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateAndReplace(context, Login());
    }
  });
}