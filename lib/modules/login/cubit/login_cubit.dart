import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/shared_widgets.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
    BuildContext? context,
})
  {
    emit(LoginLoading());
    DioHelper.postData(url: 'login', data: {
      'email':email,
      'password':password,
    }).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data?.token);

      emit(LoginSuccess(loginModel));


    }).catchError((e){
      emit(LoginFailure(e.toString()));
      showSnackBar(context!, e.toString());
      print(e.toString());
    });
  }
  bool isPassword=true;
  IconData suffix=Icons.visibility_outlined;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibility());
  }
}
