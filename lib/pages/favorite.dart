import 'package:avinash_patel/finallist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class favorite extends StatefulWidget {
  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  int num = finallist.name.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorite"),
      ),
      body: num <= 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'There is no Favorite Pepple.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: num,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.network(
                            finallist.name[index][0]['avatar'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.fill,
                          )),
                      title: Text(finallist.name[index][0]['first_name']),
                      subtitle: Text(finallist.name[index][0]['email']),
                      trailing: InkWell(
                          onTap: () {
                            for (int i = 0; i < finallist.name.length; i++) {
                              if (finallist.name[i][0]['id'] ==
                                  finallist.name[index][0]['id']) {
                                finallist.name.removeAt(i);
                              }
                            }
                            num = finallist.name.length;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.blue,
                          )),
                    ),
                  )),
    );
  }
}
