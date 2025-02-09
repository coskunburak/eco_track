import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/login_bloc/auth_bloc.dart';
import '../blocs/login_bloc/auth_event.dart';
import '../blocs/login_bloc/auth_state.dart';

// buildSignUpTab.dart
Widget buildSignUpTab(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Ad',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: surnameController,
          decoration: InputDecoration(
            labelText: 'Soyad',
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'E-posta',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Şifre',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final surname = surnameController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                context.read<AuthBloc>().add(
                  SignUpRequested(
                    name: name,
                    surname: surname,
                    email: email,
                    password: password,
                  ),
                );
              },
              child: const Text('Kayıt Ol'),
            );
          },
        ),
      ],
    ),
  );
}
