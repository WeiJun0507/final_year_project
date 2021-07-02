import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool isLoggedIn = false;
  String _username;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dbService = DatabaseService();

  Member _userReturnedFromFirebase({User user, String username}) {
    return user != null ? Member(username: user.displayName, email: user.email, userId: _auth.currentUser.uid, admin: false) : null;
  }

  //Change State
  //Using provider to set allow access the Member class for all the page.
  //This function return a Member type: instance of the Member object
  //can access Member field

  Stream<Member> get user {
    return _auth.authStateChanges().map((User user) =>
        _userReturnedFromFirebase(user: user, username: _username));
  }


  //register user using email and password + adding additional states to the firebase database
  Future registerUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user.updateDisplayName(username);
      User user = result.user;
      _username = username;
      if (user != null) {
        _dbService.createMember(email, username, user.uid);
      }

      return _userReturnedFromFirebase(user: user, username: username);
    } on FirebaseAuthException catch (e) {
      //Check the error code and modify it to find the correct code so that
      //can show the correct error;
      print(e.code);
      throw e;
    } catch (e) {
      return e.toString();
    }
  }

  //Login user using email and password
  Future signInUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  //updateUserInfo

  //verify currentPassword
  //if the user entered password allows the account to be reauthenticated with true
  // which means the user enter a correct password
  Future<bool> verifyCredentials(String password) async {
    User user = _auth.currentUser;

    //EmailAuthProvider
    final credential =
        EmailAuthProvider.credential(email: user.email, password: password);
    try {
      final result = await user.reauthenticateWithCredential(credential);
      return result.user != null;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //Change Password
  void changePassword(String password) {
    User user = _auth.currentUser;
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  //Change Username
  void changeUsername(String username) {
    User user = _auth.currentUser;
    user.updateDisplayName(username).then((_) {
      print("Successfully changed username");
    }).catchError((error) {
      print("Username can't be changed" + error.toString());
    });
  }

  //Change Email
  void changeEmail(String email) {
    User user = _auth.currentUser;
    user.updateEmail(email).then((_) {
      print("Successfully changed email");
    }).catchError((error) {
      print("Email can't be changed" + error.toString());
    });
  }

  //ResetPasswordUsingEmail
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Signing out
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
