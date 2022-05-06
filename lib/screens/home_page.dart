import 'dart:convert';

import 'package:exercise_1/models/posts_model.dart';
import 'package:exercise_1/screens/userScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Because we are returning a list so create a list of postModel which will store
  // the future data from the api
  List<Posts> postList = [];

  List month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // We used list because we are getting an array of models
  // from our api
  Future<List<Posts>> getPostApi() async {
    final response = await http.get(Uri.parse(
        'https://breakingbadapi.com/api/characters?limit=10&offset=0'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Posts posts =
            Posts(name: i['name'], birthday: i['birthday'], img: i['img']);
        postList.add(posts);
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Exercise 1 - API'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, AsyncSnapshot<List<Posts>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text(
                          "Loading...",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> UserScreen(
                                name:snapshot.data![index].name.toString() ,
                                img_url: snapshot.data![index].img.toString(),
                                birthday:snapshot.data![index].birthday.toString() !=
                                    "Unknown"
                                    ? (snapshot.data![index].birthday
                                    .toString()
                                    .split('-')[1] +
                                    " " +
                                    month[int.parse(snapshot
                                        .data![index].birthday
                                        .toString()
                                        .split('-')[0]) -
                                        1] +
                                    " " +
                                    snapshot.data![index].birthday
                                        .toString()
                                        .split('-')[2])
                                    : "Unknown",
                              )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: EdgeInsets.all(10),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data![index].img.toString()),
                                ),
                                title:
                                    Text(snapshot.data![index].name.toString()),
                                subtitle: Text(
                                    snapshot.data![index].birthday.toString() !=
                                            "Unknown"
                                        ? (snapshot.data![index].birthday
                                                .toString()
                                                .split('-')[1] +
                                            " " +
                                            month[int.parse(snapshot
                                                    .data![index].birthday
                                                    .toString()
                                                    .split('-')[0]) -
                                                1] +
                                            " " +
                                            snapshot.data![index].birthday
                                                .toString()
                                                .split('-')[2])
                                        : "Unknown"),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
