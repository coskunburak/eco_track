import 'package:eco_track/src/elements/appBar.dart';
import 'package:eco_track/src/screens/energy/energy_screen.dart';
import 'package:eco_track/src/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/FeatureCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Zero Point'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: const Color(0xFF1F1A30),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Güncel Karbon Ayak İzi",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "2.35 Ton CO₂",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.cloud,
                            size: 40,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildFeatureCard(
                    context,
                    icon: FontAwesomeIcons.user,
                    title: "Profil",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),
                  buildFeatureCard(
                    context,
                    icon: FontAwesomeIcons.sun,
                    title: "Hava Durumu",
                    onTap: () {
                      // Hava Durumu Sayfasına Git
                    },
                  ),
                  buildFeatureCard(
                    context,
                    icon: FontAwesomeIcons.calculator,
                    title: "Karbon Ayak İzi Hesapla",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EnergyScreen()),
                      );
                    },
                  ),
                  buildFeatureCard(
                    context,
                    icon: FontAwesomeIcons.chartBar,
                    title: "Raporlar",
                    onTap: () {
                      // Raporlar Sayfasına Git
                    },
                  ),
                  buildFeatureCard(
                    context,
                    icon: FontAwesomeIcons.infoCircle,
                    title: "Hakkında",
                    onTap: () {
                      // Hakkında Sayfasına Git
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Günün Önerisi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF27AE60),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Bugün toplu taşıma kullanarak karbon ayak izinizi %10 oranında azaltabilirsiniz!",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF27AE60),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Raporlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        onTap: (index) {
          // Alt menü navigasyonu
        },
      ),
    );
  }
}
