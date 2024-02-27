part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

final class AddLocationEvent extends DashboardEvent {
  final String fromLocation, toLocation;

  const AddLocationEvent({
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  List<Object> get props => [fromLocation, toLocation];
}

final class RemoveLocationEvent extends DashboardEvent {
  final int id;
  const RemoveLocationEvent({required this.id});
  @override
  List<Object> get props => [id];
}

final class UpdateLocationEvent extends DashboardEvent {
  final int id;
  final String fromLocation, toLocation;

  const UpdateLocationEvent({
    required this.id,
    required this.fromLocation,
    required this.toLocation,
  });
  @override
  List<Object> get props => [id, fromLocation, toLocation];
}

final class ChangeScreenEvent extends DashboardEvent {
  final String screenName;
  const ChangeScreenEvent({required this.screenName});
}
