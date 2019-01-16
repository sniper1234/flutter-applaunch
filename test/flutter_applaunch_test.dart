import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_applaunch/flutter_applaunch.dart';

void main() {
  FlutterApplaunchPlugin applaunch;

  setUp(() {
    applaunch = new FlutterApplaunchPlugin();
  });

  test('Get url scheme', () {
    applaunch.getAppLaunchURLScheme().then((scheme) {
      expect(scheme, null);
    });
  });
}
