import 'package:flutter/material.dart';

import 'auth_screen.dart';

void main() => runApp(const GloblyApp());

const _seed = Color(0xFF1971C2);

class GloblyApp extends StatefulWidget {
  const GloblyApp({super.key});

  @override
  State<GloblyApp> createState() => _GloblyAppState();
}

class _GloblyAppState extends State<GloblyApp> {
  String? _userName;

  /// Frontend only: any username and password are accepted for now.
  /// Returns null on success, or an error message for the form to show.
  Future<String?> _submit(String username, String password, {required bool register}) async {
    setState(() => _userName = username);
    return null;
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Globly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: _seed),
        darkTheme: ThemeData(colorSchemeSeed: _seed, brightness: Brightness.dark),
        home: _userName == null
            ? AuthScreen(onSubmit: _submit)
            : HomeScreen(userName: _userName!, onLogout: () => setState(() => _userName = null)),
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userName, required this.onLogout});
  final String userName;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Globly'),
          actions: [
            Center(child: Text(userName)),
            IconButton(tooltip: 'Iziet', icon: const Icon(Icons.logout), onPressed: onLogout),
          ],
        ),
        body: const Center(child: Text('Publicējumi parādīsies šeit.')),
      );
}
