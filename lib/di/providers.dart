import 'package:min3_minstag_ram/model/database/database_manager.dart';
import 'package:min3_minstag_ram/model/repository/post_repository.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';
import 'package:min3_minstag_ram/viewmodel/login_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';




List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];




List<SingleChildWidget> independentModels = [
  /// [V -> VM -> R -> DatabaseManager => (外部)remote/local]
  /// [ログイン処理の設計部分のproviders]
  /// [誰にも依存しないのはDatabaseManager]
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
    // dispose: xxx,
  ),



];



List<SingleChildWidget> dependentModels = [
  /// [(R -> DatabaseManager) UserRepositoryはDatabaseManagerに依存]
  /// [ProxyProvider<依存される側, 依存する側>()]
  /// [ProxyProvider<DeepLayer, ShallowLayer>()]
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbManager, repo) => UserRepository(
      dbManager: dbManager,   /// [DI,namedPara]
    ),
  ),
  ProxyProvider<DatabaseManager, PostRepository>(
    update: (_, dbManager, repo) => PostRepository(
    ),
  ),


];



List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),   /// [DI,namedPara]
    ),
  ),
  ChangeNotifierProvider<PostViewModel>(
    create: (context) => PostViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),


];
