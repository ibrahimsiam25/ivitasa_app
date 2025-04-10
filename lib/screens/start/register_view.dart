import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/core/constants/codes_resources.dart';
import 'package:ivitasa_app/screens/pages_holder_view.dart';
import 'package:ivitasa_app/screens/start/splash_view.dart';
import 'package:provider/provider.dart';

import '../../core/constants/links_resources.dart';
import '../../services/cache_service.dart';
import '../../states/local/local_provider.dart';
import '../../widgets/in_app_web_viewer_widget.dart';
import '../../widgets/loading_builder_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  ///
  late String? title;

  ///
  late InAppWebViewController _controller;

  ///
  late bool _isLoading;
  late bool _canNavigate;

  ///
  @override
  void initState() {
    _isLoading = true;
    _canNavigate = false;
    title = "";

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
  }

  ///
  void onLoadStop(InAppWebViewController controller, WebUri? webUri) async {
    _controller = controller;
    await controller.injectCSSCode(source: CodesResources.hideElementsCSS);
    await controller.injectCSSCode(source: CodesResources.hideElementsJS);
    await controller.evaluateJavascript(source: CodesResources.hideElementsJS);

    // Check if the element with the specified class exists
    final hasElement = await controller.evaluateJavascript(
      source: '''
      (function() {
        const element = document.querySelector('.woocommerce-MyAccount-title.entry-title');
        return element !== null;
      })();
    ''',
    );

    if (hasElement == true && mounted) {
      await CacheService().setBool("first_time", false);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashView()));
      return;
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: URIsResources.myAccountUri(context.watch<LocalProvider>().local),
            ),
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
          if (_isLoading) LoadingBuilderWidget(),
        ],
      ),
    );
  }
}
