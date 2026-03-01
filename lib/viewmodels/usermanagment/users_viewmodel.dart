import 'package:core_demo_slot5/data/interfaces/repositories/imanaged_user_repository.dart';
import 'package:core_demo_slot5/domain/entities/managed_user.dart';
import 'package:flutter/foundation.dart';

class UsersViewmodel extends ChangeNotifier {
  final IManagedUserRepository repo;
  UsersViewmodel({
    required this.repo,
  });

  bool loading = false;
  String? error;
  List<ManagedUser> users = [];

  ManagedUser? selected;

  Future<void> init() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await repo.seedDemoIfEmpty();
      users = await repo.getAll();
      if (users.isNotEmpty) selected ??= users.first;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void select(ManagedUser u) {
    selected = u;
    notifyListeners();
  }

  Future<void> refresh() async {
    try {
      users = await repo.getAll();
      if (users != null) {
        selected = users.firstWhere(
          (x) => x.id == selected?.id,
          orElse: () => users.isNotEmpty ? users.first : selected!,
        );
      }
      notifyListeners();
    } catch (_) {}
  }

  Future<void> add(String fullName, String dob, String address) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final created = await repo.create(fullName, dob, address);
      users = [created, ...users];
      selected = created;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> update(int id, String fullName, String dob, String address) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final updated = await repo.update(id, fullName, dob, address);
      users = users.map((u) => u.id == id ? updated : u).toList();
      if (selected?.id == id) selected = updated;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> delete(int id) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await repo.delete(id);
      users = users.where((u) => u.id != id).toList();
      if (selected?.id == id) {
        selected = users.isNotEmpty ? users.first : null;
      }
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void clearError() {
    if (error != null) {
      error = null;
      notifyListeners();
    }
  }
}
