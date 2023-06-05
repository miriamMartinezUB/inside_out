import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:inside_out/domain/user_emotion.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/remote_storage_interface.dart';

class UserEmotionStorage extends RemoteStorageInterface<UserEmotion> {
  UserEmotionStorage({
    required FirebaseService firebaseService,
    required LocaleStorageService localeStorageService,
  }) : super(
          firebaseService: firebaseService,
          localeStorageService: localeStorageService,
          collection: 'emotion',
        );

  @override
  Future<void> add(UserEmotion t) async {
    try {
      bool notExist = (await all).where((element) => element.id == t.id).toList().isEmpty;
      if (notExist) {
        await collectionRef.doc(t.id).set(t.toJson());
        log('UserEmotion added');
      } else {
        log('UserEmotion already added for user ${t.userId}');
      }
    } catch (e) {
      log('UserEmotion fail when try to add');
      log(e.toString());
    }
  }

  Future<void> put(UserEmotion t) async {
    try {
      UserEmotion? userEmotion = (await all).firstWhereOrNull((element) => element.emotion == t.emotion);

      if (userEmotion == null) {
        await add(t);
      } else {
        List bodySensations = userEmotion.bodySensations;
        bodySensations.addAll(t.bodySensations);
        List behaviours = userEmotion.behaviours;
        behaviours.addAll(t.behaviours);
        UserEmotion newUserEmotion = t.copyWith(
          id: userEmotion.id,
          bodySensations: bodySensations.toSet().toList(),
          behaviours: behaviours.toSet().toList(),
        );
        await update(newUserEmotion);
      }
    } catch (e) {
      log('UserEmotion fail when try to add');
      log(e.toString());
    }
  }

  @override
  Future<List<UserEmotion>> get all async {
    final snapshot = await collectionRef.snapshots().first;
    final List<QueryDocumentSnapshot> docs = snapshot.docs.where((element) => element['userId'] == userId).toList();
    List<UserEmotion> userEmotions = [];
    for (final QueryDocumentSnapshot doc in docs) {
      userEmotions.add(UserEmotion.fromDoc(doc));
    }
    return userEmotions;
  }

  @override
  Stream<List<UserEmotion>> get all$ => collectionRef.snapshots().distinct().map(
        (event) {
          List<UserEmotion> userEmotions = [];
          final List<QueryDocumentSnapshot> docs = event.docs.where((element) => element['userId'] == userId).toList();
          for (final QueryDocumentSnapshot doc in docs) {
            userEmotions.add(UserEmotion.fromDoc(doc));
          }
          return userEmotions;
        },
      );

  @override
  Future<UserEmotion> get(String id) async {
    final DocumentSnapshot snapshot = await collectionRef.doc(id).get();
    return UserEmotion.fromDoc(snapshot);
  }

  Future<UserEmotion?> getByEmotion(String emotion) async {
    final snapshot = await collectionRef.snapshots().first;
    final DocumentSnapshot? userEmotionDoc =
        snapshot.docs.firstWhereOrNull((element) => element['userId'] == userId && element['emotion'] == emotion);
    return userEmotionDoc == null ? null : UserEmotion.fromDoc(userEmotionDoc);
  }

  @override
  Future<void> remove(UserEmotion t) async {
    await collectionRef.doc(t.id).delete();
  }

  @override
  Future<void> update(UserEmotion t) async {
    DocumentReference doc = collectionRef.doc(t.id);
    try {
      await doc.update(t.toJson());
      log('UserEmotion updated');
    } catch (e) {
      log('UserEmotion fail when try to update');
      log(e.toString());
    }
  }
}
