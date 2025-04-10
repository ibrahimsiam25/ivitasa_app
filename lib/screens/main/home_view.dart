import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/core/constants/colors_resources.dart';
import 'package:ivitasa_app/core/constants/images_resources.dart';
import 'package:ivitasa_app/core/constants/language_resources.dart';
import 'package:provider/provider.dart';
import '../../core/constants/headlesswebview_resources.dart';
import '../../core/constants/links_resources.dart';
import '../../states/local/local_provider.dart';
import '../../widgets/in_app_web_viewer_widget.dart';
import '../search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(ImagesResources.inAppLogo, height: 25),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                // Use the context provided by Builder
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchView(),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      drawer: HomeDrawerWidget(
        onTapPressed: (uri) {
          homeHeadlessWebView.webViewController?.loadUrl(
            urlRequest: URLRequest(url: uri),
          );
        },
      ),
      body: InAppWebViewerWidget(
        url: URIsResources.homeUri(context.watch<LocalProvider>().local),
        title: Image.asset(ImagesResources.inAppLogo, height: 25),
        headlessWebView: homeHeadlessWebView,
        disableAppBar: true,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
    required this.onTapPressed,
  });
  final void Function(WebUri uri) onTapPressed;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: ListView(
        //
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorsResources.primaryContainerColor,
            ),
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          drawerItemBuilder(
            LanguageResource.getText(
              "drawer_home_label",
              context.watch<LocalProvider>().local,
            ),
            () {
              onTapPressed(URIsResources.homeUri(context.read<LocalProvider>().local));
              Navigator.pop(context);
            },
          ),
          drawerItemBuilder(
            LanguageResource.getText(
              "drawer_health_questions_label",
              context.watch<LocalProvider>().local,
            ),
            () {
              onTapPressed(URIsResources.healthQuestions(context.read<LocalProvider>().local));
              Navigator.pop(context);
            },
          ),
          drawerItemBuilder(
            LanguageResource.getText(
              "drawer_vitamins_market_label",
              context.watch<LocalProvider>().local,
            ),
            () {
              onTapPressed(URIsResources.vitaminesMarket(context.read<LocalProvider>().local));
              Navigator.pop(context);
            },
          ),
          drawerItemBuilder(
            LanguageResource.getText(
              "drawer_lab_services_label",
              context.watch<LocalProvider>().local,
            ),
            () {
              onTapPressed(URIsResources.labServices(context.read<LocalProvider>().local));
              Navigator.pop(context);
            },
          ),
          drawerItemBuilder(
            LanguageResource.getText(
              "drawer_doctor_consulting_label",
              context.watch<LocalProvider>().local,
            ),
            () {
              onTapPressed(URIsResources.doctorConsulting(context.read<LocalProvider>().local));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  drawerItemBuilder(String title, Function() onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 12),
      onTap: onTap,
    );
  }
}
