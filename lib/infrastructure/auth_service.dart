import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/user_storage.dart';
import 'package:inside_out/resources/storage_keys.dart';

class AuthService {
  final FirebaseService firebaseService;
  final LocaleStorageService storageService;

  AuthService({
    required this.firebaseService,
    required this.storageService,
  });

  late final auth.FirebaseAuth _firebaseAuth;
  late final UserStorage _userStorage;
  late StreamController<bool> _userLoadController;
  late bool _userLoad;
  late User _user;

  Future<void> init() async {
    _firebaseAuth = firebaseService.firebaseAuth;
    _userStorage = UserStorage(firebaseService: firebaseService, localeStorageService: storageService);
    _userLoadController = StreamController<bool>.broadcast();
    _userLoad = isAuthenticated;
    _userLoadController.add(_userLoad);
    if (isAuthenticated) {
      _user = User.fromJson(jsonDecode(storageService.getString(StorageKeys.keyUser)));
    }
  }

  Stream<bool> get isAuthenticated$ =>
      _firebaseAuth.idTokenChanges().asBroadcastStream().map((auth.User? user) => user != null);

  Stream<bool> get userLoad$ => _userLoadController.stream.distinct();

  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  bool get userLoad => _userLoad;

  User? get user => _user;

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

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = await _userStorage.get(userCredential.user!.uid);
      await _saveAppUser(_user);
      _userLoad = true;
      _userLoadController.add(_userLoad);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String repeatedPassword,
    String? name,
    String? locale,
    String? themePreference,
  }) async {
    if (password != repeatedPassword) {
      throw AuthError.passwordNotEquals;
    }
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = User.fromAuthUser(
        _firebaseAuth.currentUser!,
        name: name,
        locale: locale,
        themePreference: themePreference,
      );
      await _userStorage.add(_user);
      await _saveAppUser(_user);
      _userLoad = true;
      _userLoadController.add(_userLoad);
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

  Future<void> _saveAppUser(User user) async {
    await storageService.saveString(
      StorageKeys.keyUser,
      jsonEncode(user.toJson()),
    );
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
