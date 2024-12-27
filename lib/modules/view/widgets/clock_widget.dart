import 'package:flutter/material.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream:
          Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final now = snapshot.data!;
          final formattedDate =
              "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
          final formattedTime =
              "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                formattedTime,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
