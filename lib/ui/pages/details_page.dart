import 'package:firebase_auth_flutter/common_components/text_field_box.dart';
import 'package:firebase_auth_flutter/util/loading_notifier.dart';
import 'package:firebase_auth_flutter/util/models/user_model.dart';
import 'package:firebase_auth_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_flutter/common_components/application_drawer.dart';

import '../LoginPage.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailsPage> {
  Future infoFuture;
  TextEditingController email;
  TextEditingController phone;
  TextEditingController address;
  TextEditingController company;
  TextEditingController name;
  var editMode = false;

  @override
  void initState() {
    email = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
    company = TextEditingController();
    name = TextEditingController();
    name.text    = '';
    company.text = '';
    email.text   = '';
    phone.text   = '';
    address.text = '';
    editMode = false;
    super.initState();
    assignValues();
  }

  void assignValues() async{
    await UserModel.getCurrentUserDetails();
    this.setState(() {
      name.text = UserModel.displayName ?? '';
      company.text = UserModel.company ?? '';
      email.text = UserModel.email ?? '';
      phone.text = UserModel.phone ?? '';
      address.text = UserModel.address ?? '';
    });

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: body(context,height,width),
      floatingActionButton: ChangeNotifierProvider<LoadingNotifier>(
        create: (BuildContext context) => LoadingNotifier(),
        child: Consumer<LoadingNotifier>(
          builder: (context,loadingNotifier,child) {
            return FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () async{
                if(this.editMode){
                  await loadingNotifier.setLoading(FirebaseHelper.addUserDetails(
                      phone.text, address.text, company.text, name.text,
                      FirebaseHelper.currentUser));
                  assignValues();
                }
                this.setState(() {
                  this.editMode = !this.editMode;
                });
              },
              child: this.editMode ? loadingNotifier.loadingState ?
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ) :
                Icon(
                  Icons.save
                ) :
                Icon(
                  Icons.edit,
                ),
            );
          },
        ),
      ),
    );
  }

  body(context,height,width) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        constraints: BoxConstraints(
          minHeight: height / (1.61*1.61*1.61*1.61),
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
            ]
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldBox(
                  labelText: 'email',
                  controller: email,
                  disabled: true,
                  width: width - 20,
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFieldBox(
                  labelText: 'name',
                  controller: this.name,
                  disabled: !this.editMode,
                  width: width - 20,
                  prefixIcon: Icons.person,
                ),
                TextFieldBox(
                  labelText: 'phone number',
                  controller: this.phone,
                  disabled: !this.editMode,
                  textValidator: Validator.number,
                  width: width - 20,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                ),
                TextFieldBox(
                  labelText: 'Address',
                  controller: this.address,
                  disabled: !this.editMode,
                  maxLines: 3,
                  width: width - 20,
                  prefixIcon: Icons.home,
                ),
                TextFieldBox(
                  labelText: 'Company',
                  controller: this.company,
                  disabled: !this.editMode,
                  width: width - 20,
                  prefixIcon: Icons.work,
                ),
                Divider(thickness: 2),
                TextButton(
                  onPressed: logOutConfirm,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Logout',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
  logOutConfirm() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        scrollable: true,
        content: Text('Are you sure you want to log out ?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              )
          ),
          TextButton(
            onPressed: logOut,
            child: Text('Ok'),
          ),
        ],
      )
    );
  }
  logOut() async {

    await FirebaseHelper.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(true),
      ),
    );
  }
}