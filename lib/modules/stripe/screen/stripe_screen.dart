part of '../import/stripe_import.dart';

class StripeScreen extends StatefulWidget {
  final StripeBloc bloc;

  const StripeScreen({super.key, required this.bloc});

  @override
  _StripeScreenState createState() => _StripeScreenState(bloc);
}

class _StripeScreenState extends BaseScreen<StripeBloc, StripeScreen, dynamic> {
  _StripeScreenState(super.bloc);

  @override
  bool get ignoreScaffold => false;

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Stripe Payment test"),
          20.ph,
          CoreButton(
            title: "Make Payment",
            onTap:
                () => postEvent(MakePaymentEvent(amount: 100, currency: 'EGP')),
          ),
        ],
      ),
    );
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
