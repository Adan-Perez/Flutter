import 'package:flutter/material.dart';

class HelloWorldButton extends StatelessWidget {
  const HelloWorldButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hello, world!'),
          ),
        );
      },
      child: const Text('Hello, world!'),
    );
  }
}
