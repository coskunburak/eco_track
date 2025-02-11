import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_track/src/screens/home/home_screen.dart';
import '../../blocs/login_bloc/auth_bloc.dart';
import '../../blocs/login_bloc/auth_event.dart';
import '../../blocs/login_bloc/auth_state.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';
import '../../utils/global.dart';
// Diğer sekmeler için alias kullanarak:
import '../../widgets/signup_tab.dart' as signupTab;

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      create: (context) => UserRepository(),
      child: RepositoryProvider<AuthRepository>(
        create: (context) => AuthRepository(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
          child: Scaffold(
            backgroundColor: const Color(0xFF1F1A30),
            /*appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0DF5E4),
                      Color(0xFF0DF5E4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              *//*title: const Text(
                "Zero Point",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),*//*
            ),*/
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                  if (state is SignUpSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kayıt Başarılı')),
                    );
                  }
                  if (state is ResetPasswordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Şifre sıfırlama e-postası gönderildi')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: signupTab.buildSignupTab(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
