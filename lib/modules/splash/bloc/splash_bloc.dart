part of '../import/splash_import.dart';

class SplashBloc extends BaseBloc {

    initializeApp(SplashInitialEvent event , Emitter emit) async {
        MaintenanceConfig.instantiate(
            MaintenanceConfig(
                customMessage: "App Unavailable".tr(),
                customMessageButton: "Try Again".tr(),
                customMessageRetryToast: "Retrying".tr(),
            ),
        );
        ApiResponseConfig.instantiate(
            ApiResponseConfig(
                customErrorMessage: "Error Occurred".tr(),
                customNetworkIssuesMessage: "Network Issue".tr(),
                customRequestTimeoutMessage: "Request Timed Out".tr(),
            ),
        );
        NoInternetConfig.instantiate(
            NoInternetConfig(
                customMessage: "No Internet".tr(),
                customMessageButton: "Retry".tr(),
            ),
        );
        await Future.delayed(Duration(milliseconds: 1500));
        emit(AppInitialized());

    }

    SplashBloc() : super(
    SplashFactory(), 
    initialState: SplashInitialState(),
    ) {
        on<SplashInitialEvent>(initializeApp);
        add(SplashInitialEvent());
    }


}
  