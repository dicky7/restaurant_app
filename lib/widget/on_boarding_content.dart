import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class OnBoardContent extends StatelessWidget {
  final String image, tittle, description;
  const OnBoardContent({Key? key, required this.image, required this.tittle, required this.description,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 250,
          ),
          Text(
            tittle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
