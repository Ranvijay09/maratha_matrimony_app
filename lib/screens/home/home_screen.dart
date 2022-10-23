import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/components/user_card.dart';
import 'package:maratha_matrimony_app/utils/constants.dart';

import '../../components/home_screen_app_bar.dart';
import '../../components/my_bottom_nav_bar.dart';
import 'package:maratha_matrimony_app/models/all_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: HomeScreenAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserCard(user: User.users[0]),
            UserCard(user: User.users[1]),
            UserCard(user: User.users[2]),
            SizedBox(height: 10)
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}
