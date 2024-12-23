


import 'package:agichat/service/service_api.dart';
import 'package:agichat/service/service_app.dart';
import 'package:agichat/service/service_device_info.dart';
import 'package:agichat/service/service_firebase.dart';
import 'package:agichat/service/service_route.dart';
import 'package:agichat/utils/general_data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => ServiceApp()),
  ChangeNotifierProvider(create: (context) => ServiceDeviceInfo()),
  ChangeNotifierProvider(create: (context) => ServiceFirebase(Provider.of<ServiceDeviceInfo>(context, listen: false))),
  ChangeNotifierProvider(create: (context) => ServiceRoute(Provider.of<ServiceFirebase>(context, listen: false))),
  ChangeNotifierProvider(create: (context) => ServiceApi(GeneralData.getInstance().getAuthToken(), Provider.of<ServiceFirebase>(context, listen: false))),
];
