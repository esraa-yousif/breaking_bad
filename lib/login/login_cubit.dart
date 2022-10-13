import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_status.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());


  String? email;
  String? password;

  final formKey = GlobalKey<FormState>();


  Future<void> login() async{
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoadingState());
    formKey.currentState!.save();
    try {
      final response =await Dio().post(
          'https://student.valuxapps.com/api/register',
          data: {
            'email': email,
            'password': password,
          }
      );
      print(response.data);
      if (response.data['status']) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('token', response.data['data']['token']);
        print(sp.getString('token'));
        emit(LoginSuccessState());
      }else {
        emit(LoginErrorState(
            message: response.data['message']
        ));
      }
    }catch (e) {
      emit(LoginErrorState(
        message: e.toString(),
      ));
    }
  }
}
