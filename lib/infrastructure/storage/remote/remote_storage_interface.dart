import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/resources/storage_keys.dart';

abstract class RemoteStorageInterface<T> {
  final FirebaseService firebaseService;
  final LocaleStorageService localeStorageService;
  final String collection;

  RemoteStorageInterface({
    required this.firebaseService,
    required this.localeStorageService,
    required this.collection,
  });

  @protected
  CollectionReference get collectionRef => firebaseService.fireStore.collection(collection);

  @protected
  String get userId => User.fromJson(
        jsonDecode(
          localeStorageService.getString(StorageKeys.keyUser),
        ),
      ).id;

  Future<void> add(T t);

  Future<void> update(T t);

  Future<T> get(String id);

  Future<List<T>> get all;

  Stream<List<T>> get all$;

  Future<void> remove(T t);
}
