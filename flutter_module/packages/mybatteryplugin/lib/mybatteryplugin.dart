
import 'mybatteryplugin_platform_interface.dart';

class Mybatteryplugin {
  Future<String?> getPlatformVersion() {
    return MybatterypluginPlatform.instance.getPlatformVersion();
  }

  /// Returns the battery level as a percentage.
  Future<num?> getBatteryLevel() {
    return MybatterypluginPlatform.instance.getBatteryLevel();
  }
}
