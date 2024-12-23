import 'package:agichat/models/model_dropdown.dart';
import 'package:agichat/widgets/widget_dropdown.dart';
import 'package:flutter/material.dart';

class WidgetYearSelection extends StatefulWidget {
  final Function(ModelDropdown year) onChangedYear;
  final bool hasError;
  final String? errorLabel;
  final int? year;
  const WidgetYearSelection({super.key, required this.onChangedYear, this.hasError = false, this.errorLabel, this.year});

  @override
  State<WidgetYearSelection> createState() => _WidgetYearSelectionState();
}

class _WidgetYearSelectionState extends State<WidgetYearSelection> {
  ModelDropdown? year;

  List<ModelDropdown> years = [];

  @override
  void initState() {
    super.initState();
    years = List.generate(
      (DateTime.now().year + 1) - DateTime(1967).year,
      (index) {
        final f = ModelDropdown(id: index, title: (1967 + index).toString());
        if ((1967 + index) == widget.year) {
          year = f;
        }
        return f;
      },
    );
    years = years.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownBasic(
      selectedItem: year,
      items: years,
      title: 'Model Yılı',
      hint: 'Seçiniz',
      isRequired: true,
      onChanged: widget.onChangedYear,
      hasError: widget.hasError,
      errorLabel: widget.errorLabel,
      isActiveSort: false,
    );
  }
}
