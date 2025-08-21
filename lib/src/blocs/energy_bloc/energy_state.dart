import 'package:equatable/equatable.dart';

abstract class EnergyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EnergyInitial extends EnergyState {}

class EnergyLoading extends EnergyState {}

class EnergySuccess extends EnergyState {
  final double carbonFootprint;
  EnergySuccess({required this.carbonFootprint});

  @override
  List<Object?> get props => [carbonFootprint];
}

class EnergyError extends EnergyState {
  final String errorMessage;
  EnergyError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class EnergyHistoryLoaded extends EnergyState {
  final List<Map<String, dynamic>> history;
  EnergyHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}
