import 'dart:async';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/task.dart';

class Back4AppService {
  static const String parseServerUrl = 'https://parseapi.back4app.com';
  static const String parseAppId = '5XBNYJE42GFkJGJRGN6pwwQrz9R9quFqziCNEX0N';
  static const String parseClientKey = 'imcEkChSjKhY2oKIMXlsVjRjojNI5xve0ZxdlPCN';
  // Simple polling-based stream for task updates. Use startPolling() to enable.
  static final StreamController<List<Task>> _taskStreamController = StreamController.broadcast();
  static Stream<List<Task>> get taskStream => _taskStreamController.stream;
  static Timer? _pollTimer;

  /// Start a polling loop that fetches tasks every [intervalSeconds] and
  /// emits them on [taskStream]. This is a lightweight fallback to LiveQuery.
  static void startPolling({int intervalSeconds = 5}) {
    stopPolling();
    _pollTimer = Timer.periodic(Duration(seconds: intervalSeconds), (t) async {
      final tasks = await getTasks();
      if (!_taskStreamController.isClosed) {
        _taskStreamController.add(tasks);
      }
    });
  }

  static void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  static Future<void> initialize() async {
    try {
      await Parse().initialize(
        parseAppId,
        parseServerUrl,
        clientKey: parseClientKey,
        autoSendSessionId: true,
        debug: false,
      );
      print('✅ Back4App initialized successfully');
    } catch (e) {
      print('❌ Failed to initialize Back4App: $e');
      rethrow;
    }
  }

  // Authentication Methods
  static Future<bool> register(String email, String password) async {
    try {
      final user = ParseUser(email, password, email);
      final response = await user.save();
      if (response.success) {
        print('✅ Registration successful for $email');
        return true;
      } else {
        print('❌ Registration failed: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('❌ Registration error: $e');
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try {
      final user = ParseUser(email, password, null);
      final response = await user.login();
      if (response.success) {
        print('✅ Login successful for $email');
        return true;
      } else {
        print('❌ Login failed: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('❌ Login error: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    try {
      final user = await ParseUser.currentUser();
      if (user != null) {
        await user.logout();
        print('✅ Logout successful');
      }
    } catch (e) {
      print('❌ Logout error: $e');
    }
  }

  static Future<ParseUser?> getCurrentUser() async {
    try {
      return await ParseUser.currentUser();
    } catch (e) {
      print('❌ Error getting current user: $e');
      return null;
    }
  }

  // Task CRUD Operations
  static Future<List<Task>> getTasks() async {
    try {
      final user = await ParseUser.currentUser();
      if (user == null) {
        print('⚠️ No user logged in');
        return [];
      }

      final query = QueryBuilder<ParseObject>(ParseObject('Task'))
        ..whereEqualTo('userId', user.objectId)
        ..orderByDescending('createdAt');

      final response = await query.query();
      if (response.success && response.results != null) {
        final tasks = (response.results as List)
            .map((e) => Task.fromJson((e as ParseObject).toJson()))
            .toList();
        // Emit current tasks to any listeners
        if (!_taskStreamController.isClosed) {
          _taskStreamController.add(tasks);
        }
        print('✅ Retrieved ${tasks.length} tasks');
        return tasks;
      } else {
        print('⚠️ No tasks found or query failed');
        return [];
      }
    } catch (e) {
      print('❌ Error fetching tasks: $e');
      return [];
    }
  }

  static Future<bool> createTask(String title, String description) async {
    try {
      final user = await ParseUser.currentUser();
      if (user == null) {
        print('❌ No user logged in');
        return false;
      }

      final task = ParseObject('Task')
        ..set('title', title)
        ..set('description', description)
        ..set('userId', user.objectId)
        ..set('isCompleted', false);

      final response = await task.save();
      if (response.success) {
        print('✅ Task created: $title');
        return true;
      } else {
        print('❌ Failed to create task: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('❌ Error creating task: $e');
      return false;
    }
  }

  static Future<bool> updateTask(String taskId, String title,
      String description, bool isCompleted) async {
    try {
      final task = ParseObject('Task')..objectId = taskId;
      task.set('title', title);
      task.set('description', description);
      task.set('isCompleted', isCompleted);

      final response = await task.save();
      if (response.success) {
        print('✅ Task updated: $title');
        return true;
      } else {
        print('❌ Failed to update task: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('❌ Error updating task: $e');
      return false;
    }
  }

  static Future<bool> deleteTask(String taskId) async {
    try {
      final task = ParseObject('Task')..objectId = taskId;
      final response = await task.delete();
      if (response.success) {
        print('✅ Task deleted successfully');
        // Refresh listeners
        final tasks = await getTasks();
        if (!_taskStreamController.isClosed) {
          _taskStreamController.add(tasks);
        }
        return true;
      } else {
        print('❌ Failed to delete task: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('❌ Error deleting task: $e');
      return false;
    }
  }
}
