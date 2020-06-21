import 'package:ausocial/constants.dart';
import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Color(primaryGreen),
      ),
    ),
  );
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 5.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Color(primaryGreen),
      ),
    ),
  );
}
