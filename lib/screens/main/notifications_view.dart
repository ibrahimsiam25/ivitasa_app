import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ivitasa_app/core/services/injection/app_injection.dart';
import '../../core/constants/colors_resources.dart';
import '../../core/constants/images_resources.dart';
import '../../core/constants/sizes_resources.dart';
import '../../core/services/messaging/messaging/firebase_messaging_handlers.dart' as n;
import '../../states/notifications/notifications_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    sl<NotificationsBloc>().add(InitializeNotificationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NotificationsBloc>()..add(InitializeNotificationsEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(ImagesResources.inAppLogo, height: 25),
        ),
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationTileWidget(
                      notification: state.notifications[index],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({
    super.key,
    required this.notification,
  });
  final n.Notification notification;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 1 * SizesResources.s1, vertical: 2 * SizesResources.s1),
            width: MediaQuery.sizeOf(context).width - SizesResources.s4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorsResources.bordersColor,
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorsResources.primaryColor.withAlpha(10),
                  spreadRadius: 0.2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4 * SizesResources.s1, vertical: 4 * SizesResources.s1),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: SizesResources.s2, right: SizesResources.s2),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: ColorsResources.primaryColor.withAlpha(20),
                              child: Image.asset(
                                ImagesResources.notificationsIcon,
                                width: 16,
                                color: ColorsResources.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (notification.title != null)
                                Text(
                                  notification.title!,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              SizedBox(height: SizesResources.s1),
                              if (notification.body != null)
                                Text(
                                  notification.body!,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
