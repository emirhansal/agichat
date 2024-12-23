import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/service/service_api.dart';
import 'package:agichat/service/service_app.dart';
import 'package:agichat/service/service_firebase.dart';
import 'package:agichat/service/service_route.dart';
import 'package:agichat/utils/view_utils.dart';
import 'package:agichat/widgets/activity_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'base_view_model.dart';

abstract class WidgetBaseStatefull<Y extends StatefulWidget, T extends ViewModelBase> extends State<Y> with BaseView, AutomaticKeepAliveClientMixin<Y> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => router(context).hideKeyboard(context),
      child: systemBarBrightness() == null
          ? _provider()
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemBarBrightness() ?? SystemUiOverlayStyle.dark,
              child: _provider(),
            ),
    );
  }

  Widget _provider() {
    return ChangeNotifierProvider<T>(
      create: (context) => createViewModel(context),
      builder: (context, child) {
        return Consumer<T>(
          builder: (context, viewModel, child) {
            initListener(context, viewModel);
            return Stack(
              children: [
                ViewUtils.getInstance().isTablet ? buildWidgetForTablet(context, viewModel) : buildWidget(context, viewModel),
                if (viewModel.activityState == ActivityState.isLoading)
                  Positioned(
                    left: 0.0,
                    top: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: const ActivityIndicator(),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildWidget(BuildContext context, T viewModel);
  Widget buildWidgetForTablet(BuildContext context, T viewModel);
  T createViewModel(BuildContext context);
  SystemUiOverlayStyle? systemBarBrightness();
}

abstract class WidgetBase<T extends ViewModelBase> extends StatelessWidget with BaseView {
  final bool? isActiveLoadingIndicator;

  const WidgetBase({
    super.key,
    this.isActiveLoadingIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    di<ServiceApp>(context, listen: true);
    return GestureDetector(
      onTap: () => router(context).hideKeyboard(context),
      child: systemBarBrightness() == null
          ? _provider()
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemBarBrightness() ?? SystemUiOverlayStyle.dark,
              child: _provider(),
            ),
    );
  }

  Widget _provider() {
    return ChangeNotifierProvider<T>(
      create: (context) => createViewModel(context),
      builder: (context, child) {
        return Consumer<T>(
          builder: (context, viewModel, child) {
            initListener(context, viewModel);
            return Stack(
              children: [
                isTablet ? buildWidgetForTablet(context, viewModel) : buildWidget(context, viewModel),
                if (viewModel.activityState == ActivityState.isLoading)
                  Positioned(
                    left: 0.0,
                    top: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: const ActivityIndicator(),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildWidget(BuildContext context, T viewModel);
  Widget buildWidgetForTablet(BuildContext context, T viewModel);
  T createViewModel(BuildContext context);
  SystemUiOverlayStyle? systemBarBrightness();
}

mixin BaseView {
  Size size(BuildContext context) => MediaQuery.of(context).size;
  EdgeInsets systemPadding(BuildContext context) => MediaQuery.of(context).padding;
  EdgeInsets viewInsets(BuildContext context) => MediaQuery.of(context).viewInsets;
  bool keyboardVisibility(BuildContext context) => MediaQuery.of(context).viewInsets.bottom > 0;

  ServiceRoute router(context, [bool listen = false]) => Provider.of<ServiceRoute>(context, listen: listen);
  ServiceApi apiService(context, [bool listen = false]) => Provider.of<ServiceApi>(context, listen: listen);
  ServiceFirebase firebaseService(context, [bool listen = false]) => Provider.of<ServiceFirebase>(context, listen: listen);

  void requestFocus(context, focusNode) => FocusScope.of(context).requestFocus(focusNode);

  T di<T>(BuildContext context, {bool listen = false}) => Provider.of<T>(context, listen: listen);

  bool get isTablet => ViewUtils.getInstance().isTablet;

  void initListener(BuildContext context, ViewModelBase viewModel) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (!viewModel.errorObserver.hasListeners) {
      viewModel.errorObserver.addListener((String? property) {
        if (property == 'errorMessage' && viewModel.errorObserver.message.isNotEmpty) {
          //AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: viewModel.errorObserver.message));
          viewModel.errorObserver.message = '';
        }
        if (property == 'activityErrorActionState' && viewModel.errorObserver.activityErrorActionState != ActivityErrorActionState.none) {
          if (viewModel.errorObserver.activityErrorActionState == ActivityErrorActionState.logout) {
            //AlertUtils.showPlatformAlert(
            //  context,
            //  ModelAlertDialog(
            //    description: R.string.logoutConfirmation,
            //    isActiveCancelButton: true,
            //    onPressedButton: () => _logout(context),
            //  ),
            //);
          } else if (viewModel.errorObserver.activityErrorActionState == ActivityErrorActionState.directLogout) {
            _logout(context);
          }
          viewModel.errorObserver.activityErrorActionState = ActivityErrorActionState.none;
        }
      }, ['errorMessage', 'activityErrorActionState']);
    }
  }

  void _logout(BuildContext context) {
    //router(context).startNewView(route: RouteLogin(), isReplace: true, clearStack: true);
  }
}
