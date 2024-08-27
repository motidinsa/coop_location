import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

parseInit() async {
  final keyApplicationId = 'RQG1TQjR8H0ep3vMwjEl4NJsYrCww57HfAmXJpU3';
  final keyClientKey = 'lNgkLt1ilLwhqAHxnOFX1dXIyylpMiSJfRcvChKS';
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  final liveQueryUrl = 'https://mystationerylive.b4a.io';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    liveQueryUrl: liveQueryUrl,
    // debug: true,
  );
}
