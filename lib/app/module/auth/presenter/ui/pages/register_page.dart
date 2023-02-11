import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/pages/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/credential_auth.dart';
import '../bloc/register/register_auth_bloc.dart';
import '../bloc/register/register_auth_event.dart';
import '../bloc/register/register_auth_state.dart';
import 'widgets/input_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordObscured = true;
  late TextEditingController email;
  late TextEditingController password;
  late RegisterAuthBloc blocRegister;
  late CredentialAuth credential;

  message(String message) {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message, textAlign: TextAlign.center),
        ));
      },
    );
  }

  clearMessage() {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  goToLoginPage(String message) {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        Modular.to.navigate('/', arguments: message);
      },
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    blocRegister = Modular.get<RegisterAuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: BlocBuilder<RegisterAuthBloc, RegisterAuthState>(
            bloc: blocRegister,
            builder: (context, state) {
              if (state is LoadingRegisterAuthState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ExceptionRegisterAuthState) {
                message(state.message);
                blocRegister.add(InitialRegisterAuthEvent());
              }
              if (state is SuccessRegisterAuthSate) {
                blocRegister.add(InitialRegisterAuthEvent());
                goToLoginPage('Registration done successfully.');
              }
              return Padding(
                padding: const EdgeInsets.all(35.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                            image: AssetImage('asserts/images/logo.png'),
                            width: 180),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Register your count.",
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputFieldWidget(
                        prefixIcon: Icons.person,
                        label: 'E-mail',
                        controller: email,
                      ),
                      InputFieldWidget(
                        prefixIcon: Icons.lock,
                        iconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordObscured = !isPasswordObscured;
                              });
                            },
                            icon: isPasswordObscured
                                ? const Icon(Icons.visibility_off_sharp)
                                : const Icon(Icons.visibility)),
                        label: 'Password',
                        controller: password,
                        obscureText: isPasswordObscured,
                      ),
                      const SizedBox(height: 50),
                      ButtonWidget(
                        onPressed: () {
                          if (!blocRegister.isClosed) {
                            credential = CredentialAuth(
                                email: email.text, password: password.text);
                            blocRegister.add(CreateUserEvent(credential));
                          } else {
                            print('Status Bloc: ${blocRegister.isClosed}');
                          }
                        },
                        label: 'Register your Count',
                      ),
                      const SizedBox(height: 10),
                      ButtonWidget(
                        onPressed: () {
                          Modular.to.navigate('/');
                        },
                        label: 'Return',
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
