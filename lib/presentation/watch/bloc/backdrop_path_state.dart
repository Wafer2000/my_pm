abstract class BackdropPathState {}

class BackdropPathLoading extends BackdropPathState {}

class BackdropPathLoaded extends BackdropPathState {
  final String backdropUrl;
  BackdropPathLoaded({required this.backdropUrl});
}

class FailuerLoadBackdropPath extends BackdropPathState {
  final String errorMessage;
  FailuerLoadBackdropPath({required this.errorMessage});
}