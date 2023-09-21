import 'package:flutter/material.dart';

String avatarImage = 'assets/images/avatar.jpg';
String avatarImage1 = 'assets/images/avatar1.jpg';

class AvatarChanger extends StatefulWidget {
  const AvatarChanger({Key? key}) : super(key: key);

  @override
  _AvatarChangerState createState() => _AvatarChangerState();
}

class _AvatarChangerState extends State<AvatarChanger> {
  bool isImage1 = true;

  void toggleImage() {
    setState(() {
      isImage1 = !isImage1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleImage,
      child: SizedBox(
        height: 40,
        width: 40,
        child: ClipOval(
          child: Image.asset(
            isImage1 ? avatarImage : avatarImage1,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
