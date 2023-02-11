import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.tenaliRamakrishna(
                fontSize: 55,
                color: const Color.fromARGB(255, 2, 39, 250),
                fontWeight: FontWeight.bold),
            labelMedium: GoogleFonts.tenaliRamakrishna(
                fontSize: 18,
                color: const Color.fromARGB(255, 2, 39, 250),
                fontWeight: FontWeight.bold),
            labelSmall: GoogleFonts.tenaliRamakrishna(
                fontSize: 14,
                color: const Color.fromARGB(255, 2, 39, 250),
                fontWeight: FontWeight.bold),
            displaySmall: GoogleFonts.roboto(
              fontSize: 25,
              color: const Color.fromARGB(255, 124, 126, 141),
            ),
          )),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
