import 'package:firebase_auth/firebase_auth.dart';

String getCurrentUID() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final String uid = user!.uid;
  return uid;
}
