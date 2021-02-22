import 'package:firebase_auth_flutter/common_components/simple_dialogue_box.dart';
import 'package:firebase_auth_flutter/ui/home_page.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:firebase_auth_flutter/util/loading_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_flutter/common_components/text_field_box.dart';
import 'package:firebase_auth_flutter/ui/signup_page.dart';
import 'package:firebase_auth_flutter/util/validator.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage(bool connectionState,{Key key, this.title}) :
        this._connectionState = connectionState,
        super(key: key);
  final String title;
  final bool _connectionState;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          'Flutter Firebase Auth Demo',
                          style: Theme.of(context).textTheme.headline2.copyWith(fontFamily: 'Nunito'),
                        )
                      ),
                      TextFieldBox(
                        labelText: 'email',
                        controller: username,
                        keyboardType: TextInputType.emailAddress,
                        textValidator: (str) => Validator.email(str)
                      ),
                      TextFieldBox(
                        labelText: 'Password',
                        controller: password,
                        obscureText: true,
                        textValidator: (str) => Validator.password(str),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ChangeNotifierProvider(
                            create: (context) =>LoadingNotifier(),
                            child: Consumer<LoadingNotifier>(
                              builder: (context,notifier,child) => TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all<Color>(Colors.blue[600]),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                                onPressed: () => login(context,notifier),
                                child: Center(
                                  child: notifier.loadingState ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ): Text(
                                    'login',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.61,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: oAuthEnabled()..addAll([
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                           'Not signed up yet?'
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SignupPage();
                                        }
                                      )
                                  );
                                },
                                child: Text(
                                  'Sign up!'
                                )
                            ),
                          ]
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login(context,notifier) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if(_formKey.currentState.validate()) {
      try {
        await notifier.setLoading(FirebaseHelper.signIn(email: username.text,
            password: password.text));
        if(FirebaseHelper.currentUser != null){
          Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
            )
          );
          return;
        }
        username.text = '';
        password.text = '';
      }on FirebaseException catch(e){
        print(e.toString());
        print(e.code);
        switch(e.code){
          case 'unknown':
            SimpleDialogueBox(title: 'Connectivity issue',
                description: 'Please check your internet connection')
                .show(context);
            break;
          case 'user-not-found':
            SimpleDialogueBox(title: 'New user?',
                description: 'There is no user registered by this email address please click on signup to create a new account')
                .show(context);
            break;
          case 'wrong-password':
            SimpleDialogueBox(title: 'Invalid details',
                description: 'The details you have entered are incorrect')
                .show(context);
        }
      }
    }
  }

  List<Widget> oAuthEnabled({enabled = false}){

    return  enabled ? [
      Divider(
        thickness: 2,
      ),
      Text(
        "Or continue using,\n",
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headline6,
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {

                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Google",
                        textScaleFactor: 1.61,
                      ),
                    ]
                ),
              ),
            ),
            Expanded(
                child: TextButton(
                    onPressed: () {

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Facebook",
                          textScaleFactor: 1.61,
                        ),
                      ],
                    )
                )
            )
          ]
      )
    ] : [];
  }
}