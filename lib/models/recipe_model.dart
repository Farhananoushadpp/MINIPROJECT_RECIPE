class RecipeModel {
  final String? image;
  final String? url;
  final String? source;
  final String? label;
  final int? calories;
  final String? nutritionalInformation;
  final String? dietaryPrefs;
  final String? ingredients;
  final String? recipeDetails;

  RecipeModel({
    this.image,
    this.url,
    this.label,
    this.source,
    this.calories,
    this.nutritionalInformation,
    this.dietaryPrefs,
    this.ingredients,
    this.recipeDetails,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> parsedJson) {
    return RecipeModel(
        image: parsedJson["image"],
        url: parsedJson["url"],
        source: parsedJson["source"],
        label: parsedJson["label"]);
  }

  factory RecipeModel.fromJSON(Map<String, dynamic> parsedJson) {
    return RecipeModel(
      image: parsedJson["image"],
      label: parsedJson["recipeName"],
      calories: parsedJson["calories"],
      url: parsedJson["url"],
      nutritionalInformation: parsedJson["nutritionalInformation"],
      dietaryPrefs: parsedJson["dietaryPrefs"],
      ingredients: parsedJson["ingredients"],
      recipeDetails: parsedJson["recipeDetails"],
    );
  }
}
