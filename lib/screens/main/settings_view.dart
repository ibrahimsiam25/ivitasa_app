import 'package:flutter/material.dart';
import 'package:ivitasa_app/app_root.dart';
import 'package:ivitasa_app/core/constants/blockers_resources.dart';
import 'package:ivitasa_app/core/constants/colors_resources.dart';
import 'package:ivitasa_app/core/constants/links_resources.dart';
import 'package:ivitasa_app/core/constants/sizes_resources.dart';
import 'package:ivitasa_app/main.dart';
import 'package:ivitasa_app/screens/pages_holder_view.dart';
import 'package:ivitasa_app/screens/start/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/images_resources.dart';
import '../../core/constants/language_resources.dart';
import '../../services/cache_service.dart';
import '../../states/local/local_provider.dart';
import '../web/in_app_web_viewer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with AutomaticKeepAliveClientMixin<SettingsView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(ImagesResources.inAppLogo, height: 25),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingTileWidget(
              child: Text(LanguageResource.getText("my_account", context.watch<LocalProvider>().local)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppWebViewerView(
                      uri: URIsResources.myAccountUri(context.watch<LocalProvider>().local),
                    ),
                  ),
                );
              },
            ),
            SettingTileWidget(
              child: Text(LanguageResource.getText("about_us", context.watch<LocalProvider>().local)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppWebViewerView(
                      uri: URIsResources.aboutUs(context.watch<LocalProvider>().local),
                    ),
                  ),
                );
              },
            ),
            SettingTileWidget(
              child: Text(LanguageResource.getText("call_us", context.watch<LocalProvider>().local)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppWebViewerView(
                      uri: URIsResources.callUsUri(context.watch<LocalProvider>().local),
                    ),
                  ),
                );
              },
            ),
            SettingTileWidget(
              child: Text(LanguageResource.getText("privacy_policy", context.watch<LocalProvider>().local)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppWebViewerView(
                      uri: URIsResources.privacyAndPolicyUri(context.watch<LocalProvider>().local),
                    ),
                  ),
                );
              },
            ),
            SettingTileWidget(
              child: Text(LanguageResource.getText("refund_returns", context.watch<LocalProvider>().local)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppWebViewerView(
                      uri: URIsResources.refundReturns(context.watch<LocalProvider>().local),
                    ),
                  ),
                );
              },
            ),
            SettingTileWidget(
              child: Text(LanguageResource.getText("delivering", context.watch<LocalProvider>().local)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppWebViewerView(
                      uri: URIsResources.delivering(context.watch<LocalProvider>().local),
                    ),
                  ),
                );
              },
            ),
            SettingTileWidget(
              child: Text(LanguageResource.getText("data_consent_management", context.watch<LocalProvider>().local)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppWebViewerView(
                      uri: URIsResources.dataConsentManagement(context.watch<LocalProvider>().local),
                    ),
                  ),
                );
              },
            ),
            SettingTileWidget(
              child: Row(
                children: [
                  isAppEnglish ? Image.asset(ImagesResources.arabicIcon, width: 20) : Image.asset(ImagesResources.englishIcon, width: 20),
                  SizedBox(width: SizesResources.s2),
                  Text(LanguageResource.getText("language", context.watch<LocalProvider>().local))
                ],
              ),
              onTap: () async {
                await CacheService().setBool("is_english", false);
                if (context.mounted) {
                  context.read<LocalProvider>().toggleLanguage();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashView()));
                }
              },
            ),
            SizedBox(height: SizesResources.s2),
            ////
            Row(
              children: [
                Expanded(
                  child: RegisterInfoTileWidget(
                    title: LanguageResource.getText("vat_registration_number", context.watch<LocalProvider>().local),
                    subtitle: LanguageResource.getText("vat_registration_number_subtitle", context.watch<LocalProvider>().local),
                    image: ImagesResources.vatRegistrationNumber,
                  ),
                ),
                Expanded(
                  child: RegisterInfoTileWidget(
                    title: LanguageResource.getText("certified_by", context.watch<LocalProvider>().local),
                    subtitle: LanguageResource.getText("first_certified_by_subtitle", context.watch<LocalProvider>().local),
                    image: ImagesResources.firstCertifiedBy,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: RegisterInfoTileWidget(
                    title: LanguageResource.getText("certified_by", context.watch<LocalProvider>().local),
                    subtitle: LanguageResource.getText("second_certified_by_subtitle", context.watch<LocalProvider>().local),
                    image: ImagesResources.secondCertifiedBy,
                  ),
                ),
                Expanded(
                  child: RegisterInfoTileWidget(
                    title: LanguageResource.getText("commercial_registration_number", context.watch<LocalProvider>().local),
                    subtitle: LanguageResource.getText("commercial_registration_number_subtitle", context.watch<LocalProvider>().local),
                    image: ImagesResources.commercialRegistrationNumber,
                  ),
                ),
              ],
            ),
            SizedBox(height: SizesResources.s2),

            ///
            Divider(
              color: Colors.black12,
            ),
            SizedBox(height: SizesResources.s4),
            Text(LanguageResource.getText("contact_us", context.watch<LocalProvider>().local)),
            SizedBox(height: SizesResources.s2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SizesResources.s6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContactUsCircleWidget(
                        title: "Facebook",
                        subTitle: "",
                        imagePath: ImagesResources.facebookIcon,
                        uri: Uri.parse("https://www.facebook.com/people/ivita-ksa/61572541312997/"),
                      ),
                      ContactUsCircleWidget(
                        title: "Linkedin",
                        subTitle: "",
                        imagePath: ImagesResources.linkedinIcon,
                        uri: Uri.parse("https://www.linkedin.com/company/ivita-medical-co/"),
                      ),
                      ContactUsCircleWidget(
                        title: "Snapchat",
                        subTitle: "",
                        imagePath: ImagesResources.snapchatIcon,
                        uri: Uri.parse("https://www.snapchat.com/add/ivita.ksa?sender_web_id=eb3321a3-59bf-4227-b52f-e965e9a855be&device_type=desktop&is_copy_url=true"),
                      ),
                      ContactUsCircleWidget(
                        title: "Tiktok",
                        subTitle: "",
                        imagePath: ImagesResources.tiktokIcon,
                        uri: Uri.parse("https://www.tiktok.com/@ivitaksa?is_from_webapp=1&sender_device=pc"),
                      ),
                      ContactUsCircleWidget(
                        title: "Youtube",
                        subTitle: "",
                        imagePath: ImagesResources.youtubeIcon,
                        uri: Uri.parse("http://www.youtube.com/@ivitaKsa"),
                      ),
                    ],
                  ),
 SizedBox(height:10
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContactUsCircleWidget(
                        title: "Email",
                        subTitle: "info@ivitasa.com",
                        imagePath: ImagesResources.mailIcon,
                        uri: Uri.parse("mailto:info@ivitasa.com"),
                      ),
                      ContactUsCircleWidget(
                        title: "Phone",
                        subTitle: "+966582802526",
                        imagePath: ImagesResources.phoneIcon,
                        uri: Uri.parse("tel:+966582802526"),
                      ),
                      ContactUsCircleWidget(
                        title: "WhatsApp",
                        subTitle: "+966582802526",
                        imagePath: ImagesResources.whatsappIcon,
                        uri: Uri.parse("https://wa.me/+966582802526"),
                      ),
                      ContactUsCircleWidget(
                        title: "Instagram",
                        subTitle: "ivitasa",
                        imagePath: ImagesResources.instagramIcon,
                        uri: Uri.parse("https://www.instagram.com/ivitaksa/?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw%3D%3D#"),
                      ),
                      ContactUsCircleWidget(
                        title: "Telegram",
                        subTitle: "ivitasa",
                        imagePath: ImagesResources.telegramIcon,
                        uri: Uri.parse("https://t.me/ivitasa"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ContactUsCircleWidget extends StatelessWidget {
  const ContactUsCircleWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.uri,
  });
  final String title, subTitle, imagePath;
  final Uri uri;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width / 10,
          height: MediaQuery.sizeOf(context).width / 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorsResources.bordersColor,
              width: 0.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(180),
            child: InkWell(
              borderRadius: BorderRadius.circular(180),
              onTap: () async {
                await launchUrl(uri);
              },
              child: Padding(
                padding: EdgeInsets.all(SizesResources.s2),
                child: Center(
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: Image.asset(
                      imagePath,
                      color: Color(0xff1D79B1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: SizesResources.s1),
        Text(
          title,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
        // Text(
        //   subTitle,
        //   textDirection: TextDirection.ltr,
        //   style: TextStyle(
        //     fontSize: 9,
        //     color: Colors.black54,
        //   ),
        // ),
      ],
    );
  }
}

class SettingTileWidget extends StatelessWidget {
  const SettingTileWidget({
    super.key,
    required this.child,
    required this.onTap,
  });
  final Widget child;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  child,
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  ),
                ],
              ),
            ),

            ///
            Divider(
              height: 0,
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterInfoTileWidget extends StatelessWidget {
  const RegisterInfoTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });
  final String title, subtitle, image;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      image,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
