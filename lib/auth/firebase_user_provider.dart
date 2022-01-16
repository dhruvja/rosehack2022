import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MitraFirebaseUser {
  MitraFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MitraFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MitraFirebaseUser> mitraFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MitraFirebaseUser>((user) => currentUser = MitraFirebaseUser(user));
