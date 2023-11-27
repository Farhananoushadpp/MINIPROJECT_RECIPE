// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Recipe App',
//       home: RecipeScreen(),
//     );
//   }
// }

// class RecipeScreen extends StatelessWidget {
//   final CollectionReference recipes =
//       FirebaseFirestore.instance.collection('recipe');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recipe App'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: recipes.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data() as Map<String, dynamic>;

//               return ListTile(
//                 title: Text(data['name']),
//                 subtitle: Text(data['description']),
//               );
//             }).toList(),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _addRecipe();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> _addRecipe() {
//     // Example of adding a new recipe to Firebase
//     return recipes.add({
//       'name': 'New Recipe',
//       'description': 'This is a new recipe.',
//     });
//   }
// }
