import 'package:avinash_patel/finallist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../finallist.dart';

class list extends StatefulWidget {
  final List l;

  const list({Key? key, required this.l}) : super(key: key);

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  bool tap = false;

  @override
  void initState() {
    getlist(widget.l);
    super.initState();
  }

  List? data;

  getlist(List l) {
    data = l;
  }

  bool? valid(int a) {
    int b = 0;
    for (int i = 0; i < finallist.name.length; i++) {
      if (finallist.name[i][0]['id'] == a) {
        print('true' + a.toString());
        b = 1;
        tap = true;
        return true;
      }
    }
    if (b == 0) {
      tap=false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.network(
                data![0]['avatar'],
                width: 60,
                height: 60,
                fit: BoxFit.fill,
              )),
          title: Text(data![0]['first_name']),
          subtitle: Text(data![0]['email']),
          trailing: InkWell(
              onTap: () {
                tap = !tap;
                setState(() {
                  if (tap == true) {
                    finallist.addname([data![0]]);
                  } else {
                    for (int i = 0; i < finallist.name.length; i++) {
                      if (finallist.name[i][0]['id'] == data![0]['id']) {
                        finallist.name.removeAt(i);
                      }
                    }
                  }
                  //print(finallist.name);
                });
              },
              child: tap == true && valid(data![0]['id']) == true
                  ? Icon(
                      Icons.favorite,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.favorite_outline_rounded,
                      color: Colors.blue,
                    ))),
    );
  }
}
