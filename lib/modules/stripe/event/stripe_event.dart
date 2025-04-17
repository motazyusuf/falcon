part of '../import/stripe_import.dart';

class StripeInitialEvent extends BaseEvent {}
class MakePaymentEvent extends BaseEvent {
  int amount;
  String currency;
  MakePaymentEvent({required this.amount, required this.currency});
}
