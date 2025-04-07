part of '../import/splash_import.dart';

class SplashBloc extends BaseBloc {

    initializeApp(SplashInitialEvent event , Emitter emit) async {
        MaintenanceConfig.instantiate(
            MaintenanceConfig(
                customMessage: AppStrings.appUnavailable.tr(),
                customMessageButton: AppStrings.tryAgain.tr(),
                customMessageRetryToast: AppStrings.retrying.tr(),
            ),
        );
        ApiResponseConfig.instantiate(
            ApiResponseConfig(
                customErrorMessage: AppStrings.errorOccurred.tr(),
                customNetworkIssuesMessage: AppStrings.networkIssueDetected.tr(),
                customRequestTimeoutMessage: AppStrings.requestTimedOut.tr(),
            ),
        );
        NoInternetConfig.instantiate(
            NoInternetConfig(
                customMessage: AppStrings.noInternetMessage.tr(),
                customMessageButton: AppStrings.retry.tr(),
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
  