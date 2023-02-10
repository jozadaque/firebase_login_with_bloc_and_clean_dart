import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/entities/credential_auth.dart';
import '../bloc/login/login_auth_bloc.dart';
import '../bloc/login/login_auth_event.dart';
import '../bloc/login/login_auth_state.dart';
import 'widgets/button_widget.dart';
import 'widgets/input_field_widget.dart';

class LoginPage extends StatefulWidget {
  final String? message;

  const LoginPage({super.key, this.message});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool isPasswordObscured;
  late final TextEditingController email;
  late final TextEditingController password;
  late LoginAuthBloc blocLogin;

  Future message(String message) {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          message,
          textAlign: TextAlign.center,
        )));
      },
    );
  }

  void goToHomePage(String message) {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        Modular.to.navigate('/private/home-page', arguments: message);
      },
    );
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    isPasswordObscured = true;
    email = TextEditingController();
    password = TextEditingController();
    blocLogin = Modular.get<LoginAuthBloc>();

    if (widget.message != null) {
      message(widget.message.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder(
            bloc: blocLogin,
            builder: (context, state) {
              if (state is LoadingLoginAuthState) {
                log('Loading...');
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ExceptionLoginAuthState) {
                log('Exception: ${state.message} ...');
                message(state.message);
                blocLogin.add(InitialLoginAuthEvent());
              }
              if (state is SuccessLoginAuthSate) {
                log('Sucess');
                blocLogin.close();
                goToHomePage('Login realizado com sucesso.');
              }

              return Padding(
                padding: const EdgeInsets.all(25.0),
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
                        height: 20,
                      ),
                      Text(
                        "Let's Get Started.",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Connect in Your app with e-mail or Social Login.",
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
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () {
                              Modular.to.navigate('/reset-password-page');
                            },
                            child: Text(
                              'Forget your Password?',
                              style: Theme.of(context).textTheme.labelSmall,
                            )),
                      ),
                      const SizedBox(height: 25),
                      ButtonWidget(
                        label: 'Sign In',
                        onPressed: () {
                          final credential = CredentialAuth(
                              email: email.text, password: password.text);
                          blocLogin.add(LoginUserEvent(credential));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonWidget(
                        label: 'Sign In with Google',
                        image: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                              image:
                                  AssetImage('asserts/images/google_logo.png'),
                              width: 23),
                        ),
                        onPressed: () {
                          if (!blocLogin.isClosed) {
                            blocLogin.add(SocialLoginUserEvent());
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Modular.to.pushReplacementNamed('/register-page');
                          },
                          child: Text(
                            'Register ',
                            style: Theme.of(context).textTheme.labelMedium,
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
