import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/common_components/simple_dialogue_box.dart';
import 'package:firebase_auth_flutter/common_components/text_field_box.dart';
import 'package:firebase_auth_flutter/util/validator.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_flutter/util/loading_notifier.dart';

class SignupPage extends StatefulWidget {
  Function loginCallback;
  SignupPage.withCallBack(this.loginCallback);
  @override
  State<SignupPage> createState() => SignupPageState.withCallBack(loginCallback);

}

class SignupPageState extends State<SignupPage> {

  SignupPageState.withCallBack(this.loginCallback);
  Function loginCallback;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController company = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController passwordRecheck = new TextEditingController();
  TextEditingController phoneNo = new TextEditingController();
  final _mainFormKey = GlobalKey<FormState>();
  final _optFormKey = GlobalKey<FormState>();
  bool _uniqueEmail = true;
  int _currentStep = 0;
  String prevEmail = '';

  @override
  initState(){
    _currentStep = 0;
    super.initState();
  }


  String _validateEmail(String email){
    var str = Validator.email(email);
    if (str != null)
      return str;
    if( _uniqueEmail == false ){
      _uniqueEmail = true;
      return 'email already in use';
    }
    return null;
  }

  static looseFocus(context) =>
    FocusScope.of(context).hasPrimaryFocus ?
      null :
      FocusManager.instance.primaryFocus.unfocus();

  _stepTapped(step) {
    looseFocus(context);
    if(_currentStep == 1)
      this.setState(() => _currentStep = step) ;
  }

  _stepContinue([LoadingNotifier notifier]) async{
    print(this._currentStep);
    if(this._currentStep  < 1){
      if(_mainFormKey.currentState.validate())
        this.setState(() {
          this._currentStep+=1;
        });
      return;
    }
    if(notifier != null)
      return _signUp(notifier);
  }

  _stepCancel([LoadingNotifier notifier]) async{
    if(notifier != null)
      return _signUp(notifier,true);
  }

  _signUp(LoadingNotifier notifier,[skipped = false]) async{
    try {
      if (_optFormKey.currentState.validate()) {
        await notifier.setLoading(FirebaseHelper.signUp(
          displayName: !skipped ? username.text ?? '' : '',
          email: email.text,
          password: password.text,
          phoneNo: !skipped ? phoneNo.text ?? '' : '',
          company: !skipped ? company.text ?? '' : '',
          address: !skipped ? company.text ?? '' : '',
        ));
      }
    }catch(e){
      if(e.code.toString() == 'email-already-in-use'){
        _uniqueEmail = false;
        _mainFormKey.currentState.validate();
        this.setState(() => _currentStep = 0 );
      }
    }
    return;
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
      ),
      body: SingleChildScrollView(
        child: Stepper(
          onStepTapped: (step) => _stepTapped(step),
          onStepContinue: _stepContinue,
          onStepCancel: _stepCancel,
          physics: ScrollPhysics(),
          type: StepperType.vertical,
          currentStep: this._currentStep,
          controlsBuilder: _stepperControlBuilder,
          steps: [
            _necessaryDetails(context),
            _extraDetails(context),
          ],


        ),
      ),
    );
  }
  
  Widget _stepperControlBuilder(context,{onStepCancel,onStepContinue}) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoadingNotifier(),
      child: Consumer<LoadingNotifier>(
        builder: (context,notifier,child) => notifier.loadingState ? CircularProgressIndicator() : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  looseFocus(context);
                  _stepContinue(notifier);
                },
                child:Row(
                  children: [
                    Text( this._currentStep == 0 ? 'Next' : 'Sign up' ),
                    _currentStep == 0 ? Icon(Icons.arrow_forward) : Container(),
                  ],
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    )
                ),
              ),
            ),
            this._currentStep == 1 ? Container(
                padding: EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () {
                    looseFocus(context);
                    _stepCancel(notifier);
                  },
                  child: Text('Skip details'),
                )
            ) : Container(),
          ],
        ),
      ),
    );
  }

  _necessaryDetails(context) => Step(
    title: Text('Authentication'),
    content: Form(
      key: _mainFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFieldBox(
            labelText: 'Enter e-mail*',
            textValidator: _validateEmail,
            controller: email,
            prefixIcon: Icons.email,
          ),
          TextFieldBox(
            labelText: 'Enter password*',
            textValidator: Validator.password,
            controller: password,
            obscureText: true,
            prefixIcon: Icons.lock_outline,
          ),
          TextFieldBox(
            labelText: 'Re-enter password*',
            textValidator: (str) => str == password.text ? null : 'Passwords don\'t match',
            controller: passwordRecheck,
            obscureText: true,
            prefixIcon: Icons.lock_outline,
          ),
        ],
      ),
    ),
  );

  _extraDetails(context) => Step(
    title: Text(
      'Optional details',
    ),
    content: Form(
      key: _optFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFieldBox(
            labelText: 'Name',
            controller: username,
            keyboardType: TextInputType.name,
            prefixIcon: Icons.person,
          ),
          TextFieldBox(
            labelText: 'Phone number',
            controller: phoneNo,
            keyboardType: TextInputType.phone,
            textValidator:(str) => phoneNo.text == '' ? null : Validator.number(str) ,
            prefixIcon: Icons.phone,
          ),
          TextFieldBox(
            labelText: 'Residential address',
            controller: address,
            keyboardType: TextInputType.streetAddress,
            maxLines: 3,
            prefixIcon: Icons.home,
          ),
          TextFieldBox(
            labelText: 'Company',
            controller: company,
            keyboardType: TextInputType.name,
            prefixIcon: Icons.work,
          )
        ],
      )
    ),
  );
}