import 'package:dio/dio.dart';
import 'package:final_project/register/register_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterState> {
RegisterCubit() : super(RegisterInitState());

String? name;
String? email;
String? phone;
String? password;

final formKey = GlobalKey<FormState>();


Future<void> register() async{
 if (!formKey.currentState!.validate()) {
   return;
 }
 emit(RegisterLoadingState());
 formKey.currentState!.save();
 try {
   final response =await Dio().post(
       'https://student.valuxapps.com/api/register',
       data: {
         'name': name,
         'phone': phone,
         'email': email,
         'password': password,
       }
   );
   print(response.data);
   if (response.data['status']) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('token', response.data['data']['token']);
      print(sp.getString('token'));
     emit(RegisterSuccessState());
   }else {
     emit(RegisterErrorState(
       message: response.data['message']
     ));
   }
 }catch (e) {
   emit(RegisterErrorState(
     message: e.toString(),
   ));
 }
}
}
