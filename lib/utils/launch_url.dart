import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  LaunchUrl._();

  static Future<dynamic> url(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<dynamic> map(String address) async {
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$address';

    await launchUrl(Uri.parse(googleUrl));
  }

  static Future<dynamic> mail(String emailto) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailto,
    );
    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch $emailto');
    }
  }

  static Future<dynamic> phone(String phone) async {
    final uri = Uri(
      scheme: 'tel',
      path: '+84${phone.substring(1, phone.length)}',
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  static Future<dynamic> makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    await launchUrl(Uri.parse(url));
  }

  static Future<dynamic> openZalo() async {
    const url = 'https://zalo.me/g/hxthgr866';
    await launchUrl(Uri.parse(url));
  }

  static Future<dynamic> openZalo2() async {
    await launchUrl(
      Uri.parse('https://zalo.me/g/hxthgr866'),
    );
  }

  static Future<dynamic> sms(String phone, {String? content}) async {
    final uri = Uri(
      scheme: 'sms',
      path: '+84339604406',
      queryParameters: content == null
          ? null
          : <String, String>{
              'body': Uri.encodeComponent(content),
            },
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  static Future<dynamic> openMessenger({
    required String idFacebook,
  }) async {
    await launchUrl(
      Uri.parse('https://m.me/$idFacebook'),
      mode: LaunchMode.externalApplication,
    );
  }

  static Future<dynamic> openFaceBook({
    required String idFacebook,
  }) async {
    await launchUrl(
      Uri.parse('https://www.facebook.com/'),
      mode: LaunchMode.externalApplication,
    );
  }
}
