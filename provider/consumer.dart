import 'dart:io';

import 'package:favourite_places/model/blueprint.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getData() async {
  final dbPath = await sql
      .getDatabasesPath(); //this is the defaut dataBase of a system and here we are getting it.
  final db = await sql.openDatabase(
    path.join(
      dbPath,
      'places.db',
    ), //the open database opens the data base and the join method joins db path to our creates path but condition is it should be end with .db
    onCreate: (db, version) {
      //this function will perform when the path is opens for the first time to set or perform some initailizers
      return db.execute(
        'CREATE TABLE user_places(name TEXT,image TEXT,address TEXT,lat REAL,lng REAL,id TEXT PRIMARY KEY)',
      );
    },
    version: 1,
  );
  return db;
}

class ConsumerStateNotifier extends StateNotifier<List<Blueprint>> {
  ConsumerStateNotifier() : super([]);
  Future<void> onLoadingData() async {
    final db = await _getData();
    final quer = await db.query('user_places');
    final data = quer
        .map(
          (row) => Blueprint(
            row['name'] as String,
            File(row['image'] as String),
            // OnPreview(
            //   row['address'] as String,
            //   row['lat'] as double,
            //   row['lng'] as double,
            // ),
            row['id'] as String,
          ),
        )
        .toList();
    state = data;
  }

  Future<int> onDeleteData() async {
    final delDir = await _getData();

    final onRemove = await delDir.delete(
      'user_places',
      where: 'id=?',
      whereArgs: ['id'].toList(),
    );
    return onRemove;
  }

  void getData(Blueprint element) async {
    final getDir = await syspaths
        .getApplicationDocumentsDirectory(); //we have get the directory
    final getFile = path.basename(
      element.image.path,
    ); // we have now get the file path which will be in directory
    final copiedImage = await element.image.copy(
      '${getDir.path}/$getFile',
    ); //now we are copying the orignal image -directory and file

    final isPlace = state.contains(element);
    if (isPlace) {
      state = state
          .where((value) => value != element)
          .toList(); //for the remove method
    } else {
      final value = Blueprint(
        element.name,
        copiedImage,
        // element.preview,
      ); //now the image have been saved in copiedImage place
      final db = await _getData();
      db.insert(
        'user_places',
        {
          'name': element.name,
          'image': element.image.path,
          //    'address': element.preview.result,
          //  'lat': element.preview.latitiude,
          //'lng': element.preview.longitude,
          'id': element.id,
        },
      ); //this method will insert the data into the database insert(path of table ,values of diff parameters set above )
      state = [...state, value]; //for the add method
    }
  }
}

final screenProvider =
    StateNotifierProvider<ConsumerStateNotifier, List<Blueprint>>(
      (ref) => ConsumerStateNotifier(),
    );
