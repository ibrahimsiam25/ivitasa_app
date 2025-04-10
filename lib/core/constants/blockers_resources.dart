import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ContentBlockersResources {
  //
  static List<ContentBlocker> homeBlockers = [
    headerFooterBlocker,
    whatsappIconBlocker,
    cookiesBlocker,
    overlaysBlocker,
  ];
  //
  static List<ContentBlocker> cartBlockers = [
    headerFooterBlocker,
    whatsappIconBlocker,
    cookiesBlocker,
    overlaysBlocker,
  ];
  //
  static List<ContentBlocker> searchBlockers = [
    headerFooterBlocker,
    whatsappIconBlocker,
    cookiesBlocker,
    overlaysBlocker,fieldsBlocker
  ];
  //
  static ContentBlocker headerFooterBlocker = ContentBlocker(
    trigger: ContentBlockerTrigger(
      urlFilter: ".*ivitasa\\.com.*",
    ),
    action: ContentBlockerAction(
      type: ContentBlockerActionType.CSS_DISPLAY_NONE,
      selector: 'header, footer, .shop-loop-head',
    ),
  );
  //
  static ContentBlocker shoppingCartBlocker = ContentBlocker(
    trigger: ContentBlockerTrigger(
      urlFilter: ".*ivitasa\\.com/cart.*",
    ),
    action: ContentBlockerAction(
      type: ContentBlockerActionType.CSS_DISPLAY_NONE,
      selector: '.return-to-shop',
    ),
  );
  //
  static ContentBlocker whatsappIconBlocker = ContentBlocker(
    trigger: ContentBlockerTrigger(
      urlFilter: ".*", // Apply to all URLs
    ),
    action: ContentBlockerAction(
      type: ContentBlockerActionType.CSS_DISPLAY_NONE,
      selector: ".ht-ctc, .ht-ctc-chat, .ht-ctc-chat-style-2, .ctc-analytics, .ctc_wp_desktop, .ht_ctc_animation",
    ),
  );
  //
  static ContentBlocker cookiesBlocker = ContentBlocker(
    trigger: ContentBlockerTrigger(
      urlFilter: ".*",
    ),
    action: ContentBlockerAction(
      type: ContentBlockerActionType.CSS_DISPLAY_NONE,
      selector: """
            .wd-cookies-popup, 
            .popup-display,
            div[class*="cookie"],
            div[class*="popup"],
            .cookie-notice,
            #cookie-law-info-bar,
            .cookie-banner,
            .js-cookie-consent,
            .gdpr,
            .gdpr-banner
          """,
    ),
  );
  //
  static ContentBlocker overlaysBlocker = ContentBlocker(
    trigger: ContentBlockerTrigger(
      urlFilter: ".*",
    ),
    action: ContentBlockerAction(
      type: ContentBlockerActionType.CSS_DISPLAY_NONE,
      selector: """
            .modal,
            .modal-backdrop,
            .modal-overlay,
            .overlay,
            [class*="overlay"],
            [class*="modal"]
          """,
    ),
  );
  //
  static ContentBlocker fieldsBlocker = ContentBlocker(
    trigger: ContentBlockerTrigger(
      urlFilter: ".*",
    ),
    action: ContentBlockerAction(
      type: ContentBlockerActionType.CSS_DISPLAY_NONE,
      selector: """.no-products-footer , .wd-search-form """,
    ),
  );
}
