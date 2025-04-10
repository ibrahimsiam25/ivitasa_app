import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class URIsResources {
  ///
  static WebUri homeUri(String local) {
    final String ar = "https://ivitasa.com/";
    final String en = "https://ivitasa.com/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri cartUri(String local) {
    final String ar = "https://ivitasa.com/cart/";
    final String en = "https://ivitasa.com/cart/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  ///
  static WebUri healthQuestions(String local) {
    final String ar = "https://ivitasa.com/توصية-مخصصة/";
    final String en = "https://ivitasa.com/questioner-drived/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri vitaminesMarket(String local) {
    final String ar = "https://ivitasa.com/categories/";
    final String en = "https://ivitasa.com/categories/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri labServices(String local) {
    final String ar = "https://ivitasa.com/التحاليل-المتخصصة/";
    final String en = "https://ivitasa.com/التحاليل-المتخصصة/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri doctorConsulting(String local) {
    final String ar = "https://ivitasa.com/الإستشارات-اللإفتراضية/";
    final String en = "https://ivitasa.com/virtual-consultations/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  ///
  static WebUri myAccountUri(String local) {
    final String ar = "https://ivitasa.com/my-account/";
    final String en = "https://ivitasa.com/my-account/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri callUsUri(String local) {
    final String ar = "https://ivitasa.com/contacts/";
    final String en = "https://ivitasa.com/our-contacts/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri privacyAndPolicyUri(String local) {
    final String ar = "https://ivitasa.com/privacy-policy/";
    final String en = "https://ivitasa.com/privacy-policy/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri termsAndConditions(String local) {
    final String ar = "https://ivitasa.com/الشروط-والاحكام/";
    final String en = "https://ivitasa.com/terms-and-conditions/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri aboutUs(String local) {
    final String ar = "https://ivitasa.com/about/";
    final String en = "https://ivitasa.com/about/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri refundReturns(String local) {
    final String ar = "https://ivitasa.com/refund_returns/";
    final String en = "https://ivitasa.com/refund_returns/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri delivering(String local) {
    final String ar = "https://ivitasa.com/التسليم/";
    final String en = "https://ivitasa.com/delivery/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  static WebUri dataConsentManagement(String local) {
    final String ar = "https://ivitasa.com/إدارة-الموافقة-علي-البيانات/";
    final String en = "https://ivitasa.com/data-consent-management/?lang=en";
    if (local == 'ar') {
      return WebUri(ar);
    } else {
      return WebUri(en);
    }
  }

  ///
  static WebUri search(
    String local,
    String keywords,
    String postType,
  ) {
    return WebUri(
      "https://ivitasa.com/?s=$keywords&post_type=$postType&lang=$local",
    );
  }
}
