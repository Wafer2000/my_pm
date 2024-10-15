abstract class GenericDataState {}

class DataLoading extends GenericDataState {}

class DataSucess<T> extends GenericDataState {
  final T data;
  DataSucess({required this.data});
}

class FailureLoadData extends GenericDataState {
  final String errorMessage;
  FailureLoadData({required this.errorMessage});
}