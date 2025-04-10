import 'package:flutter/material.dart';
import 'package:ivitasa_app/core/constants/colors_resources.dart';
import 'package:ivitasa_app/core/constants/images_resources.dart';
import 'package:ivitasa_app/core/constants/sizes_resources.dart';
import 'package:ivitasa_app/screens/start/register_view.dart';
import 'package:provider/provider.dart';

import '../../core/constants/language_resources.dart';
import '../../main.dart';
import '../../services/cache_service.dart';
import '../../states/local/local_provider.dart';
import '../start/splash_view.dart';

class AppStartView extends StatefulWidget {
  const AppStartView({super.key});

  @override
  State<AppStartView> createState() => _AppStartViewState();
}

class _AppStartViewState extends State<AppStartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () async {
              await CacheService().setBool("is_english", false);
              if (context.mounted) {
                context.read<LocalProvider>().toggleLanguage();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashView()));
              }
            },
            child: Row(
              spacing: 10,
              children: [
                isAppEnglish ? Image.asset(ImagesResources.arabicIcon, width: 20) : Image.asset(ImagesResources.englishIcon, width: 20),
                Text(
                  LanguageResource.getText("language", context.watch<LocalProvider>().local),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Hero(
                tag: ImagesResources.appLogo,
                child: Image.asset(
                  ImagesResources.appLogo,
                  width: 150,
                ),
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - SizesResources.s4,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: ColorsResources.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegisterView(),
                      ),
                    );
                  },
                  child: Text(LanguageResource.getText("register", context.watch<LocalProvider>().local)),
                ),
              ),
              SizedBox(height: SizesResources.s2),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - SizesResources.s4,
                height: 45,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: ColorsResources.primaryColor,
                        )),
                    foregroundColor: ColorsResources.primaryColor,
                    elevation: 0.0,
                  ),
                  onPressed: () async {
                    await CacheService().setBool("first_time", false);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashView()));
                  },
                  child: Text(LanguageResource.getText("skip", context.watch<LocalProvider>().local)),
                ),
              ),
              SizedBox(height: SizesResources.s10),
            ],
          ),
        ),
      ),
    );
  }
}
