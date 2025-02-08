import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_track/src/repositories/energy_repository.dart';
import 'energy_event.dart';
import 'energy_state.dart';

class EnergyBloc extends Bloc<EnergyEvent, EnergyState> {
  final EnergyRepository energyRepository;

  EnergyBloc({required this.energyRepository}) : super(EnergyInitial()) {
    on<CalculateCarbonFootprint>((event, emit) async {
      emit(EnergyLoading());
      try {
        double result = _calculateCarbonFootprint(
          event.electricityUsage,
          event.gasUsage,
          event.waterUsage,
          event.travelKm,
        );

        await energyRepository.saveEnergyData(
          userId: event.userId,
          electricityUsage: event.electricityUsage,
          gasUsage: event.gasUsage,
          waterUsage: event.waterUsage,
          travelKm: event.travelKm,
          resultCarbonFootprint: result,
        );

        emit(EnergySuccess(carbonFootprint: result));
      } catch (e) {
        emit(EnergyError(errorMessage: e.toString()));
      }
    });

    on<FetchEnergyHistory>((event, emit) async {
      emit(EnergyLoading());
      try {
        List<Map<String, dynamic>> history =
        await energyRepository.getUserEnergyHistory(event.userId);
        emit(EnergyHistoryLoaded(history));
      } catch (e) {
        emit(EnergyError(errorMessage: e.toString()));
      }
    });
  }

  double _calculateCarbonFootprint(
      double electricity, double gas, double water, double travelKm) {
    double electricityFactor = 0.4;
    double gasFactor = 2.3;
    double waterFactor = 0.05;
    double travelFactor = 0.2;

    return (electricity * electricityFactor) +
        (gas * gasFactor) +
        (water * waterFactor) +
        (travelKm * travelFactor);
  }
}
