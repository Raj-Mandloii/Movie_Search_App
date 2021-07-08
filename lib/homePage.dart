import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'detailPage.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Future getMovies(query) async {
    final response = await http.get(Uri. parse('https://imdb-api.com/en/API/Search/k_7sog2v89/'+query));
    if(response.statusCode==200){
      var data = json.decode(response.body);
      a= data['results']??[];


    }
    else{
      print(response.statusCode.toString());
    }

    return a;
  }


  var a = [];
  var loading = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'HOME',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 20.0),
              child: TextFormField(
                onChanged: (v) async {
                  a = await getMovies(v);
                  setState(() {
                    a;
                    if(v.length>0||a.length>0){
                      loading=true;
                    }
                    else{
                      loading=false;
                    }
                  });

                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search for a movie',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black, width: 2.0)),
                ),
              ),
            ),
            loading ?  Column(
              children: a
                  .map<Widget>(
                    (e) => Padding(
                  padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(Details(img: a[a.indexOf(e)]['image'],title: a[a.indexOf(e)]['title'],id:a[a.indexOf(e)]['id']));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      elevation: 1,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            width: Get.width * .4,
                            height: Get.height * .25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(a[a.indexOf(e)]['image']),fit: BoxFit.cover,)),
                            // 'https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_Ratio0.7273_AL_.jpg'))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width*.5,
                                child: Text(
                                  a[a.indexOf(e)]['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,

                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Action | Adventure | Science',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      'IMDB Rating 7.5',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ).toList(),
            )
                :Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*0.05,),
                Lottie.asset('assets/woman.json'),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
