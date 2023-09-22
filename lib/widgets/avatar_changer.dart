import 'package:flutter/material.dart';

// Almaceno las rutas de las imágenes en variables
String avatarImage = 'assets/images/avatar.jpg';
String avatarImage1 = 'assets/images/avatar1.jpg';

// Creo un widget de tipo StatefulWidget (que puede cambiar de estado) para cambiar la imagen de perfil
class AvatarChanger extends StatefulWidget {
  const AvatarChanger({Key? key}) : super(key: key);

  @override
  _AvatarChangerState createState() => _AvatarChangerState();
}

// Creo una clase que extiende de State (que es el estado del widget)
class _AvatarChangerState extends State<AvatarChanger> {
  bool isImage1 = true;

  // Creo un método para cambiar la imagen
  void toggleImage() {
    setState(() {
      isImage1 = !isImage1;
    });
  }

  // Construyo el widget con un GestureDetector que detecta el tap y llama al método para cambiar la imagen
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
