import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login/login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFF1F1A30),
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle),
          tooltip: 'Profil',
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
        IconButton(
          icon: const Icon(Icons.cloud),
          tooltip: 'Hava Durumu',
          onPressed: () => Navigator.pushNamed(context, '/weather'),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Ayarlar',
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        ),
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          tooltip: 'Çıkış',
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
