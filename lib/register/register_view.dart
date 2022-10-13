import 'package:final_project/login/login_view.dart';
import 'package:final_project/register/register_status.dart';
import 'package:final_project/character/character_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CharacterView(),
             ));
            } else if (state is RegisterErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message,)));
            }
          },
          child: Builder(builder: (context) {
            final cubit = BlocProvider.of<RegisterCubit>(context);
            return Form(
              key: cubit.formKey,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  TextFormField(
                    onSaved: (v) => cubit.name = v,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Name can not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                    onSaved: (v) => cubit.phone = v,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Phone can not be empty';
                      } else if (!v.startsWith('+201')) {
                        return 'Phone must start with +201';
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
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      if (state is RegisterLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () => cubit.register(),
                        child: Text('Register'),
                      );
                    },
                  ),
                  TextButton(
                    child: Text('Login now'),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute( builder: (_) => LoginView())),
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
