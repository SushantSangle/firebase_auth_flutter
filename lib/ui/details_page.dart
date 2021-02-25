import 'package:firebase_auth_flutter/common_components/text_field_box.dart';
import 'package:firebase_auth_flutter/util/loading_notifier.dart';
import 'package:firebase_auth_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
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
      this.setState(() {
        name.text = data['displayName'];
        company.text = data['company'];
        email.text = data['email'];
        phone.text = data['phone'];
        address.text = data['address'];
      });
    }catch(e){

    }
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
              ],
            ),
          ),
        ),
      ),
    ],
  );
}