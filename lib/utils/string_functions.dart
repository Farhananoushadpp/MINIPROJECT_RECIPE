Map<String, String> parseLargeString(String input) {
  input = removeSpacesAfterPeriod(input);
  List<String> parts = input.split('.');
  Map<String, String> result = {};

  for (String part in parts) {
    List<String> keyValue = part.split(
        ':'); // Split each part into key and value based on the ':' delimiter
    if (keyValue.length == 2) {
      String key = keyValue[0].trim(); // Trim to remove extra spaces
      String value = keyValue[1].trim(); // Trim to remove extra spaces
      result[key] = value;
    }
  }

  return result;
}

List<String> splitString(String input) {
  input = removeSpacesAfterPeriod(input);
  return input.split('.');
}

String removeSpacesAfterPeriod(String input) {
  return input.replaceAll(RegExp(r'\.\s+'), '.');
}
