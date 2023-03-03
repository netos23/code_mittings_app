import 'package:code_mittings_app/data/mapper/user_mapper.dart';
import 'package:code_mittings_app/domain/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';

class UserRepository {

  Future<User?> signInWithGitHub() async {
    try {
      final userCredential = await _signInWithGitHub();

      return mapUser(userCredential);
    }catch(e){

    }

    return null;
  }

  Future<UserCredential> _signInWithGitHub() async {
    // Create a new provider
    final githubProvider = GithubAuthProvider()..addScope("gist");

    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(githubProvider);
    }
    // todo: premit domain ios
    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }
}
