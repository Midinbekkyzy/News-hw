import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

part 'main_event.dart';
part 'main_state.dart';

@injectable
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required FirebaseMessaging firebaseMessaging,
    required Talker talker,
  }) : _firebaseMessaging = firebaseMessaging,
       _talker = talker,
       super(MainInitial()) {
    on<CheckNotificationPermissionEvent>(_checkNotificationPermission);
  }

  final FirebaseMessaging _firebaseMessaging;
  final Talker _talker;

  Future<void> _checkNotificationPermission(
    CheckNotificationPermissionEvent event,
    Emitter<MainState> emit,
  ) async {
    try {
      if (kIsWeb) {
        return;
      }

      var settings = await _firebaseMessaging.getNotificationSettings();

      if (!_isPermissionGranted(settings.authorizationStatus)) {
        settings = await _firebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      if (!_isPermissionGranted(settings.authorizationStatus)) {
        debugPrint('Firebase Messaging: notification permission denied');
        return;
      }

      final token = await _firebaseMessaging.getToken();
      if (token == null || token.isEmpty) {
        debugPrint('Firebase Messaging: token is empty');
        return;
      }

      debugPrint('Firebase Messaging token: $token');
      _talker.info('Firebase Messaging token: $token');
    } catch (error, stackTrace) {
      _talker.handle(
        error,
        stackTrace,
        'Failed to check notification permission or receive FCM token',
      );
    }
  }

  bool _isPermissionGranted(AuthorizationStatus status) {
    return status == AuthorizationStatus.authorized ||
        status == AuthorizationStatus.provisional;
  }
}
