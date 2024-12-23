// import 'package:maps_launcher/maps_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// Future<void> callPhone(String? phoneNumber) async {
//   if (phoneNumber != null) {
//     final url = 'tel:${phoneNumber.replaceAll(' ', '')}';
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrlString(url);
//     } else {
//       throw ArgumentError('Could not launch call phone $url');
//     }
//   }
// }

// Future<void> launchUrl(String url) async {
//   if (await canLaunchUrl(Uri.parse(url))) {
//     await launchUrlString(url);
//   } else {
//     throw ArgumentError('Could not launch $url');
//   }
// }

// Future<void> openMaps(num? lat, num? long) async {
//   if (lat != null && long != null) {
//     final latitude = lat.toDouble();
//     final longitude = long.toDouble();
//     await MapsLauncher.launchCoordinates(latitude, longitude);
//   }
// }
