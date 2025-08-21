import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/login_bloc/auth_bloc.dart';
import '../blocs/login_bloc/auth_event.dart';
import '../blocs/login_bloc/auth_state.dart';

Widget buildResetPasswordTab(BuildContext context) {
  final TextEditingController emailController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'E-posta Adresiniz',
            prefixIcon: const Icon(Icons.email),
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
                final email = emailController.text.trim();
                context.read<AuthBloc>().add(
                  ResetPasswordRequested(email: email),
                );
              },
              child: const Text('Şifreyi Sıfırla'),
            );
          },
        ),
      ],
    ),
  );
}
