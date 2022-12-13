import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/screens/FilterScreen.dart';
import 'package:maratha_matrimony_app/utils/Constants.dart';

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  final num? tab;
  final String userUid;
  const TopAppBar({Key? key, required this.tab, required this.userUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Soul',
                style: GoogleFonts.amita(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: COLOR_BLACK,
                ),
              ),
              Text(
                'Saathi',
                style: GoogleFonts.amita(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: COLOR_ORANGE,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Visibility(
          visible: tab == 0,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FilterScreen(
                      userUid: userUid,
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              FontAwesomeIcons.sliders,
              color: COLOR_ORANGE,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);
}
