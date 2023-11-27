import 'package:flutter/material.dart';

class PreparationWidget extends StatelessWidget {
  final Map<String, String> stepMap;

  const PreparationWidget({Key? key, required this.stepMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: stepMap.entries.toList().asMap().entries.map((entry) {
        int index = entry.key + 1;
        MapEntry<String, String> stepEntry = entry.value;
        return Wrap(
          children: [
            Text(
              "Step $index: ${stepEntry.key}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              stepEntry.value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
