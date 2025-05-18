import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ivitasa_app/core/constants/images_resources.dart';
import 'package:ivitasa_app/core/constants/sizes_resources.dart';
import 'package:ivitasa_app/screens/pages_holder_view.dart';
import 'package:ivitasa_app/screens/welcome/app_start_view.dart';
import 'package:ivitasa_app/widgets/staggered_item_wrapper_widget.dart';
import '../../core/constants/codes_resources.dart';
import '../../core/constants/headlesswebview_resources.dart';
import '../../services/cache_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      bool firstTime = CacheService().getBool("first_time") ?? true;
      if (firstTime) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AppStartView()));
      } else {
        await load();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PagesHolderView()));
      }
    });
    super.initState();
  }

  Future load() async {
    //
    initializePullToRefreshControllers();
    //
    await homeHeadlessWebView.run();
   await homeHeadlessWebView.webViewController?.injectCSSCode(source: CodesResources.hideElementsCSS);
    await homeHeadlessWebView.webViewController?.injectCSSCode(source: CodesResources.hideElementsJS);
    
    cartHeadlessWebView.run();
    cartHeadlessWebView.webViewController?.injectCSSCode(source: CodesResources.hideElementsCSS);
    cartHeadlessWebView.webViewController?.injectCSSCode(source: CodesResources.hideElementsJS);
    //
    await initializeHomeWebViewCompleter.future;
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Spacer(),
          SizedBox(height: SizesResources.s20),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutExpo,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: StaggeredItemWrapperWidget(
                  position: 0,
                  child: Hero(
                    tag: ImagesResources.appLogo,
                    child: Image.asset(
                      ImagesResources.appLogo,
                      width: 75,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: SizesResources.s10),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeOutExpo,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: StaggeredItemWrapperWidget(
                  position: 3,
                  child: CupertinoActivityIndicator(
                    radius: 7,
                    color: Colors.black38,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: SizesResources.s20),
          Spacer(),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeOutExpo,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Column(
                  children: [
                    StaggeredItemWrapperWidget(
                      position: 20,
                      child: Text(
                        "IVITASA © 2025",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(height: SizesResources.s1),
                    StaggeredItemWrapperWidget(
                      position: 4,
                      child: Text(
                        "v1.0.0",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: SizesResources.s10),
        ],
      ),
    );
  }
}
