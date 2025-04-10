import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import '../../core/constants/codes_resources.dart';
import '../../core/constants/images_resources.dart';
import '../../core/constants/links_resources.dart';
import '../../states/local/local_provider.dart';
import '../../widgets/loading_builder_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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
    setState(() {
      _canGoBack;
    });
  }

  ///
  void onLoadStop(InAppWebViewController controller, WebUri? webUri) async {
    _controller = controller;
    _canGoBack = await controller.canGoBack();
    setState(() {
      _canGoBack;
    });
    await controller.injectCSSCode(source: CodesResources.hideElementsCSS);
    await controller.injectCSSCode(source: CodesResources.hideElementsJS);
    await controller.evaluateJavascript(source: CodesResources.hideElementsJS);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImagesResources.inAppLogo, height: 25),
        centerTitle: true,
        leading: _canGoBack
            ? IconButton(
                onPressed: () {
                  _controller.goBack();
                },
                icon: Icon(Icons.arrow_back_ios),
              )
            : null,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: URIsResources.cartUri(context.watch<LocalProvider>().local)),
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
