import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/common_components/simple_dialogue_box.dart';
import 'package:firebase_auth_flutter/common_components/text_field_box.dart';
import 'package:firebase_auth_flutter/util/validator.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_flutter/util/loading_notifier.dart';


class SignupPage extends StatelessWidget {

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController company = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController passwordRecheck = new TextEditingController();
  TextEditingController phoneNo = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _uniqueEmail = true;

  String _validateEmail(String email){
    var str = Validator.email(email);
    if (str != null)
      return str;
    if( _uniqueEmail == false){
      return 'email already in use';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
        ),
        actions: [
          ChangeNotifierProvider(
            create: (BuildContext context) => LoadingNotifier(),
            child: Consumer<LoadingNotifier>(
             builder: (context,notifier,child) {
               return TextButton(
                 style: ButtonStyle(
                   overlayColor: MaterialStateProperty.all<Color>(Colors.blue[600]),
                   shape: MaterialStateProperty.all<OutlinedBorder>(
                     RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                     ),
                   ),
                 ),
                 onPressed: () async {
                   if(_formKey.currentState.validate()) {
                     try{
                       await notifier.setLoading(FirebaseHelper.signUp(
                         displayName: username.text,
                         email: email.text,
                         password: password.text,
                         phoneNo: phoneNo.text,
                         address: address.text,
                         company: company.text,
                       ));
                       Navigator.pop(context);
                     }catch(e){
                       print(e);
                       print(e.code);
                       switch(e.code){
                         case 'email-already-in-use':
                           _uniqueEmail = false;
                           _formKey.currentState.validate();
                           _uniqueEmail = true;
                           break;
                         case 'unknown':
                           SimpleDialogueBox(title: 'Connectivity issue',
                               description: 'Please check your internet connection')
                               .show(context);
                           break;
                       }
                     }
                   }
                 },
                 child: Center(
                   child: notifier.loadingState ? CircularProgressIndicator(
                     backgroundColor: Colors.white,
                   ) : Text(
                     'signup',
                     style: TextStyle(
                       color: Colors.white,
                     ),
                     textAlign: TextAlign.center,
                   ),
                 ),
               );
             },
            )
          ),
        ],
      ),
      body: GestureDetector(
        onTap : () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldBox(
                    labelText: 'Enter display name',
                    textValidator: (str) => Validator.name(str) ,
                    controller: username,
                  ),
                  TextFieldBox(
                    labelText: 'Enter email address',
                    textValidator: (str) => _validateEmail(str) ,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFieldBox(
                    labelText: 'Enter password',
                    obscureText: true,
                    textValidator: (str) => Validator.password(str),
                    controller: password,
                  ),
                  TextFieldBox(
                    labelText: 'Re-enter password',
                    obscureText: true,
                    textValidator: (str) => str == password.text ? null: 'passwords don\'t match' ,
                    controller: passwordRecheck,
                  ),
                  TextFieldBox(
                    labelText: 'Enter phone number',
                    textValidator: (str) => Validator.number(str) ,
                    controller: phoneNo,
                    keyboardType: TextInputType.number,
                  ),
                  TextFieldBox(
                    labelText: 'Enter Address',
                    textValidator: (str) => str.length > 0 ? null : 'Address cannot be empty' ,
                    maxLines: 4,
                    controller: address,
                    keyboardType: TextInputType.multiline,
                  ),
                  TextFieldBox(
                    labelText: 'Enter Company name',
                    textValidator: (str) => str.length > 0 ? null : 'Company cannot be empty' ,
                    controller: company,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}