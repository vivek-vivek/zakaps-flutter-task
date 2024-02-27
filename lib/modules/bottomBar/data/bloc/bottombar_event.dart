part of 'bottombar_bloc.dart';

sealed class BottomBarEvent extends Equatable {
  const BottomBarEvent();

  @override
  List<Object> get props => [];
}

final class ChangeBottomBarTabEvent extends BottomBarEvent {
  final int index;

  const ChangeBottomBarTabEvent(this.index);

  @override
  List<Object> get props => [index];
}
