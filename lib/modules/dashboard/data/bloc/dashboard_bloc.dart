import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/db/db_helper.dart';

import '../models/locatiion_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {});
    on<AddLocationEvent>(addLocation);
    on<RemoveLocationEvent>(removeLocation);
    on<UpdateLocationEvent>(updateLocation);
    on<ChangeScreenEvent>(changeScreen);
  }

  List<LocationModel> locations = [];
  String screenName = "screen-1";

  ///---------------------------- [List Funtions ]-----------------------
  void addLocation(AddLocationEvent event, Emitter<DashboardState> emit) {
    locations.add(
      LocationModel(
        fromLocation: event.fromLocation,
        toLocation: event.toLocation,
      ),
    );
    emit(LocationAddedState(DateTime.timestamp()));
  }

  void removeLocation(RemoveLocationEvent event, Emitter<DashboardState> emit) {
    locations.removeAt(event.id);
    emit(LocationRemovedState(DateTime.timestamp()));
  }

  void updateLocation(UpdateLocationEvent event, Emitter<DashboardState> emit) {
    locations[event.id].fromLocation = event.fromLocation;
    locations[event.id].toLocation = event.toLocation;
    emit(LocationUpdateState(DateTime.timestamp()));
  }

  void changeScreen(ChangeScreenEvent event, Emitter<DashboardState> emit) {
    screenName = event.screenName;
    emit(ScreenChangedState(DateTime.timestamp()));
  }
}
