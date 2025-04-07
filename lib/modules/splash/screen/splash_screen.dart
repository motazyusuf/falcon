part of '../import/splash_import.dart';

class SplashScreen extends StatefulWidget {
  final SplashBloc bloc;
  const SplashScreen({super.key, required this.bloc});

  @override
  _SplashScreenState createState() => _SplashScreenState(bloc);
}

class _SplashScreenState extends BaseScreen<SplashBloc, SplashScreen, dynamic> {
  _SplashScreenState(super.bloc);

  @override
  // TODO: implement scaffoldConfig
  ScaffoldConfig get scaffoldConfig => ScaffoldConfig(backgroundColor: Colors.black);
  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Align(
      alignment: Alignment.center,
      child: ZoomIn(duration: Duration(milliseconds: 700),
        child: SizedBox(
            height : 350.h,
            width : 350.w,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.logo),
                Expanded(
                  child: Text(
                    AppStrings.whereChampionsAreMade,
                    style: TextStyle().copyWith(fontSize: 20.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  void listenToState(BuildContext context, BaseState state) {
    if(state is AppInitialized){
      print("State is $state");
      context.pushReplacementNamed(PagesRoutes.mainLayout);
    }

  }
}
  