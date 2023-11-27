import 'package:recipe_app/utils/string_functions.dart';

bool isMatchFound(List<String> searchParameters, String ingredients) {
  searchParameters = toLowerCaseConverter(searchParameters);
  ingredients = toLowerCaseConverter(ingredients);
  for (String parameter in searchParameters) {
    if (!ingredients.contains(parameter)) {
      return false;
    }
  }
  return true;
}
