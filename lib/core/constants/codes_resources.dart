// const String appMainJavaScriptCode = """
//     // Hide header, footer, and shop loop head
//     document.querySelectorAll('header, footer, .shop-loop-head').forEach(el => el.style.display = 'none');

//     // Hide WhatsApp icons
//     document.querySelectorAll('.ht-ctc, .ht-ctc-chat, .ht-ctc-chat-style-2, .ctc-analytics, .ctc_wp_desktop, .ht_ctc_animation').forEach(el => el.style.display = 'none');

//     // Hide cookies banners
//     document.querySelectorAll('.wd-cookies-popup, .popup-display, div[class*="cookie"], div[class*="popup"], .cookie-notice, #cookie-law-info-bar, .cookie-banner, .js-cookie-consent, .gdpr, .gdpr-banner').forEach(el => el.style.display = 'none');

//     // Hide overlays
//     document.querySelectorAll('.modal, .modal-backdrop, .modal-overlay, .overlay, [class*="overlay"], [class*="modal"]').forEach(el => el.style.display = 'none');

//     // Hide additional fields
//     document.querySelectorAll('.no-products-footer , .wd-search-form').forEach(el => el.style.display = 'none');
//   """;

class CodesResources {
  static final String hideElementsCSS = '''
  header, 
  .header, 
  .return-to-shop,
  #header, 
  [class*="header"],
  nav:first-of-type,
  .ht-ctc, .ht-ctc-chat, .ht-ctc-chat-style-2, .ctc-analytics, .ctc_wp_desktop, .ht_ctc_animation,
  footer, 
  .footer,
  .modal,
  .modal-backdrop,
  .modal-overlay,
  .overlay,
  [class*="overlay"],
  [class*="modal"],
  .cookie-banner,
  .cookie-popup,
  #cookie-dialog,
  .wd-cookies-popup.popup-display, /* New selector added */
  #footer, 
  [class*="footer"] {
    display: none !important;
    height: 0 !important;
    min-height: 0 !important;
    padding: 0 !important;
    margin: 0 !important;
  }
  body { 
    padding-top: 0 !important; 
    margin-top: 0 !important;
  }
''';

  static final String hideElementsJS = '''
  function hideElements() {
    const elementsToHide = document.querySelectorAll('header, .header, #header, [class*="header"],
    .ht-ctc, .ht-ctc-chat, .ht-ctc-chat-style-2, .ctc-analytics, .ctc_wp_desktop, .ht_ctc_animation,
    .modal, .modal-backdrop, .modal-overlay, .overlay, [class*="overlay"], [class*="modal"],
    .return-to-shop, nav:first-of-type, footer, .footer, #footer, [class*="footer"],
    .cookie-banner, .cookie-popup, #cookie-dialog, .wd-cookies-popup.popup-display'); // New selector added
    elementsToHide.forEach(element => {
      element.style.display = 'none';
      element.style.height = '0';
      element.style.minHeight = '0';
      element.style.padding = '0';
      element.style.margin = '0';
    });
  }
  
  // Run initially
  hideElements();
  
  // Set up observer for dynamic content
  const observer = new MutationObserver(hideElements);
  observer.observe(document.body, { 
    childList: true, 
    subtree: true 
  });
''';
}
