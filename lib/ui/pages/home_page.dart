import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage(): super();

  @override
  build(BuildContext context) {
    return Scaffold(
      body: body(context,null,null),
    );
  }

  body(context,height,width) => Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Hi ${FirebaseHelper.currentUser.displayName ?? ''},\n'
                'Welcome to this App',
            style: Theme.of(context).textTheme.headline4.copyWith(
              fontFamily: 'Nunito',
            ),
          ),
        )
      ],
    ),
  );

}