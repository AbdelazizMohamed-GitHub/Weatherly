import 'package:geolocator/geolocator.dart';
class LocationService{

static Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('خطأ في تشغيل خدمة الموقع');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('تم رفض صلاحيات الموقع');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'تم رفض صلاحيات الموقع بسبب قيود الصلاحيات');
  }

  return await Geolocator.getCurrentPosition();
}

}