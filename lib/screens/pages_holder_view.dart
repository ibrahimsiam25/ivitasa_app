import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ivitasa_app/core/constants/headlesswebview_resources.dart';
import 'package:ivitasa_app/core/constants/language_resources.dart';
import 'package:ivitasa_app/core/constants/links_resources.dart';
import 'package:ivitasa_app/core/constants/sizes_resources.dart';
import 'package:ivitasa_app/main.dart';
import 'package:ivitasa_app/screens/main/cart_view.dart';
import 'package:ivitasa_app/screens/main/notifications_view.dart';
import 'package:ivitasa_app/screens/main/settings_view.dart';
import 'package:provider/provider.dart';
import '../core/constants/colors_resources.dart';
import '../core/constants/images_resources.dart';
import '../states/local/local_provider.dart';
import 'main/home_view.dart';

class PagesHolderView extends StatefulWidget {
  const PagesHolderView({super.key});

  @override
  State<PagesHolderView> createState() => _PagesHolderViewState();
}

class _PagesHolderViewState extends State<PagesHolderView> {
  int currentPage = 0;
  final homePage = ValueKey('home_page');
  final cartPage = ValueKey('cart_page');
  final notificationsPage = ValueKey('notifications_page');
  final settingsPage = ValueKey('settings_page');
  late final PageController _controller;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.read<LocalProvider>().isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            HomeView(key: homePage),
            CartView(key: cartPage),
            NotificationsView(key: notificationsPage),
            SettingsView(key: settingsPage),
          ],
        ),
        bottomNavigationBar: _NavigationBar(
          currentIndex: currentPage,
          changePage: (pageIndex) {
            if (pageIndex != 1) {
              cartHeadlessWebView.webViewController?.reload();
            }
            currentPage = pageIndex;
            _controller.jumpToPage(currentPage);
            setState(() {
              currentPage;
            });
          },
        ),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({
    required this.currentIndex,
    required this.changePage,
  });
  final int currentIndex;
  final void Function(int pageIndex) changePage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + SizesResources.s2,
        top: SizesResources.s5,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// home
          NavigationBarItemWidget(
            changePage: changePage,
            currentIndex: currentIndex,
            itemIndex: 0,
            itemLabel: LanguageResource.getText("home_label", context.watch<LocalProvider>().local),
            imagePath: ImagesResources.homeIcon,
          ),

          /// orders
          NavigationBarItemWidget(
            changePage: changePage,
            currentIndex: currentIndex,
            itemIndex: 1,
            itemLabel: LanguageResource.getText("cart_label", context.watch<LocalProvider>().local),
            imagePath: ImagesResources.cartIcon,
          ),

          /// orders
          NavigationBarItemWidget(
            changePage: changePage,
            currentIndex: currentIndex,
            itemIndex: 2,
            itemLabel: LanguageResource.getText("notification_label", context.watch<LocalProvider>().local),
            imagePath: ImagesResources.notificationsIcon,
          ),

          /// orders
          NavigationBarItemWidget(
            changePage: changePage,
            currentIndex: currentIndex,
            itemIndex: 3,
            itemLabel: LanguageResource.getText("settings_label", context.watch<LocalProvider>().local),
            imagePath: ImagesResources.settingsIcon,
          ),
        ],
      ),
    );
  }
}

class NavigationBarItemWidget extends StatelessWidget {
  const NavigationBarItemWidget({
    super.key,
    required this.changePage,
    required this.itemIndex,
    required this.currentIndex,
    required this.itemLabel,
    required this.imagePath,
  });

  final int itemIndex;
  final String itemLabel;
  final String imagePath;
  final int currentIndex;
  final void Function(int pageIndex) changePage;

  @override
  Widget build(BuildContext context) {
    //
    final activeColor = ColorsResources.primaryColor;
    final unActiveColor = Theme.of(context).colorScheme.onSurfaceVariant;
    //
    return Expanded(
      child: GestureDetector(
        onTap: () {
          changePage(itemIndex);
        },
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: Durations.medium1,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: currentIndex == itemIndex ? ColorsResources.primaryLightColor : null,
                ),
                child: Image.asset(
                  color: currentIndex == itemIndex ? ColorsResources.primaryColor : unActiveColor,
                  imagePath,
                  width: 20,
                ),
              ),
              //
              const SizedBox(
                height: SizesResources.s2,
              ),
              //
              Text(
                itemLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: currentIndex == itemIndex ? activeColor : unActiveColor,
                      fontSize: 10,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
