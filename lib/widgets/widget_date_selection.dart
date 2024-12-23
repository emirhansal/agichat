import 'package:agichat/extensions/extension_date.dart';
import 'package:agichat/models/model_alert_dialog.dart';
import 'package:agichat/resources/_r.dart';
import 'package:agichat/utils/alert_utils.dart';
import 'package:agichat/widgets/widget_textfield.dart';
import 'package:agichat/widgets/widgets_text.dart';
import 'package:flutter/material.dart';

class WidgetDateSelection extends StatefulWidget {
  final String title;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Color bgColor;
  final Color titleColor;
  final Function(DateTime)? onChangedStartDate;
  final Function(DateTime)? onChangedEndDate;
  final bool isPreview;
  final String? startDateErrorText;
  final String? endDateErrorText;

  const WidgetDateSelection({
    super.key,
    required this.title,
    this.selectedStartDate,
    this.selectedEndDate,
    required this.bgColor,
    required this.titleColor,
    this.onChangedStartDate,
    this.onChangedEndDate,
    this.isPreview = false,
    this.startDateErrorText,
    this.endDateErrorText,
  });

  @override
  State<WidgetDateSelection> createState() => _WidgetDateSelectionState();
}

class _WidgetDateSelectionState extends State<WidgetDateSelection> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.selectedStartDate;
    endDate = widget.selectedEndDate;
  }

  void onChangedStartDate(DateTime date) {
    startDate = date;
    endDate = null;
    setState(() {});
    if (widget.onChangedStartDate != null) {
      widget.onChangedStartDate!(date);
    }
  }

  void onChangedEndDate(DateTime date) {
    endDate = date;
    setState(() {});
    if (widget.onChangedEndDate != null) {
      widget.onChangedEndDate!(date);
    }
  }

  Future<void> selectStartDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: 365 * -10)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      onChangedStartDate(date);
    }
  }

  Future<void> selectEndDate() async {
    if (startDate == null) {
      AlertUtils.showPlatformAlert(context, ModelAlertDialog(description: 'Lütfen önce başlangıç tarihi seçin'));
      return;
    }
    var date = await showDatePicker(
      context: context,
      initialDate: startDate!.add(const Duration(days: 366)),
      firstDate: startDate!,
      lastDate: startDate!.add(const Duration(days: 365 * 10)),
    );
    if (date != null && date.isAfter(startDate!)) {
      onChangedEndDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: widget.bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBasic(
            text: widget.title,
            color: widget.titleColor,
            fontFamily: R.fonts.displayBold,
            fontSize: 16.0,
          ),
          const SizedBox(height: 10.0),
          if (!widget.isPreview) ..._getSelectionField(context) else ..._getPreview(context),
        ],
      ),
    );
  }

  List<Widget> _getSelectionField(BuildContext context) {
    return [
      GestureDetector(
        onTap: () => selectStartDate(),
        child: TextFieldBasic(
          title: 'Başlangıç Tarihi',
          hintText: startDate == null ? 'Seçiniz' : startDate?.dayMonthNameAndYear(),
          suffixIcon: Icon(Icons.date_range, color: R.color.primary),
          enabled: false,
          hasError: widget.startDateErrorText != null,
          errorLabel: widget.startDateErrorText,
        ),
      ),
      const SizedBox(height: 15.0),
      GestureDetector(
        onTap: () => selectEndDate(),
        child: TextFieldBasic(
          title: 'Bitiş Tarihi',
          hintText: endDate == null ? 'Seçiniz' : endDate.dayMonthNameAndYear(),
          suffixIcon: Icon(Icons.date_range, color: R.color.primary),
          enabled: false,
          hasError: widget.endDateErrorText != null,
          errorLabel: widget.endDateErrorText,
        ),
      ),
    ];
  }

  List<Widget> _getPreview(BuildContext context) {
    return [
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                text: 'Başlangıç Tarihi',
                color: R.color.smoke,
                fontFamily: R.fonts.displayMedium,
                fontSize: 12.0,
              ),
              const SizedBox(height: 5.0),
              TextBasic(
                text: widget.selectedStartDate.dayMonthNameAndYear(),
                color: R.color.secondaryDark,
                fontFamily: R.fonts.displayBold,
                fontSize: 14.0,
              ),
            ],
          ),
          Expanded(child: Container()),
          Icon(Icons.arrow_forward_outlined, color: R.color.smoke),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                text: 'Bitiş Tarihi',
                color: R.color.smoke,
                fontFamily: R.fonts.displayMedium,
                fontSize: 12.0,
              ),
              const SizedBox(height: 5.0),
              TextBasic(
                text: widget.selectedEndDate.dayMonthNameAndYear(),
                color: R.color.secondaryDark,
                fontFamily: R.fonts.displayBold,
                fontSize: 14.0,
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
