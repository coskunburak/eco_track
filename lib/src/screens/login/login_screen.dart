// login_screen.dart
import 'package:eco_track/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login_bloc/auth_bloc.dart';
import '../../blocs/login_bloc/auth_event.dart';
import '../../blocs/login_bloc/auth_state.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';
import '../../utils/global.dart';
// Importlar için alias kullanarak isim çakışmalarını engelliyoruz:
import '../../widgets/login_tab.dart' as loginTab;
import '../../widgets/reset_password.dart' as resetPassword;
import '../../widgets/signup_tab.dart' as signupTab;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: appBarBackgroundColor,
                elevation: 0,
                title: const Text(
                  "Zero Point",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Giriş Yap'),
                    Tab(text: 'Kayıt Ol'),
                    Tab(text: 'Şifremi Unuttum'),
                  ],
                ),
              ),
              body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is Authenticated) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
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
                        const SnackBar(
                          content: Text('Şifre sıfırlama e-postası gönderildi'),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TabBarView(
                      children: [
                        loginTab.buildLoginTab(context),
                        signupTab.buildSignUpTab(context),
                        resetPassword.buildResetPasswordTab(context),
                      ],
                    ),
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
