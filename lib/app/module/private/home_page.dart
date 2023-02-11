import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await FirebaseAuth.instance.signOut();
                //log(result.toString());
                Modular.to.navigate('/');
              },
              icon: const Icon(Icons.power_settings_new_sharp))
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
