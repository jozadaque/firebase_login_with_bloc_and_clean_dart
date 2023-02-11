import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/private/home-page', child: (context, args) => const HomePage())
  ];
}
