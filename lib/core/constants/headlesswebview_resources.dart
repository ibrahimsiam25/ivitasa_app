//
import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/core/constants/codes_resources.dart';

import '../../main.dart';
import 'colors_resources.dart';
import 'links_resources.dart';

///
late Completer<int> initializeHomeWebViewCompleter;
late Completer<int> initializeCartWebViewCompleter;

///
UnmodifiableListView<UserScript>? initialUserScripts = UnmodifiableListView([
  UserScript(
    source: CodesResources.hideElementsCSS,
    injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
  ),
  UserScript(
    source: CodesResources.hideElementsJS,
    injectionTime: UserScriptInjectionTime.AT_DOCUMENT_END,
  ),
]);

///
InAppWebViewSettings settings = InAppWebViewSettings(
  javaScriptEnabled: true,
  cacheEnabled: true,
  javaScriptCanOpenWindowsAutomatically: false,
  mediaPlaybackRequiresUserGesture: true,
  useShouldInterceptRequest: false,
  useShouldOverrideUrlLoading: false,
  userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
);

///
PullToRefreshController pullToRefreshController = PullToRefreshController(
  settings: PullToRefreshSettings(
    color: ColorsResources.primaryColor,
    enabled: true,
    backgroundColor: Colors.white,
    size: PullToRefreshSize.fromValue(10),
  ),
);

///
late HeadlessInAppWebView homeHeadlessWebView;

///
late HeadlessInAppWebView cartHeadlessWebView;

initializePullToRefreshControllers() {
  ///
  initializeHomeWebViewCompleter = Completer();
  initializeCartWebViewCompleter = Completer();

  ///
  homeHeadlessWebView = HeadlessInAppWebView(
    initialSettings: settings,
    initialUrlRequest: URLRequest(url: URIsResources.homeUri(isAppEnglish ? 'en' : "ar")),
    pullToRefreshController: pullToRefreshController,
    initialUserScripts: initialUserScripts,
    onWebViewCreated: (controller) async {
      await controller.injectCSSCode(source: CodesResources.hideElementsCSS);
      await controller.injectCSSCode(source: CodesResources.hideElementsJS);
      await controller.evaluateJavascript(source: CodesResources.hideElementsJS);
    },
    onLoadStop: (controller, url) async {
      //
      await controller.injectCSSCode(source: CodesResources.hideElementsCSS);
      await controller.injectCSSCode(source: CodesResources.hideElementsJS);
      await controller.evaluateJavascript(source: CodesResources.hideElementsJS);
      //
      initializeHomeWebViewCompleter.complete(0);
    },
  );

  ///
  cartHeadlessWebView = HeadlessInAppWebView(
    initialSettings: settings,
    pullToRefreshController: pullToRefreshController,
    initialUrlRequest: URLRequest(url: URIsResources.cartUri(isAppEnglish ? 'en' : "ar")),
    initialUserScripts: initialUserScripts,
    onWebViewCreated: (controller) async {
      await controller.injectCSSCode(source: CodesResources.hideElementsCSS);
      await controller.injectCSSCode(source: CodesResources.hideElementsJS);
      await controller.evaluateJavascript(source: CodesResources.hideElementsJS);
    },
    onLoadStop: (controller, url) async {
      //
      await controller.injectCSSCode(source: CodesResources.hideElementsCSS);
      await controller.injectCSSCode(source: CodesResources.hideElementsJS);
      await controller.evaluateJavascript(source: CodesResources.hideElementsJS);
      //
      initializeCartWebViewCompleter.complete(0);
    },
  );
}
