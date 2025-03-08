import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'NEWS_API_KEY')
  static final String NEWS_API_KEY = _Env.NEWS_API_KEY;
}
