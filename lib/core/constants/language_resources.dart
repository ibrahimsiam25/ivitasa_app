class LanguageResource {
  LanguageResource();

  // Translation map
  static const Map<String, Map<String, String>> _translations = {
    'en': {
      //
      'home_label': 'Home',
      'cart_label': 'Cart',
      'notification_label': 'Notifications',
      'settings_label': 'Settings',
      'search_title': 'Search',
      //
      'search_in_products': 'search in products',
      'search_in_posts': 'search in posts',
      //
      'register': 'sign up / sign in',
      'skip': 'skip',
      //
      'drawer_home_label': 'Home',
      'drawer_health_questions_label': 'Health Questions',
      'drawer_vitamins_market_label': 'Vitamins Market',
      'drawer_lab_services_label': 'Lab Services',
      'drawer_doctor_consulting_label': 'Doctor Consulting',

      //
      'my_account': 'My Account',
      'about_us': 'About Uus',
      'call_us': 'Call Us',
      'contact_us': 'Contact Us',
      'privacy_policy': 'Privacy Policy',
      'terms_and_conditions': 'Terms and Conditions',
      'delivering': 'Delivery',
      'data_consent_management': 'Data Consent Management',
      'refund_returns': 'Return and Exchange Policy',
      'language': 'العربية',
      'vat_registration_number': ' VAT Registration Number',
      'vat_registration_number_subtitle': '310856310XXXXXXX',
      'certified_by': 'Certified by',
      'first_certified_by_subtitle': 'The Saudi Food and Drug Authority',
      'second_certified_by_subtitle': 'The Saudi Business Center',
      'commercial_registration_number': 'Commercial Registration Number',
      'commercial_registration_number_subtitle': '10104XXXXX',
    },
    'ar': {
      //
      'home_label': 'الرئيسية',
      'cart_label': 'عربة التسوق',
      'notification_label': 'الإشعارات',
      'settings_label': 'الإعدادات',
      'search_title': 'بحث',
      //
      'search_in_products': 'إبحث عن منتج',
      'search_in_posts': 'ابحث عن منشور',
      //
      'register': 'التسجيل / اشتراك',
      'skip': 'تخطي',
      //
      'drawer_home_label': 'الرئيسية',
      'drawer_health_questions_label': 'اسئلة عن صحتك',
      'drawer_vitamins_market_label': 'تسوق فيتامينات',
      'drawer_lab_services_label': 'خدمات المختبر',
      'drawer_doctor_consulting_label': 'استشارة الطبيب',
      //
      'my_account': 'حسابي',
      'about_us': 'من نحن',
      'call_us': 'اتصل بنا',
      'contact_us': 'تواصل معنا',
      'privacy_policy': 'سياسة الخصوصية',
      'terms_and_conditions': 'الشروط والأحكام',
      'delivering': 'الشحن والتسليم',
      'data_consent_management': 'إدارة الموافقة علي البيانات',
      'refund_returns': 'سياسة الاستبدال والاسترجاع',
      'language': 'English',
      'vat_registration_number': 'رقم التسجيل الضريبي',
      'vat_registration_number_subtitle': '310856310XXXXXX',
      'certified_by': 'موثق من',
      'first_certified_by_subtitle': 'الهيئه العامه للغذاء والدواء',
      'second_certified_by_subtitle': 'المركز السعودى للاعمال',
      'commercial_registration_number': 'رقم السجل التجاري',
      'commercial_registration_number_subtitle': '10104XXXXX',
    },
  };

  // Method to get the translated text
  static String getText(String key, String local) {
    return _translations[local]?[key] ?? key;
  }
}
