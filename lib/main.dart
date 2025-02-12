import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment_oru_phone_app/pages/home_page/home_page.dart';
import 'package:flutter_assignment_oru_phone_app/pages/splash_screen.dart';
import 'package:flutter_assignment_oru_phone_app/providers/filter_sort_provider.dart';
import 'package:flutter_assignment_oru_phone_app/providers/general_api_provider.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'pages/login_otp_page.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Set System UI Mode (Keeps status bar visible but transparent)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Make Status Bar Transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Fully transparent
      statusBarIconBrightness: Brightness.dark, // Dark icons (Change to light if needed)
      systemNavigationBarColor: Colors.transparent, // Transparent navigation bar (optional)
      systemNavigationBarIconBrightness: Brightness.dark, // Dark navigation icons
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
        ChangeNotifierProvider(create: (context) => GeneralApiProvider(context.read<UserAuthProvider>())),
        ChangeNotifierProvider(create: (context) => FilterSortProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
