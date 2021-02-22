import 'package:firebase_auth_flutter/common_components/text_field_box.dart';
import 'package:firebase_auth_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth_flutter/common_components/info_field.dart';
import 'package:firebase_auth_flutter/ui/home_page.dart';
import 'package:firebase_auth_flutter/common_components/application_drawer.dart';

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
    infoFuture   = FirebaseHelper.getCurrentUserDetails();
    try{
      var data = await infoFuture;
      name.text = data['displayName'];
      company.text = data['company'];
      email.text = data['email'];
      phone.text = data['phone'];
      address.text = data['address'];
    }catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {


    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('User Info'),
        elevation: 0,
      ),
      body: GestureDetector(
        child:body(height,width),
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          this.setState(() {
            this.editMode = !this.editMode;
          });
        },
        child: this.editMode ? Icon(
          Icons.save
        ) :
        Icon(
          Icons.edit,
        ),
      ),
    );
  }

  body(height,width) => Column(
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
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    this.email.text,
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
            borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldBox(
                  labelText: 'name',
                  controller: this.name,
                  disabled: !this.editMode,
                  width: width,
                ),
                TextFieldBox(
                  labelText: 'phone number',
                  controller: this.phone,
                  disabled: !this.editMode,
                  textValidator: Validator.number,
                  width: width,
                ),
                TextFieldBox(
                  labelText: 'Address',
                  controller: this.address,
                  disabled: !this.editMode,
                  maxLines: 3,
                  width: width,
                ),
                TextFieldBox(
                  labelText: 'Company',
                  controller: this.company,
                  disabled: !this.editMode,
                  width: width,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}