import 'package:firebase_login_with_bloc_and_clean_dart/app/module/auth/presenter/ui/pages/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../bloc/reset_password/reset_password_auth_bloc.dart';
import '../bloc/reset_password/reset_password_auth_event.dart';
import '../bloc/reset_password/reset_password_auth_state.dart';
import 'widgets/input_field_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController email;
  late ResetPasswordAuthBloc resetPasswordAuthBloc;

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    resetPasswordAuthBloc = Modular.get<ResetPasswordAuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: BlocBuilder<ResetPasswordAuthBloc, ResetPasswordAuthState>(
            bloc: resetPasswordAuthBloc,
            builder: (context, state) {
              if (state is LoadingResetPasswordAuthState) {
                return const CircularProgressIndicator();
              }
              if (state is ExceptionResetPasswordAuthState) {
                message(state.message);
                resetPasswordAuthBloc.add(InitialResetPasswordAuthEvent());
              }
              if (state is SuccessResetPasswordAuthSate) {
                resetPasswordAuthBloc.close();
                goToLoginPage('A message has been sent to your email box.');
              }

              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          "Enter your email to reset your password.",
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputFieldWidget(
                        prefixIcon: Icons.mail,
                        label: 'E-mail',
                        controller: email,
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        onPressed: () {
                          resetPasswordAuthBloc
                              .add(ResetPasswordEvent(email.text));
                        },
                        label: 'Reset your Password',
                      ),
                      const SizedBox(height: 15),
                      ButtonWidget(
                          onPressed: () {
                            Modular.to.navigate('/');
                          },
                          label: 'Return'),
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
