import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Colors.grey[100].withOpacity(0.3),
        child: InkWell(
          child: SizedBox(
              width: 40, height: 40, child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
