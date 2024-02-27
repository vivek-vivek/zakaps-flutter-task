part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class LocationAddedState extends DashboardState {
  final timeStamp;

  const LocationAddedState(this.timeStamp);

  @override
  List<Object> get props => [timeStamp];
}

final class LocationRemovedState extends DashboardState {
  final timeStamp;

  const LocationRemovedState(this.timeStamp);

  @override
  List<Object> get props => [timeStamp];
}

final class LocationUpdateState extends DashboardState {
  final timeStamp;

  const LocationUpdateState(this.timeStamp);

  @override
  List<Object> get props => [timeStamp];
}

final class ScreenChangedState extends DashboardState {
  final timeStamp;

  const ScreenChangedState(this.timeStamp);

  @override
  List<Object> get props => [timeStamp];
}
