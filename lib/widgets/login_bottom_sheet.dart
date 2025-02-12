import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/widgets/mobile_no_bottom_sheet_view.dart';

class LoginBottomSheet {
  static void showLoginOtpSheet({required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // Moves up on keyboard open
              ),
              child: SafeArea(
                child: SingleChildScrollView( // Prevents overflow
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MobileNoBottomSheetView(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
