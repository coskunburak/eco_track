import 'package:cloud_firestore/cloud_firestore.dart';

class EnergyRepository {
  final CollectionReference energyCollection =
  FirebaseFirestore.instance.collection("EnergyCalculations");

  Future<void> saveEnergyData({
    required String userId,
    required double electricityUsage,
    required double gasUsage,
    required double waterUsage,
    required double travelKm,
    required double resultCarbonFootprint,
  }) async {
    try {
      await energyCollection.add({
        'userId': userId,
        'electricityUsage': electricityUsage,
        'gasUsage': gasUsage,
        'waterUsage': waterUsage,
        'travelKm': travelKm,
        'carbonFootprint': resultCarbonFootprint,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Veri kaydedilemedi: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getUserEnergyHistory(String userId) async {
    try {
      QuerySnapshot snapshot = await energyCollection
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception("Geçmiş veriler alınamadı: $e");
    }
  }
}
