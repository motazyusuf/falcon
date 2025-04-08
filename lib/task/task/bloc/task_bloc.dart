part of '../import/task_import.dart';

class TaskBloc extends BaseBloc {
    TaskBloc() : super(
    TaskFactory(), 
    initialState: TaskInitialState(),
    ) {}

    @override
    void onDispose() {}
}
  