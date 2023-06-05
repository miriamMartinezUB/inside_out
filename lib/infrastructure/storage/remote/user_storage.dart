import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/remote_storage_interface.dart';
import 'package:inside_out/resources/storage_keys.dart';

class UserStorage extends RemoteStorageInterface<User> {
  UserStorage({
    required FirebaseService firebaseService,
    required LocaleStorageService localeStorageService,
  }) : super(
          firebaseService: firebaseService,
          localeStorageService: localeStorageService,
          collection: 'user',
        );

  @override
  Future<void> add(User t) async {
    try {
      bool notExist = (await all).where((element) => element.id == t.id).toList().isEmpty;
      if (notExist) {
        await collectionRef.doc(t.id).set(t.toJson());
        log('User added');
      } else {
        log('User already added');
      }
    } catch (e) {
      log('User fail when try to add');
      log(e.toString());
    }
  }

  @override
  Future<List<User>> get all async {
    final snapshot = await collectionRef.snapshots().first;
    final List<QueryDocumentSnapshot> docs = snapshot.docs.where((element) => element['id'] == userId).toList();
    List<User> users = [];
    for (final QueryDocumentSnapshot doc in docs) {
      users.add(User.fromDoc(doc));
    }
    return users;
  }

  @override
  Stream<List<User>> get all$ => collectionRef.snapshots().distinct().map(
        (event) {
          List<User> users = [];
          final List<QueryDocumentSnapshot> docs = event.docs.where((element) => element['id'] == userId).toList();
          for (final QueryDocumentSnapshot doc in docs) {
            users.add(User.fromDoc(doc));
          }
          return users;
        },
      );

  @override
  Future<User> get(String id) async {
    final DocumentSnapshot snapshot = await collectionRef.doc(id).get();
    return User.fromDoc(snapshot);
  }

  @override
  Future<void> remove(User t) async {
    await collectionRef.doc(t.id).delete();
  }

  @override
  Future<void> update(User t) async {
    DocumentReference doc = collectionRef.doc(t.id);
    localeStorageService.saveString(StorageKeys.keyUser, jsonEncode(t.toJson()));
    try {
      await doc.update(t.toJson());
      log('User updated');
    } catch (e) {
      log('User fail when try to update');
      log(e.toString());
    }
  }
}
