import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/layout.dart';
import 'package:shop/modules/login/cubit/login_cubit.dart';
import 'package:shop/modules/register/register.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

import '../../shared/styles/shared_widgets.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginSuccess){
            if(state.loginModel.status){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                if(value){
                  navigateAndReplace(context, const Layout());
                }
              });
            }
            showSnackBar(context, state.loginModel.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        buildTextFormField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            prefixIcon: const Icon(Icons.email_outlined),
                            label: 'Email Address',
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: LoginCubit.get(context).isPassword,
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text,context: context);
                              print(emailController.text);
                            }
                          },
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                icon: Icon(LoginCubit.get(context).suffix),
                                onPressed: () {
                                  LoginCubit.get(context).changePasswordVisibility();
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          builder:(context)=> Center(
                            child:Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: defaultColor, borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text,context: context);
                                    print(emailController.text);
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ), condition: state is! LoginLoading,
                          fallback: (BuildContext context) { return const Center(child: CircularProgressIndicator()); },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigate(context, const RegisterScreen());
                                },
                                child: const Text('register')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
