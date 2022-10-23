import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maratha_matrimony_app/utils/constants.dart';

class HomeScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.sliders,
            color: COLOR_ORANGE,
            size: 20,
          ),
        ),
      ],
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);
}
