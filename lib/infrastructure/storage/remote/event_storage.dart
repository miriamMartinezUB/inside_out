import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/remote_storage_interface.dart';

class EventsStorage extends RemoteStorageInterface<Event> {
  EventsStorage({
    required FirebaseService firebaseService,
    required LocaleStorageService localeStorageService,
  }) : super(
          firebaseService: firebaseService,
          localeStorageService: localeStorageService,
          collection: 'events',
        );

  @override
  Future<void> add(Event t) async {
    try {
      bool notExist = (await all).where((element) => element.id == t.id).toList().isEmpty;
      if (notExist) {
        await collectionRef.doc(t.id).set(t.toJson());
        log('Event added');
      } else {
        log('Event already added for user ${t.userId}');
      }
    } catch (e) {
      log('Event fail when try to add');
      log(e.toString());
    }
  }

  @override
  Future<List<Event>> get all async {
    final snapshot = await collectionRef.snapshots().first;
    final List<QueryDocumentSnapshot> docs = snapshot.docs.where((element) => element['userId'] == userId).toList();
    List<Event> events = [];
    for (final QueryDocumentSnapshot doc in docs) {
      events.add(Event.fromDoc(doc));
    }
    return events;
  }

  @override
  Stream<List<Event>> get all$ => collectionRef.snapshots().distinct().map(
        (event) {
          List<Event> events = [];
          final List<QueryDocumentSnapshot> docs = event.docs.where((element) => element['userId'] == userId).toList();
          for (final QueryDocumentSnapshot doc in docs) {
            events.add(Event.fromDoc(doc));
          }
          return events;
        },
      );

  @override
  Future<Event> get(String id) async {
    final DocumentSnapshot snapshot = await collectionRef.doc(id).get();
    return Event.fromDoc(snapshot);
  }

  @override
  Future<void> remove(Event t) async {
    await collectionRef.doc(t.id).delete();
  }

  @override
  Future<void> update(Event t) async {
    DocumentReference doc = collectionRef.doc(t.id);
    try {
      await doc.update(t.toJson());
      log('Event updated');
    } catch (e) {
      log('Event fail when try to update');
      log(e.toString());
    }
  }
}
