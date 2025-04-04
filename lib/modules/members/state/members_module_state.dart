part of '../import/members_module_import.dart';

final class MembersInitialState extends RenderDataState {
  MembersInitialState() : super(null);
}


final class MembersLoaded extends RenderDataState {
  List<Member> members;

  MembersLoaded(this.members) : super(null);
}

final class SearchedMembersLoaded extends RenderDataState {
  SearchedMembersLoaded() : super(null);
}

final class MembersFiltered extends RenderDataState {
  List<Member> filteredMembers;

  MembersFiltered(this.filteredMembers) : super(null);
}

final class MemberDeleted extends NonRenderState {
  MemberDeleted();
}

final class MemberDetails extends NonRenderState {
  List<Member> list;
  int index;

  MemberDetails(this.index, this.list);
}
