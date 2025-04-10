import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/core/constants/colors_resources.dart';
import 'package:ivitasa_app/screens/search_view.dart';
import 'package:ivitasa_app/widgets/loading_builder_widget.dart';
import '../core/constants/codes_resources.dart';

class InAppWebViewerWidget extends StatefulWidget {
  const InAppWebViewerWidget({
    super.key,
    required this.url,
    this.disableAppBar = false,
    this.contentBlockers,
    this.headlessWebView,
    this.title,
  });
  final Widget? title;
  final HeadlessInAppWebView? headlessWebView;
  final WebUri url;
  final List<ContentBlocker>? contentBlockers;
  final bool disableAppBar;

  @override
  State<InAppWebViewerWidget> createState() => _InAppWebViewerWidgetState();
}

// prevent state from re build
class _InAppWebViewerWidgetState extends State<InAppWebViewerWidget> {
  ///
  late InAppWebViewController _controller;
  late PullToRefreshController? pullToRefreshController;

  ///
  late bool _isLoading;
  late bool _canGoBack;

  ///
  @override
  void initState() {
    _isLoading = false;
    _canGoBack = false;
    //
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: ColorsResources.primaryContainerColor,
        enabled: true,
        backgroundColor: ColorsResources.onPrimaryContainerColor,
        size: PullToRefreshSize.fromValue(10),
      ),
      onRefresh: () async {
        setState(() {
          _isLoading = false;
        });
        //
        _controller.reload();
        //
        return;
      },
    );
    //
    super.initState();
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
    await pullToRefreshController?.endRefreshing();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.disableAppBar
          ? null
          : AppBar(
              title: widget.title,
              leading: _canGoBack
                  ? IconButton(
                      onPressed: () {
                        _controller.goBack();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    )
                  : null,
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
      body: Stack(
        children: [
          InAppWebView(
            headlessWebView: widget.headlessWebView,
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              cacheEnabled: true,
              javaScriptCanOpenWindowsAutomatically: false,
              mediaPlaybackRequiresUserGesture: true,
              useShouldInterceptRequest: false,
              useShouldOverrideUrlLoading: false,
              useShouldInterceptAjaxRequest: false,
              useShouldInterceptFetchRequest: false,
            ),
            pullToRefreshController: pullToRefreshController,
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
