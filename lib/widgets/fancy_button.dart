import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FancyButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;

  FancyButton({this.label, this.onPress, this.color});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.white, width: 2.0),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Container(
          width: 150,
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            '$label',
            style: GoogleFonts.abel(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: onPress,
    );
  }
}
