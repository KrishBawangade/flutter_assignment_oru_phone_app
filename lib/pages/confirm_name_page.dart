import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/pages/home_page/home_page.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'package:flutter_assignment_oru_phone_app/utils/colors.dart';
import 'package:flutter_assignment_oru_phone_app/utils/constants.dart';
import 'package:flutter_assignment_oru_phone_app/utils/functions.dart';
import 'package:provider/provider.dart';

class ConfirmNamePage extends StatelessWidget {
  ConfirmNamePage({super.key});

  final TextEditingController _nameController = TextEditingController();

  /// **🔹 Check if Name Field is Valid**
  bool _isFormValid() {
    return _nameController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    UserAuthProvider authProvider = Provider.of(context);
    _nameController.text = authProvider.userName??"";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// **🔹 Close Button**
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
                    },
                    icon: const Icon(Icons.close, color: Colors.black, size: 30),
                  )
                ],
              ),
              const SizedBox(height: 16),

              /// **🔹 App Logo**
              Center(
                child: Image.asset(AppConstants.oruPhoneLogoImagePath, width: 120, height: 120),
              ),
              const SizedBox(height: 16),

              /// **🔹 Welcome Text**
              Center(
                child: Column(
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: AppColors.colorPrimary,
                        fontFamily: AppConstants.poppinsFontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Signup to continue",
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),

              /// **🔹 Name Input Field**
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Please tell us your name ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "*",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  TextSelectionTheme(
                    data: TextSelectionThemeData(
                      cursorColor: AppColors.colorPrimary,
                      selectionColor: AppColors.colorPrimary.withAlpha(80),
                      selectionHandleColor: AppColors.colorPrimary,
                    ),
                    child: TextField(
                      controller: _nameController,
                      onChanged: authProvider.setUserName,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(color: Theme.of(context).hintColor.withAlpha(60)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).hintColor.withAlpha(60)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).hintColor.withAlpha(60)),
                        ),
                        
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),

              /// **🔹 Submit Button**
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: authProvider.isLoading
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(color: AppColors.colorPrimary),
                      ],
                    )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white,
                          disabledBackgroundColor: Theme.of(context).hintColor.withAlpha(100),
                          backgroundColor: _isFormValid()
                              ? AppColors.colorPrimary
                              : Theme.of(context).hintColor.withAlpha(100),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        onPressed: _isFormValid()
                            ? () async {
                                
                                await authProvider.updateUserName(_nameController.text.trim(), onError: (error){
                                  AppFunctions.showSimpleToastMessage(
                                    msg: error.isEmpty ? "Failed to update name." : error,
                                  );
                                }, onSuccess: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
                                }); 
                              }
                            : null, // ✅ Disable button if name is empty
                
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Confirm Name",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 24),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
