import 'package:agichat/base/base_view_model.dart';
import 'package:agichat/service/service_api.dart';
import 'package:agichat/service/service_device_info.dart';
import 'package:agichat/service/service_firebase.dart';

class VmSplash extends ViewModelBase {
  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final ServiceDeviceInfo serviceDeviceInfo;

  VmSplash(this.serviceApi, this.serviceFirebase, this.serviceDeviceInfo) {
    init();
  }

  @override
  Future<void> init() async {
    
  }
}
