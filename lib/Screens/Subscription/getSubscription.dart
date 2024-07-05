import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/Screens/Subscription/renewSubscription.dart';
import 'package:restaurant_app/Screens/Subscription/subscribe_card.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class GetSubscription extends StatefulWidget {
  const GetSubscription({super.key});

  @override
  State<GetSubscription> createState() => _GetSubscriptionState();
}

class _GetSubscriptionState extends State<GetSubscription> {
  Razorpay razorpay = Razorpay();
  bool isLoading = false;
  Widget _buildRow(String text) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Colors.black,
        ),
        SizedBox(width: 2.h),
        Text(
          text,
          style: body4TextStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SubscribeCard(),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
              //   child: SizedBox(
              //     width: 100.w,
              //     child: Text(
              //       'How do refer and earn work?'.toUpperCase(),
              //       style: body3TextStyle,
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      // height: 22.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.2.h, color: primaryColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/images/subscribe.png'),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Subscribe to Nukkad foods',
                            style: body3TextStyle.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            width: 60.w,
                            child: Column(
                              children: [
                                _buildRow('2x New customers'),
                                SizedBox(height: 2.h),
                                _buildRow('3x Repeat customers'),
                                SizedBox(height: 2.h),
                                _buildRow('More Orders'),
                                SizedBox(height: 2.h),
                                _buildRow('More Earnings'),
                              ],
                            ),
                          )
                        ],
                      ),

                      // Stack(
                      //   children: [
                      //     Positioned(
                      //       bottom: -15,
                      //       right: 40,
                      //       child: Image.asset('assets/images/refer_4.png'),
                      //     ),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           '4.',
                      //           style:
                      //               h3TextStyle.copyWith(color: primaryColor),
                      //         ),
                      //         SizedBox(
                      //           width: 75.w,
                      //           child: Text(
                      //               'You both earn 50 wallet cash each, that can be used while placing orders. ',
                      //               style: body4TextStyle),
                      //         )
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: mainButton('Subscribe at just ₹ 399',
                                textWhite, routeHome),
                          ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                        child: Text(
                          'For 4 Month',
                          style: body4TextStyle.copyWith(
                              color: primaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  routeHome() async {
    paymentAPi();
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const RenewSubscription(),
    //   ),
    // );
  }

  void paymentAPi() {
    var options = {
      'key': 'rzp_test_wQQru4jnFZS6Qb',
      'amount': 1000,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    print('handlePaymentErrorResponse');
    // showAlertDialog(context, "Payment Failed",
    //     "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    print("successs");
    callBackPaymentAPI(response.data);
  }

  Future<void> callBackPaymentAPI(responseData) async {
    setState(() {
      isLoading = true;
    });

    // Construct the request body
    String requestBody = jsonEncode({
      "razorpay_order_id": responseData["razorpay_order_id"],
      "razorpay_payment_id": responseData["razorpay_payment_id"],
      "razorpay_signature": responseData["razorpay_signature"],
      // "order_data": order
    });

    try {
      // var baseUrl = dotenv.env['BASE_URL'];
      final response = await http.post(
        Uri.parse('https://deliveryapi.algofolks.com/payments/payment/verify/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body);
        if (status['message'] == true) {
          Navigator.of(context).pushNamed('/Pages', arguments: 2);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Your payment sucessfull")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid payment")),
          );
        }

        // setState(() {
        //     isLoading = false;
        // });
        // print('Order Update successful');
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error Order Update: ${response.statusCode}');
        // throw Exception('Error Order Update: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Exception occurred while Order Update: $e');
      throw e; // Rethrow the exception to propagate it further if needed
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
