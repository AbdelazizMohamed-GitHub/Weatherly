import 'package:hive_flutter/hive_flutter.dart';

class AppSettingsService {
  final Box box;

  AppSettingsService({required this.box});

  bool get isFirstTime => box.get('isFirstTime', defaultValue: true);

  Future<void> setFirstTimeCompleted() async {
    await box.put('isFirstTime', false);
  }
}
