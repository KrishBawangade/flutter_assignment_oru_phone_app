import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'package:flutter_assignment_oru_phone_app/utils/colors.dart';
import 'package:flutter_assignment_oru_phone_app/utils/constants.dart';
import 'package:flutter_assignment_oru_phone_app/utils/functions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  VerifyOtpPageState createState() => VerifyOtpPageState();
}

class VerifyOtpPageState extends State<VerifyOtpPage> {
  int _remainingTime = 30; // Timer starts from 30 seconds
  late Timer _timer;
  bool _canResend = false; // Track resend OTP availability
  final TextEditingController _otpController = TextEditingController();

  /// **🔹 Start Countdown Timer**
  void _startTimer() {
    _canResend = false;
    _remainingTime = 30; // Reset timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        setState(() {
          _canResend = true; // Enable resend button
          timer.cancel(); // Stop timer
        });
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  /// **🔹 Resend OTP Function**
  void _resendOtp(UserAuthProvider authProvider) async {
    _startTimer(); // Restart the timer
    bool success = await authProvider.requestOtp(
        authProvider.countryCode!, authProvider.mobileNumber!);
    if (!success) {
      AppFunctions.showSimpleToastMessage(
          msg: authProvider.errorMessage ?? "Failed to resend OTP");
    } else {
      AppFunctions.showSimpleToastMessage(
          msg: authProvider.errorMessage ?? "OTP Resent Successfully");
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start countdown on page load
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserAuthProvider authProvider = Provider.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// **🔹 Back & Close Buttons**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 30),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.close, color: Colors.black, size: 30),
                  )
                ],
              ),
              const SizedBox(height: 16),

              /// **🔹 App Logo**
              Center(
                child: Image.asset(AppConstants.oruPhoneLogoImagePath,
                    width: 120, height: 120),
              ),
              const SizedBox(height: 16),

              /// **🔹 OTP Instructions**
              Center(
                child: Column(
                  children: [
                    Text(
                      "Verify Mobile No.",
                      style: TextStyle(
                        color: AppColors.colorPrimary,
                        fontFamily: AppConstants.poppinsFontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Please enter the 4-digit verification code sent to your mobile number ",
                            style: TextStyle(
                              color: Theme.of(context).hintColor.withAlpha(100),
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                "+${authProvider.countryCode}-${authProvider.mobileNumber}",
                            style: TextStyle(
                              color: Theme.of(context).hintColor.withAlpha(150),
                              height: 1.5,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: " via ",
                            style: TextStyle(
                              color: Theme.of(context).hintColor.withAlpha(100),
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "SMS",
                            style: TextStyle(
                              color: Theme.of(context).hintColor.withAlpha(150),
                              height: 1.5,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 75),

              /// **🔹 OTP Input**
              Center(
                child: SizedBox(
                  width: 175,
                  child: PinCodeTextField(
                    controller: _otpController,
                    length: 4,
                    appContext: context,
                    animationType: AnimationType.fade,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    cursorHeight: 16,
                    cursorColor: AppColors.colorPrimary,
                    keyboardType: TextInputType.number,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      activeColor: Theme.of(context).hintColor.withAlpha(40),
                      selectedColor: Theme.of(context).hintColor.withAlpha(40),
                      inactiveColor: Theme.of(context).hintColor.withAlpha(40),
                    ),
                    showCursor: _otpController.text.length != 4,
                  ),
                ),
              ),
              const SizedBox(height: 50),

              /// **🔹 Resend OTP with Countdown**
              Center(
                child: Column(
                  children: [
                    Text(
                      "Didn't receive OTP?",
                      style: TextStyle(
                        color: Theme.of(context).hintColor.withAlpha(100),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: _canResend
                              ? () => _resendOtp(authProvider)
                              : null, // ✅ Disable until timer ends,
                          child: Text("Resend OTP",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: _canResend
                                    ? Colors.black
                                    : Theme.of(context)
                                        .hintColor
                                        .withAlpha(100),
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        SizedBox(width: 4),
                        Text(
                            "in 0:${_remainingTime / 10 < 1 ? "0$_remainingTime" : _remainingTime} sec",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),

              /// **🔹 Verify OTP Button**
              authProvider.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                            color: AppColors.colorPrimary),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              disabledForegroundColor: Colors.white,
                              disabledBackgroundColor:
                                  Theme.of(context).hintColor.withAlpha(100),
                              backgroundColor: _otpController.text.length == 4
                                  ? AppColors.colorPrimary
                                  : Theme.of(context).hintColor.withAlpha(100),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            onPressed: _otpController.text.length == 4
                                ? () async {
                                    FocusScope.of(context).unfocus();
                                    bool success = await authProvider
                                        .login(int.parse(_otpController.text));
                                    if (!success) {
                                      AppFunctions.showSimpleToastMessage(
                                          msg: "Please enter correct OTP");
                                      setState(() {
                                        _otpController.text = "";
                                      });
                                    }else{

                                    }
                                  }
                                : null,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("Verify OTP",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
