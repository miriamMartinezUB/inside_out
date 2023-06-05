import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/remote_storage_interface.dart';

class TemporaryActivitiesStorage extends RemoteStorageInterface<TemporaryActivity> {
  TemporaryActivitiesStorage({
    required FirebaseService firebaseService,
    required LocaleStorageService localeStorageService,
  }) : super(
          firebaseService: firebaseService,
          localeStorageService: localeStorageService,
          collection: 'temporaryActivities',
        );

  @override
  Future<void> add(TemporaryActivity t) async {
    try {
      bool notExist = (await all).where((element) => element.id == t.id).toList().isEmpty;
      if (notExist) {
        await collectionRef.doc(t.id).set(t.toJson());
        log('TemporaryActivity added');
      } else {
        log('TemporaryActivity already added for user ${t.userId}');
      }
    } catch (e) {
      log('TemporaryActivity fail when try to add');
      log(e.toString());
    }
  }

  @override
  Future<List<TemporaryActivity>> get all async {
    final snapshot = await collectionRef.snapshots().first;
    final List<QueryDocumentSnapshot> docs = snapshot.docs.where((element) => element['userId'] == userId).toList();
    List<TemporaryActivity> events = [];
    for (final QueryDocumentSnapshot doc in docs) {
      events.add(TemporaryActivity.fromDoc(doc));
    }
    return events;
  }

  @override
  Stream<List<TemporaryActivity>> get all$ => collectionRef.snapshots().distinct().map(
        (event) {
          List<TemporaryActivity> events = [];
          final List<QueryDocumentSnapshot> docs = event.docs.where((element) => element['userId'] == userId).toList();
          for (final QueryDocumentSnapshot doc in docs) {
            events.add(TemporaryActivity.fromDoc(doc));
          }
          return events;
        },
      );

  @override
  Future<TemporaryActivity> get(String id) async {
    final DocumentSnapshot snapshot = await collectionRef.doc(id).get();
    return TemporaryActivity.fromDoc(snapshot);
  }

  @override
  Future<void> remove(TemporaryActivity t) async {
    await collectionRef.doc(t.id).delete();
  }

  @override
  Future<void> update(TemporaryActivity t) async {
    DocumentReference doc = collectionRef.doc(t.id);
    try {
      await doc.update(t.toJson());
      log('TemporaryActivity updated');
    } catch (e) {
      log('TemporaryActivity fail when try to update');
      log(e.toString());
    }
  }
}
