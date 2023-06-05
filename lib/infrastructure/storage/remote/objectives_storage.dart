import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:inside_out/domain/objectives.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/remote_storage_interface.dart';

class ObjectivesStorage extends RemoteStorageInterface<Objectives> {
  ObjectivesStorage({
    required FirebaseService firebaseService,
    required LocaleStorageService localeStorageService,
  }) : super(
          firebaseService: firebaseService,
          localeStorageService: localeStorageService,
          collection: 'objectives',
        );

  @override
  Future<void> add(Objectives t) async {
    try {
      bool notExist = (await all).where((element) => element.id == t.id).toList().isEmpty;
      if (notExist) {
        await collectionRef.doc(t.id).set(t.toJson());
        log('Objectives added');
      } else {
        log('Objectives already added for user ${t.userId}');
      }
    } catch (e) {
      log('Objectives fail when try to add');
      log(e.toString());
    }
  }

  Future<void> put(Objectives t) async {
    try {
      Objectives? objectives = (await all).firstOrNull;

      if (objectives == null) {
        await add(t);
      } else {
        List thingsToChange = objectives.thingsToChange ?? [];
        thingsToChange.addAll(t.thingsToChange ?? []);
        List thingsToKeep = objectives.thingsToKeep ?? [];
        thingsToKeep.addAll(t.thingsToKeep ?? []);
        List thingsToLearn = objectives.thingsToLearn ?? [];
        thingsToLearn.addAll(t.thingsToLearn ?? []);
        List thingsToPrevent = objectives.thingsToPrevent ?? [];
        thingsToPrevent.addAll(t.thingsToPrevent ?? []);
        Objectives newObjectives = t.copyWith(
          id: objectives.id,
          thingsToChange: thingsToChange.toSet().toList(),
          thingsToLearn: thingsToLearn.toSet().toList(),
          thingsToKeep: thingsToKeep.toSet().toList(),
          thingsToPrevent: thingsToPrevent.toSet().toList(),
        );
        await update(newObjectives);
      }
    } catch (e) {
      log('Objectives fail when try to add');
      log(e.toString());
    }
  }

  @override
  Future<List<Objectives>> get all async {
    final snapshot = await collectionRef.snapshots().first;
    final List<QueryDocumentSnapshot> docs = snapshot.docs.where((element) => element['userId'] == userId).toList();
    List<Objectives> objectives = [];
    for (final QueryDocumentSnapshot doc in docs) {
      objectives.add(Objectives.fromDoc(doc));
    }
    return objectives;
  }

  @override
  Stream<List<Objectives>> get all$ => collectionRef.snapshots().distinct().map(
        (event) {
          List<Objectives> objectives = [];
          final List<QueryDocumentSnapshot> docs = event.docs.where((element) => element['userId'] == userId).toList();
          for (final QueryDocumentSnapshot doc in docs) {
            objectives.add(Objectives.fromDoc(doc));
          }
          return objectives;
        },
      );

  @override
  Future<Objectives> get(String id) async {
    final DocumentSnapshot snapshot = await collectionRef.doc(id).get();
    return Objectives.fromDoc(snapshot);
  }

  @override
  Future<void> remove(Objectives t) async {
    await collectionRef.doc(t.id).delete();
  }

  @override
  Future<void> update(Objectives t) async {
    DocumentReference doc = collectionRef.doc(t.id);
    try {
      await doc.update(t.toJson());
      log('Objectives updated');
    } catch (e) {
      log('Objectives fail when try to update');
      log(e.toString());
    }
  }
}
