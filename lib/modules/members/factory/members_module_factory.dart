part of '../import/members_module_import.dart';

class MembersModuleStateFactory extends BaseFactory {
  @override
  BaseState getState<M>(M data) {
    return DefaultState();
  }
}
