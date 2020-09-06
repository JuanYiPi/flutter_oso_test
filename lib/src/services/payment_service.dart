import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String authority = DotEnv().env['STRIPE_BASE_URL'];  
  static String secret = DotEnv().env['STRIPE_API_KEY'];

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: "pk_test_51HE3hWLqOx6ORpCapysjhLNdqUQ5JVzStTqrmZ2ycJBPX6R986uGWgL8pyQs38hKQ6SgW1gNWM14pRk3ZIn9oJGU00pNKNVHd5", 
        merchantId: "Test", 
        androidPayMode: 'test'
      )
    );
  }

  static StripeTransactionResponse payViaExistingCard({String amount, String currency, card}) {
    return new StripeTransactionResponse(
      message: 'Transaccion exitosa',
      success: true
    );
  }

  static Future<StripeTransactionResponse> payWithNewCard({String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      var paymentIntent = await StripeService.createPaymentIntent(amount, currency);

      var res = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id
        )
      );

      if (res.status == 'succeeded') {
        return new StripeTransactionResponse(
          message: 'Transaccion exitosa',
          success: true
        );
      } else {
        return new StripeTransactionResponse(
          message: 'Error en la transaccion',
          success: false
        );
      }
      
    } on PlatformException catch (err){
      return StripeService.getPlatformExceptionResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
        message: 'Error en la transaccion: ${err.toString()}',
        success: false
      );
    }
  }

  static getPlatformExceptionResult(err) {
    String message = 'Algo salio mal';
    if (err.code == 'cancelled') {
      message = 'Operacion cancelada';
    }
    return new StripeTransactionResponse(
      message: message,
      success: false
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {

    final url = Uri.https(authority, 'v1/payment_intents');

    Map<String, dynamic> body = {
      'amount'  : amount,
      'currency': 'mxn',
      'payment_method_types[]': 'card',
    };
    
    try {
      var response = await http.post(
        url,
        body: body,
        headers: StripeService.headers
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charing user: ${err.toString()}');
    }
    return null;
  }
}