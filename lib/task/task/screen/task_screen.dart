part of '../import/task_import.dart';

class TaskScreen extends StatefulWidget {
  final TaskBloc bloc;

  const TaskScreen({super.key, required this.bloc});

  @override
  _TaskScreenState createState() => _TaskScreenState(bloc);
}

class _TaskScreenState extends BaseScreen<TaskBloc, TaskScreen, dynamic> {
  _TaskScreenState(super.bloc);



  @override
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(
    backgroundColor: Colors.black,
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      toolbarHeight: screenHeight * 0.08,
      automaticallyImplyLeading: false,
      // Disable default back button
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/task/appbar.jpeg"),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      title: Text("Family Members"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {


    if (state is MembersLoaded) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    bloc.allSelected
                        ? postEvent(DeselectAllEvent())
                        : postEvent(SelectAllEvent());
                  },
                  child: Text(
                    bloc.allSelected ? "Deselect All" : "Select All",
                    style: TextStyle(color: Color(0xffB68B26), fontSize: 13.sp),
                  ),
                ),
              ),
              10.ph,
              Column(children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bloc.ahlyMembers.length,
                  shrinkWrap: true,
                  itemBuilder:
                      (context, index) => Padding(
                    padding:  EdgeInsets.only(bottom: 20.h),
                    child: FamilyMember(
                      member: bloc.ahlyMembers[index],
                      onActivitySelected: (activity) {
                        activity.isSelected!
                            ? postEvent(
                          ActivityDeSelectionEvent(
                            activity.activityName!,
                            index,
                          ),
                        )
                            : postEvent(
                          ActivitySelectionEvent(
                            activity.activityName!,
                            index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                10.ph,
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Total ${bloc.selectedActivitiesCounter} Selected",
                          ),
                        ),
                        Text("${bloc.total.toInt()} EGP"),
                      ],
                    ),
                    20.ph,
                  ],
                ),
                CoreButton(
                  title: "Proceed to Checkout",
                  backgroundColor: Color(0xffc50101),
                  height: screenHeight * 0.045,
                ),
                20.ph,
                SizedBox(
                  height: screenHeight * 0.05,
                  child: Image.asset(
                    "assets/images/task/sponsored_logo_02_1.webp",
                  ),
                ),
              ],),
            ],
          ),
        ),
      );
    } else {
      return 10.ph;
    }
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
