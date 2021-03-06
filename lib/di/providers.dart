import 'package:min3_minstag_ram/model/database/database_manager.dart';
import 'package:min3_minstag_ram/model/location/location_manager.dart';
import 'package:min3_minstag_ram/model/repository/post_repository.dart';
import 'package:min3_minstag_ram/model/repository/theme_change_repository.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';
import 'package:min3_minstag_ram/viewmodel/comment_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/login_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/search_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/theme_change_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/who_cares_me_view_model.dart';
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
  /// [LocationManager独立しているゆえ -> PostRepositoryが使用]
  Provider<LocationManager>(
    create: (_) => LocationManager(),
  ),
  Provider<ThemeChangeRepository>(
    create: (_) => ThemeChangeRepository(),
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
  // ProxyProvider<DatabaseManager, PostRepository>(
  //   update: (_, dbManager, repo) => PostRepository(),
  // ),
  /// [PostRepository()は複数依存になり]
  ProxyProvider2<DatabaseManager, LocationManager, PostRepository>(
    update: (_, dbManager, locationManager, repo) => PostRepository(
      dbManager: dbManager,
      locationManager: locationManager,
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
  ChangeNotifierProvider<FeedViewModel>(
    create: (context) => FeedViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<CommentViewModel>(
    create: (context) => CommentViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<ProfileViewModel>(
    create: (context) => ProfileViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<SearchViewModel>(
    create: (context) => SearchViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<WhoCaresMeViewModel>(
    create: (context) => WhoCaresMeViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<ThemeChangeViewModel>(
    create: (context) => ThemeChangeViewModel(
      themeRepository: Provider.of<ThemeChangeRepository>(context, listen: false),
    ),
  ),


];



