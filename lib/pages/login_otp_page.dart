import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment_oru_phone_app/pages/verify_otp_page.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'package:flutter_assignment_oru_phone_app/utils/functions.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({super.key});

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  final TextEditingController _mobNoTextController = TextEditingController();
  bool _isTermsAndConditionChecked = false;
  bool _isMobileValid = false; // ✅ Tracks if the mobile number is valid

  /// ✅ Validate mobile number & close keyboard when length is 10
  void _validateMobileNumber(String value) {
    setState(() {
      if (value.length == 10) {
        FocusScope.of(context).unfocus(); // Close the keyboard
        _isMobileValid = true; // Mark as valid
      } else {
        _isMobileValid = false; // Invalid if less than 10 digits
      }
    });
  }

  /// ✅ Checks if both conditions are met to enable the button
  bool _isFormValid() {
    return _isMobileValid && _isTermsAndConditionChecked;
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
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                  onPressed: () {
                    // TODO("Navigate to home page")
                  },
                  icon: const Icon(Icons.close, color: Colors.black, size: 30),
                )
              ]),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(AppConstants.oruPhoneLogoImagePath,
                    width: 120, height: 120),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Text("Welcome",
                        style: TextStyle(
                            color: AppColors.colorPrimary,
                            fontFamily: AppConstants.poppinsFontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    const SizedBox(height: 8),
                    Text("Sign in to continue",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Enter Your Phone Number",
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  TextSelectionTheme(
                    data: TextSelectionThemeData(
                      cursorColor: AppColors.colorPrimary,
                      selectionColor: AppColors.colorPrimary.withAlpha(80),
                      selectionHandleColor: AppColors.colorPrimary,
                    ),
                    child: TextField(
                      controller: _mobNoTextController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10, // Limit input to 10 digits
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Restrict to numbers
                      onChanged:
                          _validateMobileNumber, // Call validation function
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).hintColor.withAlpha(30)),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "Mobile Number",
                        counterText: "", // Hide character counter
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "+91",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 120),
              Row(children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withAlpha(100)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Checkbox(
                    value: _isTermsAndConditionChecked,
                    side: const BorderSide(color: Colors.transparent, width: 0),
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      return Colors.transparent;
                    }),
                    checkColor: Colors.green,
                    onChanged: (isChecked) {
                      setState(() {
                        _isTermsAndConditionChecked = isChecked!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                const Text("Accept",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(width: 4),
                Text("Terms and Conditions",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.colorPrimary,
                        fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 16),
              authProvider.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            color: AppColors.colorPrimary),
                      ],
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white,
                        disabledBackgroundColor:
                            Theme.of(context).hintColor.withAlpha(100),
                        backgroundColor: _isFormValid()
                            ? AppColors.colorPrimary
                            : Theme.of(context)
                                .hintColor
                                .withAlpha(100), // Disabled state color
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: _isFormValid()
                          ? () async {
                              bool success = await authProvider.requestOtp(
                                  91, int.parse(_mobNoTextController.text));
                              if (!success) {
                                AppFunctions.showSimpleToastMessage(
                                    msg: authProvider.errorMessage!);
                              } else {
                                AppFunctions.showSimpleToastMessage(
                                    msg: "Otp Sent Successfully");
                                if (context.mounted) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => VerifyOtpPage()));
                                }
                              }
                            }
                          : null, // Disable button if form is invalid
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Next",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 24)
                            ]),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
