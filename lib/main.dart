import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment_oru_phone_app/pages/login_otp_page.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Set System UI Mode (Keeps status bar visible but transparent)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Make Status Bar Transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Fully transparent
      statusBarIconBrightness: Brightness.dark, // Dark icons (Change to light if needed)
      systemNavigationBarColor: Colors.transparent, // Transparent navigation bar (optional)
      systemNavigationBarIconBrightness: Brightness.dark, // Dark navigation icons
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOtpPage(),
    );
  }
}
