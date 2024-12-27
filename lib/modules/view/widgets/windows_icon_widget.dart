import 'package:flutter/material.dart';

class WindowsIconWidget extends StatelessWidget {
  const WindowsIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        mouseCursor: SystemMouseCursors.click,
        foregroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/icons/windows.png"),
          radius: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
