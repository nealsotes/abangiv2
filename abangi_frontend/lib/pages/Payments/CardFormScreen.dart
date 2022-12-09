//generate card form screen

import 'dart:convert';

import 'package:abangi_v1/Models/Rental.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat_approval.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

import '../../api/api.dart';

//statefull widget
class CardFormScreen extends StatefulWidget {
  late RentalModel rental;
  CardFormScreen({Key? key, required this.rental}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CardFormScreenState createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: !useBackgroundImage
                ? const DecorationImage(
                    image: ExactAssetImage('assets/bg.png'),
                    fit: BoxFit.fill,
                  )
                : null,
            color: Colors.black,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Axis Bank',
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.red,
                  backgroundImage:
                      useBackgroundImage ? 'assets/card_bg.png' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.white,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            child: Text(
                              "Pay ${widget.rental.rentalPrice}",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //handle your payment here
                              handlePayment();
                            } else {
                              print('invalid!');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });

    //clear card details
  }

  void handlePayment() async {
    //handle your payment here
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.getString('email');
    var name = localStorage.getString('user');
    var customer = {
      "email": email,
      "name": name,
      "card": {
        "number": cardNumber,
        "expYear": expiryDate.substring(3, 5),
        "expMonth": expiryDate.substring(0, 2),
        "cvc": cvvCode
      }
    };

    var res = await CallApi().postData(customer, 'api/stripe/customer');
    var body = json.decode(res.body);
    var payment = {
      "currency": "USD",
      "amount": widget.rental.rentalPrice * 100,
      "customerId": body['customerId'].toString(),
      "receiptEmail": body['email'].toString(),
      "description": "Test Payment"
    };
    if (res.statusCode == 200) {
      var res = await CallApi().postData(payment, 'api/stripe/charge');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Payment Successful',
          buttonsTextStyle: const TextStyle(color: Colors.white),
          showCloseIcon: false,
          btnOkOnPress: () async {
            try {
              var data = [
                {"op": "replace", "path": "rentalStatus", "value": "Paid"},
                {
                  "op": "replace",
                  "path": "rentalRemarks",
                  "value": "Please return the item on ${widget.rental.endDate}"
                }
              ];

              await CallApi()
                  .patchData(data, 'api/rentals/${widget.rental.rentalId}');
            } catch (e) {
              print(e);
            }
            setState(() {
              widget.rental.rentalStatus = 'Paid';
              widget.rental.rentalRemarks =
                  "Please return the item with the same condition as you received it";
            });
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            var userName = localStorage.getString('user');
            sendNotification(userName.toString(), "Have paid the rent");
            //go back to previous page
            Navigator.pop(context);
          },
        ).show();
        //clear card details

      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Error',
          desc: 'Payment Failed',
          buttonsTextStyle: const TextStyle(color: Colors.white),
          showCloseIcon: false,
          btnOkOnPress: () {},
        ).show();
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Network Error',
        desc: ' Please check your internet connection',
        buttonsTextStyle: const TextStyle(color: Colors.white),
        showCloseIcon: false,
        btnOkOnPress: () {},
      ).show();
    }
  }

  void sendNotification(String title, String body) async {
    // String? token = await FirebaseMessaging.instance.getToken();
    String tokenRaffysPhone =
        "fLTbtSOoRnO7OYshH2obN2:APA91bGOoSVmWjmVw9qnXYWYWPPIl2RbO_I_PQH5qV5k7lLlzCgCi7hrbcH2sWBBwIH-5NMvhMwQ57hC6n9otMBCB3NE4unoOYZ3IOK0SKFS3FTpWbvzKQPUpZeUzZxCa0zT_6czrHl5";
    String vivoPhone =
        "fBaPVO0kQYqhPcR7ygm8d6:APA91bHodFIZ1UCrGNVRPHNjrPq5MmS_HVvvCxVv5hZZ3nnF4CzjVzTMVKoaXEnVPsMDanBhYZj1LhZPMimFOykoWJCmzr2WfZVIMpvA5eZY_G24YDQX8TvePEnBMasCPwVDqpjYalSd";
    print(vivoPhone);
    var data = {
      "deviceId": tokenRaffysPhone,
      "isAndroidDevice": true,
      "title": title,
      "body": body,
    };

    var res = await CallApi().postData(data, "api/notification/send");
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print(res.body);
    }
  }
}
