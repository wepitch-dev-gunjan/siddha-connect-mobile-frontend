import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:siddha_connect/utils/message.dart';

final paymentProvider =
    Provider.autoDispose<PaymentGatway>((ref) => PaymentGatway(ref: ref));

class PaymentGatway {
  final AutoDisposeProviderRef<PaymentGatway> ref;
  late Razorpay _razorpay;
  late BuildContext buildContext;
  double? totalAmmount;

  PaymentGatway({required this.ref});

  initialGatway({double? totalAmmount}) {
    this.totalAmmount = totalAmmount;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successFun);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorFun);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletFun);
  }

  successFun(PaymentSuccessResponse response) {
    log("Success response => $response");
    showSnackBarMsg("Success Payment");
  }

  errorFun(PaymentFailureResponse response) {
    log("Error code: ${response.code}");
    log("Error message: ${response.message}");
    showSnackBarMsg("Payment Failed: ${response.message}");
  }

  externalWalletFun(ExternalWalletResponse response) {
    log("Wallet response => $response");
    showSnackBarMsg("Wallet Payment");
  }

  openPaymentWindow({required double ammount, String? phone, String? email}) {
    var options = {
      // 'key': 'rzp_live_w59Hv2Yjl9LaHn',
      'amount': "${ammount * 100}",
      'name': 'Your App Name',
      'send_sms_hash': true,
      'retry': {'enabled': true, 'max_count': 1},
      'external': {
        'wallets': ['Paytm']
      },
      'description': 'Payment for Order',
      'currency': 'INR',
      'prefill': {'contact': '$phone', 'email': '$email'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      log("Open Error: $e");
      return e.toString();
    }
  }
}
