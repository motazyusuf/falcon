part of '../import/members_module_import.dart';

final class MembersInitialState extends RenderDataState {
  MembersInitialState() : super(null);
}

// final class MembersLoaded extends RenderDataState {
//   Members? products;
//   MembersLoaded(this.products) : super(null);
// }

final class MembersLoaded extends RenderDataState {
  List<Member> members;

  MembersLoaded(this.members,) : super(null);
}

final class MemberAdded extends NonRenderState {}

final class MemberError extends NonRenderState {}
