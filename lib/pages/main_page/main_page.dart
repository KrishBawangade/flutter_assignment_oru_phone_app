import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/widgets/main_app_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainAppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Text("Home View")
          ]
        )
      )
    );
  }
}