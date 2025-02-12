import 'package:eco_track/src/blocs/login_bloc/auth_event.dart';
import 'package:eco_track/src/blocs/login_bloc/auth_state.dart';
import 'package:eco_track/src/screens/home/home_screen.dart';
import 'package:eco_track/src/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/login_bloc/auth_bloc.dart';

enum FieldFocus { name, surname, email, password }

class SignupTab extends StatefulWidget {
  const SignupTab({Key? key}) : super(key: key);

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;
  FieldFocus? selectedField;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    const Color enabledColor = Color(0xFF827F8A);
    const Color enabledText = Colors.white;
    const Color disabledColor = Colors.grey;
    const Color backgroundColor = Color(0xFF1F1A30);

    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Image.network(
              "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
              width: width * 0.9,
              height: height * 0.4,
              fit: BoxFit.contain,
            ),
            Container(
              margin: const EdgeInsets.only(right: 230.0),
              child: const Text(
                "Kayıt ol",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: width * 0.9,
              height: height * 0.071,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: selectedField == FieldFocus.name
                    ? enabledColor
                    : backgroundColor,
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                onTap: () {
                  setState(() {
                    selectedField = FieldFocus.name;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: selectedField == FieldFocus.name
                        ? enabledText
                        : disabledColor,
                  ),
                  hintText: "İsim",
                  hintStyle: TextStyle(
                    color: selectedField == FieldFocus.name
                        ? enabledText
                        : disabledColor,
                  ),
                ),
                style: TextStyle(
                  color: selectedField == FieldFocus.name
                      ? enabledText
                      : disabledColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: width * 0.9,
              height: height * 0.071,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: selectedField == FieldFocus.surname
                    ? enabledColor
                    : backgroundColor,
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: surnameController,
                onTap: () {
                  setState(() {
                    selectedField = FieldFocus.surname;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: selectedField == FieldFocus.surname
                        ? enabledText
                        : disabledColor,
                  ),
                  hintText: "Soyisim",
                  hintStyle: TextStyle(
                    color: selectedField == FieldFocus.surname
                        ? enabledText
                        : disabledColor,
                  ),
                ),
                style: TextStyle(
                  color: selectedField == FieldFocus.surname
                      ? enabledText
                      : disabledColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: width * 0.9,
              height: height * 0.071,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: selectedField == FieldFocus.email
                    ? enabledColor
                    : backgroundColor,
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                onTap: () {
                  setState(() {
                    selectedField = FieldFocus.email;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: selectedField == FieldFocus.email
                        ? enabledText
                        : disabledColor,
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: selectedField == FieldFocus.email
                        ? enabledText
                        : disabledColor,
                  ),
                ),
                style: TextStyle(
                  color: selectedField == FieldFocus.email
                      ? enabledText
                      : disabledColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: width * 0.9,
              height: height * 0.071,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: selectedField == FieldFocus.password
                    ? enabledColor
                    : backgroundColor,
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                onTap: () {
                  setState(() {
                    selectedField = FieldFocus.password;
                  });
                },
                obscureText: isPasswordVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: selectedField == FieldFocus.password
                        ? enabledText
                        : disabledColor,
                  ),
                  suffixIcon: IconButton(
                    icon: isPasswordVisible
                        ? Icon(
                            Icons.visibility_off,
                            color: selectedField == FieldFocus.password
                                ? enabledText
                                : disabledColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: selectedField == FieldFocus.password
                                ? enabledText
                                : disabledColor,
                          ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Parola',
                  hintStyle: TextStyle(
                    color: selectedField == FieldFocus.password
                        ? enabledText
                        : disabledColor,
                  ),
                ),
                style: TextStyle(
                  color: selectedField == FieldFocus.password
                      ? enabledText
                      : disabledColor,
                  fontWeight: FontWeight.bold,
                ),
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
                              password: password),
                        );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0DF5E4),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Zaten bir hesabınız var mı?",
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Giriş yap",
                    style: TextStyle(
                      color: Color(0xFF0DF5E4),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,

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
}

Widget buildSignupTab(BuildContext context) {
  return const SignupTab();
}
