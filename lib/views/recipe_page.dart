import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/utils/string_functions.dart';
import 'package:recipe_app/views/recipe_web_view.dart';
import 'package:recipe_app/widgets/key_value_display.dart';
import 'package:recipe_app/widgets/preparation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipePage extends StatelessWidget {
  final RecipeModel? recipe;

  const RecipePage({Key? key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe?.label ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Recipe Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(recipe?.image ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Recipe Title
              Text(
                recipe?.label ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Recipe Description
              if (recipe?.source?.isNotEmpty ?? false)
                Column(
                  children: [
                    Text(
                      recipe?.source ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              // Calorie Details
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    "${recipe?.calories} Calories",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildIngredients(splitString(recipe?.ingredients ?? "")),
              _buildDetails("Dietary Preferences", recipe?.dietaryPrefs),
              _buildDetails(
                  "Nutritional Information", recipe?.nutritionalInformation),
              const Center(
                child: Text(
                  "Preparation",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              PreparationWidget(
                stepMap: parseLargeString(recipe?.recipeDetails ?? ""),
              ),
              // More Button
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    if (kIsWeb) {
                      _launchURL(recipe?.url ?? "");
                    } else {
                      // print("${widget.url} this is what we are going to see");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeView(
                                    postUrl: recipe?.url ?? "",
                                  )));
                    }
                  },
                  child: const Text("More"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildIngredients(List<String> stringList) {
    if (stringList.isEmpty) {
      return const Column();
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Ingredients",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        ...stringList.map((text) => Text(text)).toList(),
      ]);
    }
  }

  Widget _buildDetails(String title, String? body) {
    if (body == null || body.isEmpty) {
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          KeyValueDisplay(keyValueMap: parseLargeString(body)),
          const SizedBox(height: 16),
        ],
      );
    }
  }

  _launchURL(String url) async {
    // print(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
