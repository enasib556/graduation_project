part of 'table_cubit.dart';

@immutable
sealed class TableState {}

final class TableInitial extends TableState {}
final class ShowFilter extends TableState {
  final List<PlayerData> result;
  ShowFilter(this.result);
}
class GetNewsInitial extends TableState {}

class GetNewsLoading extends TableState {}

class GetNewsSuccess extends TableState {
  final List<PlayerData> responseModel;
  GetNewsSuccess(this.responseModel);
}

class GetNewsError extends TableState {

}
