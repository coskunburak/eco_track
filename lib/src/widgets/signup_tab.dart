import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login_bloc/auth_bloc.dart';
import '../blocs/login_bloc/auth_event.dart';
import '../blocs/login_bloc/auth_state.dart';
import '../elements/pageLoading.dart';

Widget buildSignUpTab(BuildContext context) {
  final TextEditingController _signUpNameController =
  TextEditingController();
  final TextEditingController _signUpSurnameController =
  TextEditingController();
  final TextEditingController _signUpEmailController =
  TextEditingController();
  final TextEditingController _signUpPasswordController =
  TextEditingController();

  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Logo or Illustration
            Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.person_add_alt_1,
                      size: 60,
                      color: Color(0xFF2ECC71),
                    ),
                  ),
                  const Text(
                    "Yeni Bir Hesap Oluştur",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Name Field
            TextField(
              controller: _signUpNameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: Color(0xFF27AE60)),
                labelText: 'Ad',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),

            // Surname Field
            TextField(
              controller: _signUpSurnameController,
              decoration: InputDecoration(
                prefixIcon:
                const Icon(Icons.person_outline, color: Color(0xFF27AE60)),
                labelText: 'Soyad',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),

            // Email Field
            TextField(
              controller: _signUpEmailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email, color: Color(0xFF27AE60)),
                labelText: 'E-posta',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),

            // Password Field
            TextField(
              controller: _signUpPasswordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Color(0xFF27AE60)),
                labelText: 'Şifre',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              style: const TextStyle(color: Colors.white),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Sign Up Button
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

                    final email = _signUpEmailController.text;
                    final password = _signUpPasswordController.text;
                    final name = _signUpNameController.text;
                    final surname = _signUpSurnameController.text;

                    context.read<AuthBloc>().add(
                      SignUpRequested(
                        email: email,
                        password: password,
                        name: name,
                        surname: surname,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF27AE60),
                  ),
                  child: const Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
