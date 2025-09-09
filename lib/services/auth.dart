import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
   
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    final userCredential = await _firebaseauth.createUserWithEmailAndPassword(
      email: email,
      password: password,
  );
  return userCredential;
}
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
 Future<UserCredential> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseauth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }
}
