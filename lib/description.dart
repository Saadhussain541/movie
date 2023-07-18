import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/myApiService.dart';

class description extends StatefulWidget {

  int mid;
  description({required this.mid});


  @override
  State<description> createState() => _descriptionState(id: mid);
}

class _descriptionState extends State<description> {

  int id;
  _descriptionState({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
            future: MySaadService.desc(id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData) {

                Map map = json.decode(snapshot.data);
                print('${map["tvShow"]["name"]}');

                return Container(
                  child: Column(
                    children: <Widget>[
                      Text('${map["tvShow"]["name"]}'),
                      Text('${map["tvShow"]["description"]}')
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return Icon(Icons.error);
              }

              if (ConnectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return Container();
            }));
  }
}
