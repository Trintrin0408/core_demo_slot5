import 'package:core_demo_slot5/data/dtos/usermanagement/managed_user_dto.dart';
import 'package:core_demo_slot5/data/dtos/usermanagement/update_insert_user_request_dto.dart';
import 'package:core_demo_slot5/data/implementations/local/app_database.dart';
import 'package:core_demo_slot5/data/interfaces/api/imanaged_user_api.dart';
import 'package:sqflite/sqflite.dart';

class ManagedUserApi implements IManagedUserApi{
  final AppDatabase database;
  ManagedUserApi({
    required this.database,
  });

  @override
  Future<List<ManagedUserDto>> getAll() async {
    final db = await database.db;
    final rows = await db.query(
      'managed_users',
      orderBy: 'id DESC',
    );
    return rows.map((e) => ManagedUserDto.fromMap(e)).toList();
  }
  @override
  Future<ManagedUserDto?> getById(int id) async {
    final db = await database.db;
    final rows = await db.query(
      'managed_user',
       where: 'id = ?',
       whereArgs: [id],
      limit: 1,
    );
    if(rows.isEmpty) return null;
    return ManagedUserDto.fromMap(rows.first);

  }


  @override
  Future<int> create(UpdateInsertUserRequestDto req) async {
    final db = await database.db;
    return db.insert(
      'managed_users',
      req.toMapForInsert(),
    );

  }
  Future<int> update(int id, UpdateInsertUserRequestDto req) async {
    final db = await database.db;
    return db.update(
      'managed_users',
      req.toMapForUpdate(),
        where: 'id = ?',
      whereArgs: [id],
    );

  }

  @override
  Future<int> delete(int id) async {
    final db = await database.db;
    return db.delete(
      'managed_users',
      where: 'id = ?',
      whereArgs: [id],
    );

  }

  @override
  Future<void> seedDemoIfEmpty() async {
    final db = await database.db;
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM managed_users'),);

    if((count ?? 0) > 0) return;

    await db.insert(
      'managed_users',
      {
        'full_name': 'John Doe',
        'dob': '1990/01/01',
        'address': '123 Main St',
        'created_at': DateTime.now().toIso8601String(),
      },
    );

    await db.insert(
      'managed_users',
      {
        'full_name': 'Jane Doe',
        'dob': '1995/02/02',
        'address': '456 Main St',
        'created_at': DateTime.now().toIso8601String(),
      },
    );

    await db.insert(
      'managed_users',
      {
        'full_name': 'Bob Smith',
        'dob': '1985/03/03',
        'address': '789 Main St',
        'created_at': DateTime.now().toIso8601String(),
      },
    );

  }



}