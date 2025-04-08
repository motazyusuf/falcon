part of '../import/task_import.dart';

class TaskScreen extends StatefulWidget {
  final TaskBloc bloc;

  const TaskScreen({super.key, required this.bloc});

  @override
  _TaskScreenState createState() => _TaskScreenState(bloc);
}

class _TaskScreenState extends BaseScreen<TaskBloc, TaskScreen, dynamic> {
  _TaskScreenState(super.bloc);

  double height = 0;
  double width = 0;

  List<AhlyMember> ahlyMembers = [
    AhlyMember("Nadeen Osama", "10/10/1996", [
      AhlyActivity(
        "Swimming",
        false,
        2,
        1500,
        "assets/images/task/swimmer.png",
        false,
      ),
    ]),
  ];

  @override
  // TODO: implement scaffoldConfig
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(
    backgroundColor: Colors.black,
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      toolbarHeight: context.screenSize.height * 0.08,
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
    height = context.screenSize.height;
    width = context.screenSize.width;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "Select all",
                style: TextStyle(color: Color(0xffB68B26), fontSize: 13.sp),
              ),
            ),
            10.ph,
            Expanded(
              child: ListView.separated(separatorBuilder: (context, index) => 30.ph,
                itemCount: 3,
                itemBuilder:
                    (context, index) =>
                        FamilyMember(member: ahlyMembers[0]),
              ),
            ),
            10.ph,
            Visibility(
              visible: false,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Text("Total 7 Selected")),
                      Text("200000 EGP")
                    ],
                  ),
                  20.ph,
                ],
              ),
            ),
            CoreButton(
              title: "Proceed to Checkout",
              backgroundColor: Color(0xffc50101),
              height: height * 0.045,
            ),
            20.ph,
            SizedBox(
              height: context.screenSize.height * 0.05,
              child: Image.asset("assets/images/task/sponsored_logo_02_1.webp"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}


