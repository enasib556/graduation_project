//part of 'table_cubit.dart';

import 'package:graduation_project_iti/data/models/players_model.dart';

sealed class TableState {}

final class TableInitial extends TableState {}
final class ShowFilter extends TableState {
  final Team result;
  ShowFilter(this.result);
}
class GetNewsInitial extends TableState {}

class GetNewsLoading extends TableState {}

class GetNewsSuccess extends TableState {
  final Team responseModel;
  GetNewsSuccess(this.responseModel);
}

class GetNewsError extends TableState {

}