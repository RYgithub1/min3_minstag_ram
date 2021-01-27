import 'package:min3_minstag_ram/model/database/database_manager.dart';




class UserRepository {

  /// [V-> VM -> M(R) -> M(DatabaseManager): FireStore(database)アクセス用]
  final DatabaseManager dbManager;
  UserRepository({this.dbManager});


}