import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/core/constants/colors_resources.dart';
import 'package:ivitasa_app/core/constants/headlesswebview_resources.dart';
import 'package:ivitasa_app/core/constants/language_resources.dart';
import 'package:ivitasa_app/core/constants/sizes_resources.dart';
import 'package:ivitasa_app/widgets/in_app_web_viewer_widget.dart';
import 'package:provider/provider.dart';
import '../core/constants/codes_resources.dart';
import '../core/constants/links_resources.dart';
import '../states/local/local_provider.dart';
import '../widgets/loading_builder_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
    this.searchType = "product",
  });
  final String searchType;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late String keywords;
  late bool isProduct;

  ///
  late InAppWebViewController _controller;

  ///
  late bool _isLoading;
  late bool _canGoBack;

  @override
  void initState() {
    keywords = "";
    isProduct = widget.searchType == "product";
    _isLoading = true;
    _canGoBack = false;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          if (isProduct)
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SearchView(
                          searchType: "post",
                        )));
              },
              child: Text(LanguageResource.getText("search_in_posts", context.watch<LocalProvider>().local)),
            ),
          if (!isProduct)
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SearchView()));
              },
              child: Text(LanguageResource.getText("search_in_products", context.watch<LocalProvider>().local)),
            ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SearchFieldWidget(
              isProduct: isProduct,
              onSubmitted: (keywords) {
                this.keywords = keywords;
                _controller.loadUrl(
                  urlRequest: URLRequest(
                    url: URIsResources.search(
                      context.read<LocalProvider>().local,
                      keywords,
                      widget.searchType,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: URIsResources.search(
                      context.watch<LocalProvider>().local,
                      keywords,
                      widget.searchType,
                    )),
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
                    initialUserScripts: initialUserScripts,
                    onWebViewCreated: (controller) async {
                      _controller = controller;
                    },
                    onLoadStart: onLoadStart,
                    onLoadStop: onLoadStop,
                  ),
                  if (_canGoBack)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton.filled(
                          style: TextButton.styleFrom(
                            side: BorderSide(
                              color: ColorsResources.primaryColor,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            _controller.goBack();
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: ColorsResources.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_isLoading) LoadingBuilderWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    super.key,
    required this.isProduct,
    required this.onSubmitted,
  });
  final bool isProduct;
  final void Function(String keywords) onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.watch<LocalProvider>().isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width - SizesResources.s2,
          child: TextFormField(
            style: TextStyle(
              fontSize: 14,
            ),
            onFieldSubmitted: (value) {
              if (value.isEmpty) return;
              onSubmitted(value);
            },
            decoration: InputDecoration(
              labelText: LanguageResource.getText(isProduct ? "search_in_products" : "search_in_posts", context.watch<LocalProvider>().local),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  backgroundColor: ColorsResources.primaryColor,
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                gapPadding: 1,
                borderSide: BorderSide(
                  color: ColorsResources.bordersColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(SizesResources.s10),
              ),
              enabledBorder: OutlineInputBorder(
                gapPadding: 1,
                borderSide: BorderSide(
                  color: ColorsResources.bordersColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(SizesResources.s10),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 1,
                borderSide: BorderSide(
                  color: ColorsResources.bordersColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(SizesResources.s10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
