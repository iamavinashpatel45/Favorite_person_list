import 'package:avinash_patel/pages/favorite.dart';
import 'package:avinash_patel/pages/list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: app(),
    );
  }
}

class app extends StatefulWidget {
  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  List? data;
  int? page;
  int? perpageitem;

  //bool image = false;

  jasondata(String p) async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=' + p));
    setState(() {
      var map = json.decode(response.body);
      data = data! + map['data'];
    });
  }

  jasonpage() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    setState(() {
      var map = json.decode(response.body);
      page = map['total_pages'];
      perpageitem = map['per_page'];
      data = map['data'];
    });
  }

  call() async {
    await jasonpage();
    for (int i = 2; i <= page!; i++) {
      await jasondata(i.toString());
    }
  }


  @override
  void initState() {
    call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('List Of People'),
      ),
      bottomSheet: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => favorite()),
            )
            .then((value) => {setState(() {

        })}),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.favorite, size: 45, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          data?.length == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.blue,
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) => list(l: [data![index]]),
                  ),
                ),
          SizedBox(
            height: 65,
          ),
        ],
      ),
    );
  }
}
