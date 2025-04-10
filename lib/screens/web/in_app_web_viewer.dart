import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/widgets/loading_builder_widget.dart';
import '../../core/constants/codes_resources.dart';

class AppWebViewerView extends StatefulWidget {
  const AppWebViewerView({
    super.key,
    this.uri,
    this.initialWebView,
  });
  final WebUri? uri;
  final HeadlessInAppWebView? initialWebView;
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
        title: Text(title ?? ""),
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
