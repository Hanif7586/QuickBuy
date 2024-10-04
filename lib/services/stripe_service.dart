import 'package:dio/dio.dart';

import 'package:flutter_stripe/flutter_stripe.dart';

import '../widgets/consts.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment(int amount, String currency) async {
    try {
      String? paymentIntentClientSecret=await _createPaymentIntent(
          10,
          "usd"
      );
      if(paymentIntentClientSecret==null)return;
      await Stripe.instance.initPaymentSheet
        (paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "Husain Mustafa",
      ),

      );
      await _processPayment();
    } catch (e) {
      print("Error making payment: $e");
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String,dynamic>data={
        "amount":_calculateAmount(
            amount,
        ),
        "currency":currency,

      };
      var response=await dio.post("https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization":"Bearer $stripeSecretKey",
            "Content-Type":'application/x-www-form-urlencoded'

          },
        )
      );
      if(response.data!=null){

        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print("Error creating payment intent: $e");
    }
    return null;
  }
  Future<void>_processPayment()async{
    try{
      await Stripe.instance.presentPaymentSheet();
    }
    catch(e){}
  }

  String _calculateAmount(int amount){
    final calculateAmount=amount*100;
    return calculateAmount.toString();
  }
}