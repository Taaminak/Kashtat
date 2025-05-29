import 'package:flutter/material.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../Core/constants/ColorManager.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key, required this.values, this.onSelect})
      : super(key: key);
  final List<String> values;
  final Function? onSelect;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? dropdownValue;
  @override
  void initState() {
    setState(() {
      dropdownValue = widget.values.first;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              value: dropdownValue ?? widget.values.first,
              isExpanded: true,
              iconDisabledColor: ColorManager.orangeColor,
              iconEnabledColor: ColorManager.orangeColor,
              items:
                  widget.values.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
                widget.onSelect!;
              },
            ),
          ),
        ),
      ),
    );
  }
}
