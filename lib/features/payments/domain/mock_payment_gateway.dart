import 'dart:math';

import 'package:uuid/uuid.dart';

import '../../../core/enums/app_enums.dart';
import '../../../core/models/payment_record.dart';
import 'payment_gateway.dart';

class MockPaymentGateway implements PaymentGateway {
  MockPaymentGateway() : _uuid = const Uuid();

  final Uuid _uuid;

  @override
  Future<PaymentResult> charge(PaymentRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 1400));

    final shouldFail =
        request.simulateFailure ||
        request.promoCode?.toUpperCase() == 'FAILPAY' ||
        (request.amount > 1800 && request.method == PaymentMethod.wallet);

    final status = shouldFail ? PaymentStatus.failed : PaymentStatus.success;
    final reference =
        'MOCK-${Random().nextInt(999999).toString().padLeft(6, '0')}';

    final amount = request.promoCode?.toUpperCase() == 'FREELOCAL'
        ? request.amount * 0.9
        : request.amount;

    final record = PaymentRecord(
      id: _uuid.v4(),
      bookingId: request.bookingId,
      provider: 'MockPaymentGateway',
      providerReference: reference,
      amount: amount,
      currency: request.currency,
      status: status,
      paidAt: status == PaymentStatus.success ? DateTime.now() : null,
      rawResponse: {
        'method': request.method.name,
        'promo_code': request.promoCode,
        'simulated_failure': request.simulateFailure,
      },
    );

    return PaymentResult(
      record: record,
      message: shouldFail
          ? 'Mock payment failed. Switch method or remove FAILPAY.'
          : 'Payment approved in demo mode.',
    );
  }
}
