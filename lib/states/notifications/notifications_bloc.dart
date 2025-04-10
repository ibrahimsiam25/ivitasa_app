import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/services/messaging/messaging/firebase_messaging_handlers.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsState.loading()) {
    on<InitializeNotificationsEvent>(onInitializeNotificationsEvent);
  }
  onInitializeNotificationsEvent(InitializeNotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationsState.initial(await getNotifications()));
  }
}
