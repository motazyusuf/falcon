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

  @override
  bool? get ignoreSafeArea => true;

  @override
  bool get ignoreScaffold => true;

  CancelFunc? cancelFunc;

  @override
  void showLoading() {
    super.closeKeyboard();
    cancelFunc?.call();
    cancelFunc = BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        this.cancelFunc = cancelFunc; // Store the cancel function here
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // Full-screen overlay
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/falcon_logo.png",
                    fit: BoxFit.cover,
                    height: 200.h,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: LinearProgressIndicator(color: Colors.red),
                  ),
                  // Custom color
                ],
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent, // Remove default overlay
      allowClick: false, // Prevent taps
    );
  }

  @override
  void hideLoading() {
    cancelFunc?.call();
  }

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
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintText: MyStrings.searchByMobileNumber,
                hintStyle: context.textTheme.bodyLarge,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                  size: 25.r,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          state is MembersLoaded && state.members.isNotEmpty
              ? Expanded(
                child: FlexibleGridView(
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  builder:
                      (context, index) => Text(
                        state.members[index].firstName,
                        style: TextStyle(color: Colors.red),
                      ),
                  itemCount: state.members.length,
                  crossAxisCount: 2,
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
