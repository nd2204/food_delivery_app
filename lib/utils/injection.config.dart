// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:food_delivery_app/services/auth_service.dart' as _i247;
import 'package:food_delivery_app/services/firebase_auth_service.dart'
    as _i1038;
import 'package:food_delivery_app/viewmodels/login_view_model.dart' as _i1020;
import 'package:food_delivery_app/viewmodels/signup_view_model.dart' as _i899;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1020.LoginViewModel>(() => _i1020.LoginViewModel());
    gh.factory<_i899.SignUpViewModel>(() => _i899.SignUpViewModel());
    gh.lazySingleton<_i247.AuthService>(
      () => const _i1038.FirebaseAuthService(),
    );
    return this;
  }
}
