import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login_bloc/auth_bloc.dart';
import '../blocs/login_bloc/auth_event.dart';
import '../blocs/login_bloc/auth_state.dart';
import '../elements/pageLoading.dart';

Widget buildLoginTab(BuildContext context) {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
  TextEditingController();

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // App Logo
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2ECC71),
                    Color(0xFF27AE60),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),

          // Email Field
          TextField(
            controller: _loginEmailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: Color(0xFF27AE60)),
              labelText: 'E-posta',
              labelStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Color(0xFF27AE60)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Color(0xFF27AE60)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 15),

          // Password Field
          TextField(
            controller: _loginPasswordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: Color(0xFF27AE60)),
              labelText: 'Şifre',
              labelStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Color(0xFF27AE60)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Color(0xFF27AE60)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
          ),
          const SizedBox(height: 15),

          // Forgot Password Link
          GestureDetector(
            onTap: () {
              // Forgot password action
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Şifremi Unuttum'),
                  content: const Text(
                      'Lütfen kayıtlı e-posta adresinizi girin, size bir sıfırlama bağlantısı göndereceğiz.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tamam'),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              'Şifremi Unuttum?',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF2ECC71),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Login Button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Loading) {
                return pageLoading();
              }
              return ElevatedButton(
                onPressed: () {
                  try {
                    FocusManager.instance.primaryFocus?.unfocus();
                  } catch (e) {}

                  final email = _loginEmailController.text;
                  final password = _loginPasswordController.text;
                  context
                      .read<AuthBloc>()
                      .add(LoginRequested(email: email, password: password));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF2ECC71),
                ),
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Divider with "OR"
          Row(
            children: const [
              Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'VEYA',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  )),
            ],
          ),
          const SizedBox(height: 20),

          // Social Login Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Google login action
                },
                icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                label: const Text('Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Facebook login action
                },
                icon: const Icon(Icons.facebook, color: Colors.white),
                label: const Text('Facebook'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
