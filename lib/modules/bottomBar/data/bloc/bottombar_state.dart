part of 'bottombar_bloc.dart';

sealed class BottomBarState extends Equatable {
  const BottomBarState();

  @override
  List<Object> get props => [];
}

final class BottomBarInitial extends BottomBarState {}

final class TabChangedState extends BottomBarState {
  final int index;

  const TabChangedState(this.index);

  @override
  List<Object> get props => [index];
}
