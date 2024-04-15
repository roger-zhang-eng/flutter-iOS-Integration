import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mybatteryplugin/mybatteryplugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMybatteryplugin platform = MethodChannelMybatteryplugin();
  const MethodChannel channel = MethodChannel('mybatteryplugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'getPlatformVersion') {
          return '42';
        } else if (methodCall.method == 'getBatteryLevel') {
          return 21;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('getBatteryLevel', () async {
    expect(await platform.getBatteryLevel(), 21);
  });
}
