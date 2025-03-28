part of '../import/members_module_import.dart';

class MembersModuleBloc extends BaseBloc {
  MembersModuleBloc()
    : super(MembersModuleStateFactory(), initialState: ProductsInitialState()) {
    // on<Event>(function);
  }
}
