import 'dart:io';
import 'dart:ffi';
import 'dart:math';
import 'package:dailytimelog/6_models/log_model.dart';
import 'package:dailytimelog/6_models/category_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static const _databaseName = "DailyTimeLog.db";
  static const _databaseVersion = 1;

  //=============== Job Table============
  static const tb_logs = 'tb_logs';
  static const log_id = "log_id";
  static const category_id = 'category_id';
  static const log_date = "log_date";
  static const log_hour = "log_hour";
  static const created_at = "created_at";


  //============== Job Site Condition Table=======
  static const tb_category = 'tb_category';
  //static const  category_id = "category_id";
  static const  category_name = "category_name";
  static const  is_default = "is_default";
  static const  is_active = "is_active";
  //static const  created_at = "created_at";
  static const  updated_at = "updated_at";


  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print('testpath===${documentsDirectory.path}');
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tb_logs (
            $log_id INTEGER PRIMARY KEY,
            $category_id TEXT,
            $log_date TEXT,
            $log_hour TEXT,
            $created_at TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE $tb_category (
            $category_id INTEGER PRIMARY KEY,
            $category_name TEXT,
            $is_default INTEGER,
            $is_active INTEGER,
            $created_at TEXT,
            $updated_at TEXT
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row,String tablename) async {
    Database? db = await instance.database;
    return await db!.insert(tablename, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String tablename) async {
    Database? db = await instance.database;
    return await db!.query(tablename);
  }

  Future<List<LogModel>> getAllLogs() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery('SELECT * FROM $tb_logs ORDER By $log_id DESC');
    return List.generate(maps.length, (i) {
      LogModel logModel = LogModel(
          log_id: maps[i][log_id],
          category_id: maps[i][category_id],
          log_date: maps[i][log_date],
          log_hour: maps[i][log_hour],
          created_at: maps[i][created_at],
      );
      return logModel;
    });
  }

  Future<List<LogModel>> filterLogs(query) async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery('SELECT * FROM $tb_logs $query');
    return List.generate(maps.length, (i) {
      LogModel logModel = LogModel(
        log_id: maps[i][log_id],
        category_id: maps[i][category_id],
        log_date: maps[i][log_date],
        log_hour: maps[i][log_hour],
        created_at: maps[i][created_at],
      );
      return logModel;
    });
  }

  Future<int> confirmCategoryNameExist(String categoryName) async{
    Database? db = await instance.database;
    List<Map<String, dynamic>> maps = await db!.rawQuery('SELECT * FROM $tb_category WHERE $category_name ="$categoryName"');
    if(maps.isNotEmpty){
      return maps[0][category_id];
    }else{
      return 0;
    }
  }

  Future<List<CategoryModel>> getCategories() async{
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery('SELECT * FROM $tb_category  ORDER By $category_id' );
    return List.generate(maps.length, (i) {
      CategoryModel categoryModel = CategoryModel(
          category_id: maps[i][category_id],
          category_name: maps[i][category_name],
          is_default: maps[i][is_default],
          is_active: maps[i][is_active],
          created_at: maps[i][created_at],
          updated_at: maps[i][updated_at]
      );
      return categoryModel;
    });
  }


  //===================== Delete Module================
  Future<void> deleteLogData (int logId) async{
    await delete(logId, tb_logs, log_id);
  }

  Future<void> deleteCategoryData (int categoryId) async{
    await delete(categoryId, tb_category, category_id);
  }


  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount(String tablename) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $tablename'));
  }


  Future<int> update_from_int_value(Map<String, dynamic> row, String tablename, String keyColumnId, int keyColumnValue) async {
    Database? db = await instance.database;
    int updateCount = await db!.update(
        tablename,
        row,
        where: '$keyColumnId = ?',
        whereArgs: [keyColumnValue]);
    return updateCount;
  }
  Future<int> update_from_string_value(Map<String, dynamic> row, String tablename, String keyColumnId, String keyColumnValue) async {
    Database? db = await instance.database;
    int updateCount = await db!.update(
        tablename,
        row,
        where: '$keyColumnId = ?',
        whereArgs: [keyColumnValue]);
    return updateCount;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.


  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String tablename, String keyparameter) async {
    Database? db = await instance.database;
    return await db!.delete(tablename, where: '$keyparameter = ?', whereArgs: [id]);
  }

  //============= Inter A Row for Tables==============
  Future<int> saveCategory(CategoryModel categoryModel) async {
    if(categoryModel.category_id==-1){
      Map<String, dynamic> row = {
        DatabaseHelper.category_name : categoryModel.category_name,
        DatabaseHelper.is_default : categoryModel.is_default,
        DatabaseHelper.is_active : categoryModel.is_active,
        DatabaseHelper.created_at : categoryModel.created_at,
        DatabaseHelper.updated_at : categoryModel.updated_at
      };
      int savedId = await insert(row, DatabaseHelper.tb_category);//.then((value) => print('inserted row id: $value'));
      return savedId;
    }else{
      Map<String, dynamic> row = {
        DatabaseHelper.category_name : categoryModel.category_name,
        DatabaseHelper.is_default : categoryModel.is_default,
        DatabaseHelper.is_active : categoryModel.is_active,
        DatabaseHelper.created_at : categoryModel.created_at,
        DatabaseHelper.updated_at : categoryModel.updated_at
      };
      int updatedcount = await update_from_int_value(row, DatabaseHelper.tb_category, DatabaseHelper.category_id, categoryModel.category_id);
      return updatedcount;
    }
  }

  Future<int> saveLog(LogModel logModel) async {
    if(logModel.log_id==-1){
      Map<String, dynamic> row = {
        DatabaseHelper.category_id : logModel.category_id,
        DatabaseHelper.log_date : logModel.log_date,
        DatabaseHelper.log_hour : logModel.log_hour,
        DatabaseHelper.created_at : logModel.created_at
      };
      int logId = await insert(row, DatabaseHelper.tb_logs);//.then((value) => print('inserted row id: $value'));
      return logId;
    }else{
      Map<String, dynamic> row = {
        DatabaseHelper.category_id : logModel.category_id,
        DatabaseHelper.log_date : logModel.log_date,
        DatabaseHelper.log_hour : logModel.log_hour,
        DatabaseHelper.created_at : logModel.created_at
      };

      int updatedcount = await update_from_int_value(row, DatabaseHelper.tb_logs, DatabaseHelper.log_id, logModel.log_id);
      return updatedcount;
    }
    //print('inserted row id: $id');
  }
}