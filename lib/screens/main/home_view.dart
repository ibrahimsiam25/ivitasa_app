import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/core/constants/codes_resources.dart';
import 'package:ivitasa_app/core/constants/colors_resources.dart' ;
import 'package:ivitasa_app/core/constants/images_resources.dart';
import 'package:ivitasa_app/core/constants/language_resources.dart';
import 'package:ivitasa_app/widgets/loading_builder_widget.dart';

import 'package:provider/provider.dart';
import '../../core/constants/headlesswebview_resources.dart';
import '../../core/constants/links_resources.dart';
import '../../states/local/local_provider.dart';

import '../search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
    bool _canGoBack = false;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:_canGoBack
          ? null
          : AppBar(
        backgroundColor: ColorsResources.primaryColor,
        title: Image.asset(
          color: Colors.white,
          ImagesResources.inAppLogo, height: 30),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                // Use the context provided by Builder
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu ,color: Colors.white,),
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
            icon: Icon(Icons.search,color:  Colors.white),
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
      body:  AppWebViewerView(
      uri: URIsResources.homeUri(context.read<LocalProvider>().local),
     canGoBack: (value) {
          setState(() {
            _canGoBack = value;
          });
        },
      initialWebView: null
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
              color: Colors.white,
            ),
            child:Image.asset(ImagesResources.appLogo)
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


class AppWebViewerView extends StatefulWidget {
  const AppWebViewerView({
    super.key,
    this.uri,
    this.initialWebView,
    this.canGoBack,
  });
  final WebUri? uri;
  final HeadlessInAppWebView? initialWebView;
 final ValueChanged<bool>? canGoBack;
  @override
  State<AppWebViewerView> createState() => _AppWebViewerViewState();
}

class _AppWebViewerViewState extends State<AppWebViewerView> {
  ///
  late String? title;

  ///
  late InAppWebViewController _controller;

  ///
  late bool _isLoading;
  late bool _canGoBack;

  ///
  @override
  void initState() {
    _isLoading = true;
    _canGoBack = false;
    title = "";
    widget.initialWebView?.run();

    super.initState();
  }

  ///
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

void onLoadStart(InAppWebViewController controller, WebUri? webUri) async {
  setState(() {
    _isLoading = true;
  });
  _controller = controller;
  _canGoBack = await controller.canGoBack();
  widget.canGoBack?.call(_canGoBack);
  setState(() {});
}

void onLoadStop(InAppWebViewController controller, WebUri? webUri) async {
  _controller = controller;
  _canGoBack = await controller.canGoBack();
  widget.canGoBack?.call(_canGoBack);

  await controller.injectCSSCode(source: CodesResources.hideElementsCSS);
  await controller.evaluateJavascript(source: CodesResources.hideElementsJS);

  setState(() {
    _isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _canGoBack?AppBar(
       title: Text(
          title ?? "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        leading:
             IconButton(
                onPressed: () {
                  _controller.goBack();
                },
                icon: Icon(Icons.arrow_back_ios),
              )
           
      ):null,
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: widget.uri),
            headlessWebView: widget.initialWebView,
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              cacheEnabled: true,
              javaScriptCanOpenWindowsAutomatically: false,
              mediaPlaybackRequiresUserGesture: true,
              useShouldInterceptRequest: false,
              useShouldOverrideUrlLoading: false,
            ),
            onTitleChanged: (controller, title) {
              setState(() {
                this.title = title;
              });
            },
            initialUserScripts: UnmodifiableListView(
              [
                UserScript(
                  source: CodesResources.hideElementsCSS,
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
                ),
                UserScript(
                  source: CodesResources.hideElementsJS,
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_END,
                ),
              ],
            ),
            onWebViewCreated: (controller) async {
              _controller = controller;
            },
            onLoadStart: onLoadStart,
            onLoadStop: onLoadStop,
          ),
          if (_isLoading)
            LoadingBuilderWidget(),
        ],
      ),
    );
  }
}
