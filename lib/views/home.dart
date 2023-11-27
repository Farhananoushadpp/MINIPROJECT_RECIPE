import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/views/recipe_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel>? recipes = [];
  String? ingredients;
  // ignore: unused_field
  bool _loading = false;
  String query = "";
  TextEditingController textEditingController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff213A50), Color(0xff071930)],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft)),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: !kIsWeb
                        ? Platform.isIOS
                            ? 60
                            : 30
                        : 30,
                    horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Row(
                      mainAxisAlignment: kIsWeb
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Recipe",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          "App",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontFamily: 'Overpass'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "What will you cook today?",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Overpass'),
                    ),
                    const Text(
                      "Just Enter Ingredients you have and we will show the best recipe for you",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'OverpassRegular'),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Overpass'),
                            decoration: InputDecoration(
                              hintText: "Enter Ingredients",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: 'Overpass'),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            onTap: fetchRecipes,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffA2834D),
                                        Color(0xffBC9A5F)
                                      ],
                                      begin: FractionalOffset.topRight,
                                      end: FractionalOffset.bottomLeft)),
                              padding: const EdgeInsets.all(8),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.search,
                                      size: 18, color: Colors.white),
                                ],
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _loading ? _buildLoadingIndicator() : _buildRecipeList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  GridView _buildRecipeList() {
    return GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 30.0, maxCrossAxisExtent: 400.0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        children: List.generate(recipes?.length ?? 0, (index) {
          return GridTile(
              child: RecipeTile(
            title: recipes?[index].label ?? "",
            imgUrl: recipes?[index].image ?? "",
            desc: recipes?[index].source ?? "",
            url: recipes?[index].url ?? "",
            recipeModel: recipes?[index],
          ));
        }));
  }

  LoadingIndicator _buildLoadingIndicator() {
    return const LoadingIndicator(indicatorType: Indicator.ballPulse);
  }

  void fetchRecipes() async {
    if (recipes != null) {
      recipes!.clear();
    }

    String? searchQuery;
    setState(() {
      _loading = true;
    });
    if (textEditingController.text.isNotEmpty) {
      searchQuery = textEditingController.text;
    }
    await db.collection("recipe").get().then((event) {
      for (var doc in event.docs) {
        // print("${doc.id} => ${doc.data()}");

        RecipeModel recipeModel = RecipeModel();
        recipeModel = RecipeModel.fromJSON(doc.data());
        if (recipes != null) {
          if (searchQuery == null) {
            recipes!.add(recipeModel);
          } else {
            if (doc.id == searchQuery) {
              recipes!.add(recipeModel);
            }
          }
        }
      }
    });
    searchQuery = null;
    setState(() {
      _loading = false;
    });
  }

  // void _fetchRecipes() async {
  //   if (textEditingController.text.isNotEmpty) {
  //     setState(() {
  //       _loading = true;
  //     });
  //     String url =
  //         "https://api.edamam.com/search?q=${textEditingController.text}&app_id=0f21d949&app_key=8bcdd93683d1186ba0555cb95e64ab26";
  //     var response = await http.get(Uri.parse(url));
  //     // print(" $response this is response");
  //     Map<String, dynamic> jsonData = jsonDecode(response.body);
  //     // print("this is json Data $jsonData");
  //     jsonData["hits"].forEach((element) {
  //       // print(element.toString());
  //       RecipeModel recipeModel = RecipeModel();
  //       recipeModel = RecipeModel.fromMap(element['recipe']);
  //       if (recipes != null) {
  //         recipes!.add(recipeModel);
  //       }

  //       // print(recipeModel.url);
  //     });
  //     setState(() {
  //       _loading = false;
  //     });

  //     // print("doing it");
  //   } else {
  //     // print("not doing it");
  //   }
  // }
}

class RecipeTile extends StatefulWidget {
  final String? title, desc, imgUrl, url;
  final RecipeModel? recipeModel;

  const RecipeTile({super.key, this.title, this.desc, this.imgUrl, this.url, this.recipeModel});

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 20,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipePage(
                          recipe: widget.recipeModel,
                        )));
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl ?? "",
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title ?? "",
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc ?? "",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class GradientCard extends StatelessWidget {
//   final Color topColor;
//   final Color bottomColor;
//   final String topColorCode;
//   final String bottomColorCode;

//   const GradientCard(
//       {super.key,
//       required this.topColor,
//       required this.bottomColor,
//       required this.topColorCode,
//       required this.bottomColorCode});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Wrap(
//         children: <Widget>[
//           Stack(
//             children: <Widget>[
//               Container(
//                 height: 160,
//                 width: 180,
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [topColor, bottomColor],
//                         begin: FractionalOffset.topLeft,
//                         end: FractionalOffset.bottomRight)),
//               ),
//               Container(
//                 width: 180,
//                 alignment: Alignment.bottomLeft,
//                 decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [Colors.white30, Colors.white],
//                         begin: FractionalOffset.centerRight,
//                         end: FractionalOffset.centerLeft)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: <Widget>[
//                       Text(
//                         topColorCode,
//                         style: const TextStyle(
//                             fontSize: 16, color: Colors.black54),
//                       ),
//                       Text(
//                         bottomColorCode,
//                         style: TextStyle(fontSize: 16, color: bottomColor),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
