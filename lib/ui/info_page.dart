import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth_flutter/common_components/info_field.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Future infoFuture;

  @override
  void initState() {
    super.initState();
    infoFuture = FirebaseHelper.getCurrentUserDetails();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('User Info'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseHelper.signOut();
            },
            child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Colors.blue[600]),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: infoFuture,
          builder:(context,snapshot) {
            if(snapshot.hasData){
              print(snapshot.data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: height / (1.61*1.61*1.61),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/user.png'),
                                radius: 50,
                              ),
                            ]
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              snapshot.data['displayName'],
                              style: Theme.of(context).textTheme.headline4.copyWith(
                                fontFamily: 'Nunito',
                                color: Colors.white,
                              ),
                              softWrap: true,
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top:Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InfoField(
                              fieldInfo: 'email',
                              fieldData: snapshot.data['email'],
                            ),
                            InfoField(
                              fieldInfo: 'Phone',
                              fieldData: snapshot.data['phone'],
                            ),
                            InfoField(
                              fieldInfo: 'Address',
                              fieldData: snapshot.data['address'],
                            ),
                            InfoField(
                              fieldInfo: 'Company',
                              fieldData: snapshot.data['company'],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {  },
        child: Icon(
          Icons.edit,
        ),
      ),
    );
  }
}