// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../network/repository/chat_repository.dart' as _i3;
import '../network/repository/impl/chat_repository_impl.dart' as _i4;
import '../presentation/chat_page/bloc/chat_bloc.dart' as _i7;
import '../presentation/claude_page/bloc/claude_bloc.dart' as _i5;
import '../presentation/login_page/bloc/login_bloc.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.ChatRepository>(() => _i4.ChatRepositoryImpl());
    gh.lazySingleton<_i5.ClaudeBloc>(
        () => _i5.ClaudeBloc(gh<_i3.ChatRepository>()));
    gh.lazySingleton<_i6.LoginBloc>(
        () => _i6.LoginBloc(gh<_i3.ChatRepository>()));
    gh.lazySingleton<_i7.ChatBloc>(
        () => _i7.ChatBloc(gh<_i3.ChatRepository>()));
    return this;
  }
}
