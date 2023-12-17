import 'package:get_it/get_it.dart';
import 'package:kashtat/Core/Cubit/LanguageCubit.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(
    () => LanguageBloc(),
  );

}
