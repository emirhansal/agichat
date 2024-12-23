import 'package:agichat/base/base_view.dart';
import 'package:agichat/enums/enum_app.dart';
import 'package:agichat/models/model_base_dropdown.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/widgets/activity_indicator.dart';
import 'package:agichat/widgets/bs_dropdown.dart';
import 'package:flutter/material.dart';
import 'widget_textfield.dart';

class DropdownBasic<T extends BaseDropdown> extends StatefulWidget {
  final T? selectedItem;
  final List<T>? items;
  final String? title;
  final String? hint;
  final Future<dynamic>? callback;
  final String? errorLabel;
  final bool hasError;
  final bool isRequired;
  final Function()? onRemove;
  final Function(T) onChanged;
  final Function()? customOnTap;
  final bool isActiveSort;
  const DropdownBasic({
    super.key,
    this.selectedItem,
    this.items,
    this.callback,
    this.title,
    this.hint,
    this.errorLabel,
    this.hasError = false,
    this.isRequired = false,
    this.onRemove,
    required this.onChanged,
    this.customOnTap,
    this.isActiveSort = true,
  });

  @override
  State<DropdownBasic> createState() => _DropdownBasicState<T>();
}

class _DropdownBasicState<T extends BaseDropdown> extends State<DropdownBasic<T>> with BaseView {
  final TextEditingController itemController = TextEditingController();
  ActivityState loadingState = ActivityState.isLoaded;
  T? selectedItem;
  List<T> items = [];

  @override
  void initState() {
    super.initState();
    if (widget.selectedItem != null) {
      selectedItem = widget.selectedItem;
      itemController.text = widget.selectedItem?.dropdownTitle ?? '';
    }
    if (widget.items != null) {
      items = widget.items!;
    } else if (widget.callback != null) {
      initList();
    }
  }

  Future<void> initList() async {
    selectedItem = widget.selectedItem;
    itemController.text = widget.selectedItem?.dropdownTitle ?? '';
    setLoadingState(ActivityState.isLoading);
    if (widget.callback != null) {
      await widget.callback!.then(
        (response) {
          items = (response.data).where((element) {
            var deletedAt;
            try {
              deletedAt = element.deletedAt;
            } catch (e) {}
            return deletedAt == null;
          }).toList();
          setLoadingState(ActivityState.isLoaded);
        },
        onError: (error) {
          setLoadingState(ActivityState.isError);
        },
      );
    }
  }

  void onChanged(T item) {
    selectedItem = item;
    itemController.text = item.dropdownTitle.replaceAll('&amp;', '&');
    widget.onChanged(item);
    if (widget.key == null) {
      setState(() {});
    }
  }

  void setLoadingState(ActivityState state) {
    loadingState = state;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.customOnTap ?? (loadingState == ActivityState.isLoaded ? () => showBottomSheet() : null),
            child: TextFieldBasic(
              enabled: false,
              controller: itemController,
              title: widget.title,
              hintText: widget.hint,
              errorLabel: widget.errorLabel,
              hasError: widget.hasError,
              isRequired: widget.isRequired,
              suffixIcon: loadingState == ActivityState.isLoaded
                  ? Icon(Icons.keyboard_arrow_down, color: R.color.gray)
                  : loadingState == ActivityState.isLoading
                      ? const IOSIndicator()
                      : Icon(Icons.error, color: R.color.candy),
              prefixIcon: widget.callback == null ? null : Icon(Icons.search, color: R.color.gray),
            ),
          ),
        ),
        if (widget.onRemove != null && selectedItem != null)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              onPressed: () {
                selectedItem = null;
                itemController.text = '';
                setState(() {});
                widget.onRemove!();
              },
              icon: Icon(Icons.clear, color: R.color.gray),
            ),
          ),
      ],
    );
  }

  void showBottomSheet() {
    router(context).showBaseBottomSheet(
      context,
      BottomSheetDropdown<T>(
        title: widget.title,
        onChanged: onChanged,
        list: items,
        selectedItem: selectedItem,
        isActiveSort: widget.isActiveSort,
      ),
    );
  }
}
