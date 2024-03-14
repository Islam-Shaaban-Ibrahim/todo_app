import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';

class FireBaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection("tasks").withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(task),
        );
  }

  static Future<void> addTaskToFireStore(Task task) async {
    final collectionRef = getTasksCollection();
    final docs = collectionRef.doc();
    task.id = docs.id;
    return docs.set(task);
  }

  static Future<void> deleteTaskFromFireBase(Task task) {
    final collRef = getTasksCollection();
    return collRef.doc(task.id).delete();
  }
}
