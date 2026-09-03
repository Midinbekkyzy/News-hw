import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:news_hw/firebase_options.dart';
import 'package:talker/talker.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final talker = Talker();
  talker.info(
    'Push message received. '
    'source=background, messageId=${message.messageId}, '
    'title=${message.notification?.title}, '
    'body=${message.notification?.body}',
  );
}
