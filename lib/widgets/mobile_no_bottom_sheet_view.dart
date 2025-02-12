import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'package:flutter_assignment_oru_phone_app/utils/colors.dart';
import 'package:flutter_assignment_oru_phone_app/utils/functions.dart';
import 'package:provider/provider.dart';

class MobileNoBottomSheetView extends StatefulWidget {
  const MobileNoBottomSheetView({super.key});

  @override
  State<MobileNoBottomSheetView> createState() =>
      _MobileNoBottomSheetViewState();
}

class _MobileNoBottomSheetViewState extends State<MobileNoBottomSheetView> {
  final TextEditingController _mobNoTextController = TextEditingController();
  bool _isTermsAndConditionChecked = false;
  bool _isMobileValid = false; // ✅ Tracks if the mobile number is valid

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Sign in to continue",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.close, size: 30))
          ]),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                    onChanged: _validateMobileNumber, // Call validation function
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
            const SizedBox(height: 16),
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
              const Text("Accept", style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(width: 4),
              Text("Terms and Conditions",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.colorPrimary,
                      fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: authProvider.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.colorPrimary),
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
                              await authProvider.requestOtp(
                                  91, int.parse(_mobNoTextController.text),
                                  onError: (errorMsg) {
                                AppFunctions.showSimpleToastMessage(
                                    msg: errorMsg);
                              }, onSuccess: () {
                                AppFunctions.showSimpleToastMessage(
                                    msg: "Otp Sent Successfully");
                              });
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
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 24)
                            ]),
                      ),
                    ),
            )
          ]),
        )
      ],
    );
  }
}
