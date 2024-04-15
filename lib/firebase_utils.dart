import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/task.dart';

class FireBaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection("tasks")
        .withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(task),
        );
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance.collection("users").withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (myUser, options) => myUser.toJson(myUser),
        );
  }

  static Future<void> addUserToFireStore(
    MyUser myUser,
  ) async {
    var current = FirebaseAuth.instance.currentUser;
    current?.updateDisplayName(myUser.name);
    final collectionRef = getUsersCollection();
    final docs = collectionRef.doc(myUser.id);

    return docs.set(myUser);
  }

  static Future<void> addTaskToFireStore(Task task, String uid) async {
    final collectionRef = getTasksCollection(uid);
    final docs = collectionRef.doc();
    task.id = docs.id;
    return docs.set(task);
  }

  static Future<List<Task>> getAllTasksFromFireBase(String uid) async {
    final tasksCollection = FireBaseUtils.getTasksCollection(uid);
    final querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deleteTaskFromFireBase(Task task, String uid) {
    final collRef = getTasksCollection(uid);
    return collRef.doc(task.id).delete();
  }

  static Future<MyUser?> readUserFromFireBase(String uid) async {
    DocumentSnapshot<MyUser> userCollection =
        await getUsersCollection().doc(uid).get();
    return userCollection.data();
  }

  static MyUser? getCurrentUser() {
    var current = FirebaseAuth.instance.currentUser;

    return MyUser(
        id: current!.uid,
        name: current.displayName ?? '',
        email: current.email ?? '');
  }
}
