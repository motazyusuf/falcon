part of '../import/members_module_import.dart';

class MembersModuleScreen extends StatefulWidget {
  final MembersModuleBloc bloc;

  const MembersModuleScreen({super.key, required this.bloc});

  @override
  MembersModuleScreenState createState() => MembersModuleScreenState(bloc);
}

class MembersModuleScreenState
    extends BaseScreen<MembersModuleBloc, MembersModuleScreen, dynamic> {
  MembersModuleScreenState(super.bloc);

  int currentIndex = 0;

  @override
  bool? get ignoreSafeArea => true;

  @override
  // TODO: implement ignoreScaffold
  bool get ignoreScaffold => true;

  @override
  Widget buildWidget(BuildContext parentContext, RenderDataState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.h, // Adjust height as needed
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search for a member",
                hintStyle: context.textTheme.bodyLarge,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded, color: Colors.grey, size: 25.r,),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: FlexibleGridView(
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              builder:
                  (context, index) => Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF353535),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
              itemCount: 10,
              crossAxisCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
