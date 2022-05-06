import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  String name;
  String birthday;
  String img_url;

  UserScreen({required this.name,required this.birthday, required this.img_url});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {


  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Screen"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Container(
          width:width * 0.7,
          height: height * 0.4,
          decoration: BoxDecoration(
            color: Colors.orangeAccent.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              SizedBox(height: height *0.03,),
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(widget.img_url),
                radius: width * 0.15,
              ),
              SizedBox(height: height *0.02,),
              Text(widget.name.toUpperCase(),style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.04
              ),),
              SizedBox(height: height *0.01,),
              Text(widget.birthday,
                style: TextStyle(
                    color: Colors.black,
                   // fontWeight: FontWeight.bold,
                    fontSize: height * 0.034
                ),),
            ],
          ),
        ),
      ),

    );
  }
}
