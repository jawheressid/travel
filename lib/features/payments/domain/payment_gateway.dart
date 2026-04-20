import '../../../core/enums/app_enums.dart';
import '../../../core/models/payment_record.dart';

class PaymentRequest {
  const PaymentRequest({
    required this.bookingId,
    required this.amount,
    required this.currency,
    required this.method,
    this.promoCode,
    this.simulateFailure = false,
  });

  final String bookingId;
  final double amount;
  final String currency;
  final PaymentMethod method;
  final String? promoCode;
  final bool simulateFailure;
}

class PaymentResult {
  const PaymentResult({required this.record, required this.message});

  final PaymentRecord record;
  final String message;
}

abstract class PaymentGateway {
  Future<PaymentResult> charge(PaymentRequest request);
}
