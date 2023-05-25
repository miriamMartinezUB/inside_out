import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';

class AuthService {
  final FirebaseService firebaseService;
  final LocaleStorageService storageService;

  AuthService({required this.firebaseService, required this.storageService});

  late final auth.FirebaseAuth _firebaseAuth;

  Future<void> init() async {
    _firebaseAuth = firebaseService.firebaseAuth;
  }

  Stream<bool> get isAuthenticated$ =>
      _firebaseAuth.idTokenChanges().asBroadcastStream().map((auth.User? user) => user != null);

  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  User? get user => User.fromAuthUser(_firebaseAuth.currentUser);

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser?.delete();
  }

  Future<void> recoverPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return User.fromAuthUser(userCredential.user!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String repeatedPassword,
    String? name,
  }) async {
    if (password != repeatedPassword) {
      throw Exception(AuthError.passwordNotEquals);
    }
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return User.fromAuthUser(_firebaseAuth.currentUser!, name: name);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  AuthError _determineError(auth.FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'user-disabled':
        return AuthError.userDisabled;
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'wrong-password':
        return AuthError.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return AuthError.emailAlreadyInUse;
      case 'invalid-credential':
        return AuthError.invalidCredential;
      case 'operation-not-allowed':
        return AuthError.operationNotAllowed;
      case 'weak-password':
        return AuthError.weakPassword;
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return AuthError.emptyFields;
    }
  }
}

enum AuthError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  passwordNotEquals,
  emailAlreadyInUse,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  emptyFields,
}
