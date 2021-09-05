import 'dart:html' as html;

class StringUtil {
  static String parseHtmlString(String htmlString) {
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }

  static String substringLt(String text, int max) {
    String result;
    if (text.length <= max) {
      result = text;
    } else {
      result = text.substring(0, max);
    }
    return result;
  }
}
