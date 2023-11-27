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

List<String> splitSearchQuery(String input) {
    List<String> result = input.split(RegExp(r'[,\s]+'));
  result.removeWhere((element) => element.isEmpty);

  return result;
}

String removeSpacesAfterPeriod(String input) {
  return input.replaceAll(RegExp(r'\.\s+'), '.');
}

dynamic toLowerCaseConverter(dynamic input) {
  if (input is List<String>) {
    // If input is a List<String>
    return input.map((item) => item.toLowerCase()).toList();
  } else if (input is String) {
    // If input is a String
    return input.toLowerCase();
  } else {
    throw ArgumentError("Invalid input type. Expected List<String> or String.");
  }
}
