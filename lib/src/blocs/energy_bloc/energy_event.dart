import 'package:equatable/equatable.dart';

abstract class EnergyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculateCarbonFootprint extends EnergyEvent {
  final String userId;
  final double electricityUsage;
  final double gasUsage;
  final double waterUsage;
  final double travelKm;

  CalculateCarbonFootprint({
    required this.userId,
    required this.electricityUsage,
    required this.gasUsage,
    required this.waterUsage,
    required this.travelKm,
  });

  @override
  List<Object?> get props => [userId, electricityUsage, gasUsage, waterUsage, travelKm];
}

class FetchEnergyHistory extends EnergyEvent {
  final String userId;
  FetchEnergyHistory(this.userId);

  @override
  List<Object?> get props => [userId];
}
