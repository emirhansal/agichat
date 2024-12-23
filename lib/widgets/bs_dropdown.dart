import 'package:agichat/base/base_view.dart';
import 'package:agichat/models/model_base_dropdown.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/widgets/widget_button.dart';
import 'package:agichat/widgets/widget_scroll.dart';
import 'package:agichat/widgets/widget_textfield.dart';
import 'package:agichat/widgets/widgets_text.dart';
import 'package:flutter/material.dart';

class BottomSheetDropdown<T extends BaseDropdown> extends StatefulWidget {
  final String? title;
  final List<T> list;
  final T? selectedItem;
  final Function(T) onChanged;
  final bool isActiveSort;
  const BottomSheetDropdown({super.key, this.title, required this.list, this.selectedItem, required this.onChanged, this.isActiveSort = true});

  @override
  State<BottomSheetDropdown> createState() => _BottomSheetDropdownState<T>();
}

class _BottomSheetDropdownState<T extends BaseDropdown> extends State<BottomSheetDropdown<T>> with BaseView {
  List<T> list = [];
  List<T> _filtredList = [];
  T? selectedItem;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    list = widget.list;
    _filtredList = widget.list;
    selectedItem = widget.selectedItem;
    filterList();

    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        _filtredList = list;
        setState(() {});
        filterList();
      } else {
        _filtredList = list.where((element) => element.dropdownTitle.toLowerCase().contains(searchController.text.toLowerCase())).toList();
        filterList();
        setState(() {});
      }
    });
  }

  void filterList() {
    if (widget.isActiveSort) {
      _filtredList.sort((a, b) => a.dropdownTitle.compareTo(b.dropdownTitle));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size(context).width,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: R.color.grayLight.withOpacity(0.2)))),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.clear, color: R.color.transparent),
              Expanded(
                child: TextBasic(
                  text: widget.title ?? '',
                  color: R.color.black,
                  fontFamily: R.fonts.displayBold,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.clear, color: R.color.grayLight),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(18),
          child: TextFieldBasic(
            controller: searchController,
            hintText: 'Aramak için bir şeyler girin',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
          child: ScrollWithNoGlowWidget(
            child: Wrap(
              children: List.generate(
                _filtredList.length,
                (index) {
                  var item = _filtredList[index];
                  return DropdownButtonBasic<T>(
                    item: item,
                    itemTitle: item.dropdownTitle,
                    isSelected: selectedItem?.dropdownId == item.dropdownId,
                    isActiveBorder: index != _filtredList.length - 1,
                    onSelected: (v) {
                      Navigator.pop(context);
                      widget.onChanged(v);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
