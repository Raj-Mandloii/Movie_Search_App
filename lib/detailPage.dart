import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class Details extends StatefulWidget {
  Details({this.img,this.title,this.id});
  final img;
  final title;
  final id;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var data;
  getRating() async {
    final response = await http.get(Uri. parse('https://imdb-api.com/en/API/Ratings/k_7sog2v89/'+widget.id));
    if(response.statusCode==200){
      setState(() {
        data = json.decode(response.body);
      });



    }
    else{
      print(response.statusCode.toString());
    }
  }
  @override
  void initState() {
    getRating();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
        margin: EdgeInsets.only(right: 5),
        width: double.infinity,
        height: Get.height * .7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(widget.img),fit: BoxFit.cover),
      ),),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    data!=null?'IMDB Rating ${data['imDb']}':'',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),


          ],
      ),
    );
  }
}
