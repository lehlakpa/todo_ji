// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_ji/models/task_models.dart';

class TaskProviders extends ChangeNotifier {
  List<TaskModels> searchedTasks = [];
  List<TaskModels> allTasks = [
    TaskModels(
      id: 1,
      title: 'Get the work done',
      description: 'This is the description of the task',
      isdone: false,
    ),
    TaskModels(
      id: 2,
      title: 'Get well soon',
      description: 'Thisljasnflnaeirljlnn nn',
      isdone: false,
    ),
    TaskModels(
      id: 3,
      title: 'Get well soon',
      description: 'Thisljasnflnaeirljlnn nn',
      isdone: false,
    ),
    TaskModels(
      id: 4,
      title: 'Morning Exercise',
      description: '30 minutes of cardio and stretching.',
      isdone: true,
    ),
    TaskModels(
      id: 5,
      title: 'Water the Plants',
      description: 'Check the soil moisture for the ferns.',
      isdone: true,
    ),
    TaskModels(
      id: 6,
      title: 'Read 10 Pages',
      description: 'Continue reading the current biography book.',
      isdone: true,
    ),
    TaskModels(
      id: 7,
      title: 'Get well soon',
      description: 'Thisljasnflnaeirljlnn nn',
      isdone: true,
    ),
  ];

  List<TaskModels> get doneTask {
    return allTasks.where((t) => t.isdone).toList();
  }

  Future<void> addTask({
    required int id,
    required String title,
    required String? description,
    required bool isdone,
  }) async {
    final newTask = TaskModels(
      id: id,
      title: title,
      description: description ?? "",
      isdone: isdone,
    );

    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(newTask.id.toString())
          .set(newTask.toJson());

      allTasks.add(newTask);
      notifyListeners();

      print("Task saved successfully!");
    } catch (e) {
      print("Firebase error: $e");
    }
  }

  void deleteTask(int id) {
    allTasks.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void deleteall() {
    allTasks.removeWhere((t) => t.isdone);
    notifyListeners();
  }

  void updateTask({
    required int id,
    required String title,
    required String description,
    required bool isdone,
  }) {
    final index = allTasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      allTasks[index] = TaskModels(
        id: id,
        title: title,
        description: description,
        isdone: isdone,
      );
    }
  }

  void updateWork(int id, bool value) {
    final task = allTasks.firstWhere((task) => task.id == id);
    task.isdone = value;
    notifyListeners();
  }

  void toggleDone(int id, bool value) {
    final index = allTasks.indexWhere((tasks) => tasks.id == id);
    final task = allTasks[index];
    task.isdone = value;
    notifyListeners();
  }

  void searchTask({required String searchText}) {
    if (searchText.isEmpty) {
      searchedTasks.clear();
      notifyListeners();
      return;
    }

    searchedTasks = allTasks
        .where((t) => t.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    notifyListeners();
  }
  // void searchTask({required String searchText}) {
  //   if (searchText.isEmpty) {
  //     searchTask.clear();
  //     notifyListeners();
  //     return;
  //   }
  //   searchTask = allTasks
  //       .where((t) => t.title.toLowerCase().contains(searchText.toLowerCase()))
  //       .toList();

  //   notifyListeners();
  // }

  // void updateWork(int id, bool value) {
  //   final index = allTasks.indexWhere((task) => task.id == id);

  //   if (index != -1) {
  //     allTasks[index].isdone = value;
  //     notifyListeners();
  //   }
  // }
}
