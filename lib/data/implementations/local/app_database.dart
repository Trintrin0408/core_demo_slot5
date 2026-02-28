import 'package:core_demo_slot5/data/implementations/local/password_hasher.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _open();
    return _db!;
  }

  // Hàm helper để tránh lặp code tạo bảng
  Future<void> _createManagedUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE managed_users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        dob TEXT NOT NULL,
        address TEXT NOT NULL
      );
    ''');
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mvvm_project.db');

    return openDatabase(
      path,
      version: 4, // Đã nâng lên phiên bản 3
      onCreate: (Database db, int version) async {
        // Bảng user (cho việc đăng nhập)
        await db.execute('''
          CREATE TABLE user(  
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            user_Name TEXT NOT NULL UNIQUE,
            password_hash TEXT NOT NULL
          );
        ''');

        // Bảng session
        await db.execute(''' 
          CREATE TABLE session(
            id INTEGER PRIMARY KEY CHECK (id = 1),
            user_id INTEGER NOT NULL,
            token TEXT NOT NULL,
            created_at TEXT NOT NULL
          );
        ''');

        // Tạo bảng managed_users cho người dùng mới cài đặt
        await _createManagedUsersTable(db);

        // Chèn tài khoản admin mặc định
        await db.insert('user', {
          'user_Name': 'admin',
          'password_hash': PasswordHasher.sha256Hash('Fu@2026'),
        });
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Logic nâng cấp cơ sở dữ liệu
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE Quanlithongtin(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              ten TEXT NOT NULL,
              ngay_sinh TEXT NOT NULL,
              dia_chi TEXT
            );
          ''');
        }
        if (oldVersion < 3) {
          // Tạo bảng managed_users cho người dùng cũ đang nâng cấp
          await db.execute(''' 
            CREATE TABLE managed_users(
              id INTEGER PRIMARY KEY CHECK (id = 1),
              full_name TEXT NOT NULL,
              dob TEXT NOT NULL ,
              address TEXT NOT NULL,
              created_at TEXT NOT NULL);
            ''');
        }
        if (oldVersion < 4) {
          await db.execute('DROP TABLE IF EXISTS Quanlithongtin;');
        }
      },

    );
  }
}

