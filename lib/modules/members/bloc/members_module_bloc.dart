part of '../import/members_module_import.dart';

class MembersModuleBloc extends BaseBloc {
  MembersModuleBloc()
    : super(MembersModuleStateFactory(), initialState: ProductsInitialState()) {
    on<GetMembersEvent>(myFunction);
  }

  Future<void> myFunction(GetMembersEvent event, Emitter emit) async {
    emit(LoadingStateNonRender());
    await Future.delayed(Duration(seconds: 4));
    emit(EndLoadingStateNonRender());
  }
}
