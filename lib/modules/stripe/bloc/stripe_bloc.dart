part of '../import/stripe_import.dart';

class StripeBloc extends BaseBloc {
  final MembersModuleRepo membersModuleRepo = MembersModuleRepo();

  StripeBloc() : super(StripeFactory(), initialState: StripeInitialState()) {
      on<MakePaymentEvent>(makePayment);
  }

  Future<void> makePayment(MakePaymentEvent event, Emitter emit) async {
    try {
      //STEP 1: Create Payment Intent
      final response = await membersModuleRepo.createPaymentIntent(
        (event.amount * 100).toString(),
        event.currency,
      );
      var paymentIntent = response?.data;

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Falcon',
              googlePay: const PaymentSheetGooglePay(
                merchantCountryCode: 'EG',
                testEnv: true,
              ),
            ),
          );

      //STEP 3: Display Payment sheet
      try {
        await Stripe.instance
            .presentPaymentSheet()
            .then((value) {
              paymentIntent = null;
            })
            .onError((error, stackTrace) {
              throw Exception(error);
            });
      } on StripeException catch (e) {
        print('Error is:---> $e');
      } catch (e) {
        print('$e');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
