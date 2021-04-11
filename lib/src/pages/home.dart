import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_clone_practice/src/controller/profile_controller.dart';
import 'package:kakao_clone_practice/src/pages/profile.dart';

import 'login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        ProfileController.to.authStateChanges(snapshot.data);
        if (!snapshot.hasData) {
          return LoginWidget();
        } else {
          return Profile();
        }
      },
    );
  }
}
