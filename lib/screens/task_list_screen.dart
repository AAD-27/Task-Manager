import 'dart:async';
import 'package:flutter/material.dart';
import '../services/back4app_service.dart';
import '../widgets/task_card.dart';
import '../models/task.dart';
import 'login_screen.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshTasks() {
    setState(() {
      _tasksFuture = Back4AppService.getTasks();
    });
  }

  void _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await Back4AppService.logout();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4F46E5), Color(0xFF7C3AED), Color(0xFFEC4899)],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: FutureBuilder<List<Task>>(
          future: _tasksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text('Loading tasks...', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red.shade600),
                    const SizedBox(height: 12),
                    Text('Error loading tasks', style: TextStyle(color: Colors.red.shade600, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: _refreshTasks, style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent), child: const Text('Retry')),
                  ]),
                ),
              );
            }

            final tasks = snapshot.data ?? [];
            final completedCount = tasks.where((t) => t.isCompleted).length;
            final progressPercent = tasks.isEmpty ? 0.0 : completedCount / tasks.length;

            return SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, kToolbarHeight + 24, 20, 40),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 30, offset: const Offset(0, 12))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)]),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.task_alt, color: Colors.white),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Task Manager', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87)),
                                    Text('${tasks.length} tasks', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                                  ],
                                ),
                                const Spacer(),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TaskFormScreen()));
                                    if (result == true && mounted) {
                                      _refreshTasks();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: const [
                                              Icon(Icons.check_circle, color: Colors.white, size: 20),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Text('Task created successfully', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: const Color(0xFF10B981),
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.only(top: 80, left: 16, right: 16),
                                          duration: const Duration(seconds: 2),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          elevation: 6,
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.add, color: Colors.white),
                                  label: const Text('New Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4F46E5),
                                    elevation: 2,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Progress card with better contrast
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)]),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Your Progress', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                                          const SizedBox(height: 8),
                                          Text('$completedCount of ${tasks.length}', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                                        ),
                                        child: Text('${(progressPercent * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: LinearProgressIndicator(
                                      value: progressPercent,
                                      minHeight: 10,
                                      backgroundColor: Colors.white.withOpacity(0.2),
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Tasks title with proper contrast
                            Text('Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey.shade900)),
                            const SizedBox(height: 14),

                            // Tasks grid/wrap
                            if (tasks.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.inbox, size: 64, color: Colors.grey.shade300),
                                      const SizedBox(height: 16),
                                      Text('No tasks yet', style: TextStyle(color: Colors.grey.shade600, fontSize: 16, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 16),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TaskFormScreen()));
                                          if (result == true && mounted) {
                                            _refreshTasks();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: const [
                                                    Icon(Icons.check_circle, color: Colors.white, size: 20),
                                                    SizedBox(width: 12),
                                                    Expanded(
                                                      child: Text('Task created successfully', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                                                    ),
                                                  ],
                                                ),
                                                backgroundColor: const Color(0xFF10B981),
                                                behavior: SnackBarBehavior.floating,
                                                margin: const EdgeInsets.only(top: 80, left: 16, right: 16),
                                                duration: const Duration(seconds: 2),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                elevation: 6,
                                              ),
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.add),
                                        label: const Text('Create Your First Task', style: TextStyle(fontWeight: FontWeight.w600)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF4F46E5),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 12),
                                child: Center(
                                  child: Wrap(
                                    spacing: 16,
                                    runSpacing: 16,
                                    alignment: WrapAlignment.center,
                                    children: tasks
                                        .map((t) => ConstrainedBox(
                                              constraints: const BoxConstraints(minWidth: 260, maxWidth: 400),
                                              child: TaskCard(
                                                task: t,
                                                onEdit: () async {
                                                  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => TaskFormScreen(task: t)));
                                                  _refreshTasks();
                                                },
                                                onDelete: () async {
                                                  if (t.id != null) await Back4AppService.deleteTask(t.id!);
                                                  _refreshTasks();
                                                },
                                                onToggle: () async {
                                                  if (t.id != null) await Back4AppService.updateTask(t.id!, t.title, t.description, !t.isCompleted);
                                                  _refreshTasks();
                                                },
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TaskFormScreen()));
          if (result == true && mounted) {
            _refreshTasks();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text('Task created successfully', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.only(top: 80, left: 16, right: 16),
                duration: const Duration(seconds: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 6,
              ),
            );
          }
        },
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 4,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }
}
