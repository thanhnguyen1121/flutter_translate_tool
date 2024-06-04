import 'dart:developer';

import 'package:demo_deep_link/models/user_collection_model.dart';
import 'package:demo_deep_link/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const tag = 'HomePage';

  void check() {
    // var userJson = {'age': 5, 'name': 'Roger', 'username': 'roger1337'};
    //
    // var userJsonList = {
    //   "userList": [
    //     {'age': 5, 'name': 'Roger 5', 'username': 'roger1337 5'},
    //     {'age': 6, 'name': 'Roger 6', 'username': 'roger1337 6'},
    //     {'age': 7, 'name': 'Roger 7', 'username': 'roger1337 7'},
    //   ]
    // };
    //
    // // Use the generated members:
    // var user = UserModel.fromJson(userJson);
    // log("message user: $user", name: "HomePage");
    // log("message user: ${user.toJson()}", name: "HomePage");
    //
    // var userCollection = UserCollectionModel.fromJson(userJsonList);
    // log("message userCollection: $userCollection",name: "HomePage");
    // for(var element in userCollection.userList){
    //   log("message userCollection: ${element.toJson()}",name: "HomePage");
    // }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          check();
        },
        child: const Text("HomePage")
      ),
      body: SafeArea(
        child: Container(
          child: const SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
