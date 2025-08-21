import 'package:eco_track/src/repositories/energy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../blocs/energy_bloc/energy_bloc.dart';
import '../../blocs/energy_bloc/energy_event.dart';
import '../../blocs/energy_bloc/energy_state.dart';
import '../../widgets/Textfield.dart';

class EnergyScreen extends StatelessWidget {
  const EnergyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnergyBloc(energyRepository: EnergyRepository()),
      child: const EnergyScreenBody(),
    );
  }
}

class EnergyScreenBody extends StatefulWidget {
  const EnergyScreenBody({Key? key}) : super(key: key);

  @override
  _EnergyScreenBodyState createState() => _EnergyScreenBodyState();
}

class _EnergyScreenBodyState extends State<EnergyScreenBody> {
  final TextEditingController electricityController = TextEditingController();
  final TextEditingController gasController = TextEditingController();
  final TextEditingController waterController = TextEditingController();
  final TextEditingController travelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Karbon Ayak İzi Hesaplama")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField("Elektrik Tüketimi (kWh)", electricityController),
              const SizedBox(height: 10),
              buildTextField("Doğalgaz Tüketimi (m³)", gasController),
              const SizedBox(height: 10),
              buildTextField("Su Kullanımı (m³)", waterController),
              const SizedBox(height: 10),
              buildTextField("Ulaşım Mesafesi (km)", travelController),
              const SizedBox(height: 20),
              BlocConsumer<EnergyBloc, EnergyState>(
                listener: (context, state) {
                  if (state is EnergySuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Karbon Ayak İzi: ${state.carbonFootprint.toStringAsFixed(2)} kg CO₂"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is EnergyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final userId = FirebaseAuth.instance.currentUser?.uid ?? "guest";
                      context.read<EnergyBloc>().add(
                        CalculateCarbonFootprint(
                          userId: userId,
                          electricityUsage: double.tryParse(electricityController.text) ?? 0.0,
                          gasUsage: double.tryParse(gasController.text) ?? 0.0,
                          waterUsage: double.tryParse(waterController.text) ?? 0.0,
                          travelKm: double.tryParse(travelController.text) ?? 0.0,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Hesapla ve Kaydet",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
}
