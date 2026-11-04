import 'package:flutter/material.dart';

/// Called with the entered data. Returns null on success, or an error message.
typedef AuthSubmit = Future<String?> Function(String username, String password, {required bool register});

/// SP 4.3, fig. 2: authentication and registration.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.onSubmit});
  final AuthSubmit onSubmit;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  var _register = false;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSubmit(_username.text.trim(), _password.text, register: _register);
    if (mounted) {
      setState(() {
        _busy = false;
        _error = error;
      });
    }
  }

  String? _required(String? value) => (value ?? '').trim().isEmpty ? 'Obligāts lauks' : null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Globly',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment(value: false, label: Text('Autentificēties')),
                          ButtonSegment(value: true, label: Text('Reģistrēties')),
                        ],
                        selected: {_register},
                        showSelectedIcon: false,
                        onSelectionChanged: (s) => setState(() {
                          _register = s.first;
                          _error = null;
                        }),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _username,
                        decoration: const InputDecoration(labelText: 'Lietotājvārds', border: OutlineInputBorder()),
                        validator: _required,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Parole', border: OutlineInputBorder()),
                        validator: _required,
                        onFieldSubmitted: (_) => _submit(),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                      ],
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: _busy ? null : _submit,
                        child: Text(_register ? 'Reģistrēties' : 'Ievadīt'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
