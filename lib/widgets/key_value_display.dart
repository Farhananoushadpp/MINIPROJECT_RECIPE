import 'package:flutter/material.dart';

class KeyValueDisplay extends StatelessWidget {
  final Map<String, String> keyValueMap;

  const KeyValueDisplay({Key? key, required this.keyValueMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: keyValueMap.entries
          .map(
            (entry) => Wrap(
              children: [
                Text(
                  '${entry.key}: ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  entry.value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}