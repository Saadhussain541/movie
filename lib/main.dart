import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/description.dart';
import 'package:project1/myApiService.dart';
void main()
{
  runApp(myApp());
}
class myApp extends StatefulWidget {
  const myApp({super.key});


  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myHome(),
    );
  }
}
class myHome extends StatefulWidget {
  const myHome({super.key});

  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myBody(),

    );
  }
}
class myBody extends StatefulWidget {
  const myBody({super.key});

  @override
  State<myBody> createState() => _myBodyState();
}

class _myBodyState extends State<myBody> {
  int page=1;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                page++;
                print(page);
              });
            },
            child: Icon(Icons.add),
          ),
          FutureBuilder(


              future: MySaadService.fetch(page),
              builder: (
                  BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.hasData) {
                  Map map=json.decode(snapshot.data);
                  List mydata=map["tv_shows"];

                  return Container(
                    child: ListView.builder(
                      itemCount: mydata.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var image1='${mydata[index]["image_thumbnail_path"]}';
                        var id = mydata[index]["id"];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => description(mid: id),));
                        },
                              child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 30,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    width: double.infinity,
                                    height: 90,

                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 30
                                    ),
                                    child: image1!=null?CircleAvatar(
                                      backgroundImage: NetworkImage(image1),
                                      radius: 80,
                                      backgroundColor: Colors.red,
                                    ):CircleAvatar(
                                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1594322436404-5a0526db4d13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1129&q=80'),
                                      radius: 80,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 205,top: 40),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${mydata[index]["name"]}",style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 20,

                                          ),
                                            overflow: TextOverflow.ellipsis,

                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text("${mydata[index]["start_date"]}",style: GoogleFonts.poppins(
                                              color: Colors.white
                                          ),),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text("${mydata[index]["network"]}",style: GoogleFonts.poppins(
                                              color: Colors.white
                                          ),),

                                        ],
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                      ),
                            ),

                          ],
                        );

                    },
                    )
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Icon(Icons.error_outline));
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}

