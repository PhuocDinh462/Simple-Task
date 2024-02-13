import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationServices {
  LocalNotificationServices();
  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceivedLocalNotification);

    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _localNotificationService.initialize(settings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      required String detail}) async {
    final details = await _notificationDetails(detail);
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showSchNotification(
      {required int id,
      required String title,
      required String body,
      required String detail,
      required DateTime due}) async {
    final details = await _notificationDetails(detail);

    await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(due.subtract(const Duration(minutes: 10)), tz.local),
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future<NotificationDetails> _notificationDetails(String detail) async {
    final styleNotificationInfo = BigTextStyleInformation(detail);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            channelDescription: 'decs',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            styleInformation: styleNotificationInfo);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> cancelSchNotification({
    required int id,
  }) async {
    await _localNotificationService.cancel(id);
  }

  void onSelectNotification(String? payload) {
    print(payload);
  }

  onDidReceivedLocalNotification(
      int? id, String? title, String? body, String? payload) {
    print(id);
  }
}
