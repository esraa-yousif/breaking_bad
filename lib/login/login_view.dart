import 'package:final_project/register/register_status.dart';
import 'package:final_project/character/character_view.dart';
import 'package:final_project/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../register/register_cubit.dart';
import 'login_cubit.dart';
import 'login_status.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('login'),
        ),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CharacterView(),
              ));
            } else if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message,)));
            }
          },
          child: Builder(builder: (context) {
            final cubit = BlocProvider.of<LoginCubit>(context);
            return Form(
              key: cubit.formKey,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  TextFormField(
                    onSaved: (v) => cubit.email = v,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Name can not be empty';
                      } else if (!v.contains('@')) {
                        return 'Email must be contains @';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (v) => cubit.password = v,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Password can not be empty';
                      } else if (v.length < 6) {
                        return 'Password must be at least 6 character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () => cubit.login(),
                        child: Text('Login'),
                      );
                    },
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () => RegisterView(),
                        child: Text('Register'),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
