import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inside_out/infrastructure/firebase/firebase_options.dart';

class FirebaseService {
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _fireStore;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firebaseAuth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
  }

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseFirestore get fireStore => _fireStore;
}
