import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/user/provider/directory_provider.dart';

class DropDownButtonCustom<T> extends StatelessWidget {
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String hintText;
  final List<T> items;
  final String Function(T) valueToString;

  const DropDownButtonCustom({
    required this.value,
    required this.hintText,
    required this.onChanged,
    required this.items,
    required this.valueToString,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      menuMaxHeight: MediaQuery.of(context).size.height * 3 / 5,
      value: value,
      isExpanded: true,
      hint: Text(hintText),
      items: items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(valueToString(value)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class DropDownButtonSearchCustom<T> extends StatelessWidget {
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String hintText;
  final List<T> items;
  final String Function(T) valueToString;
  final TextEditingController textEditingController;
  final double buttonSize;
  final double dropSize;

  const DropDownButtonSearchCustom({
    required this.value,
    required this.hintText,
    required this.onChanged,
    required this.items,
    required this.valueToString,
    required this.textEditingController,
    required this.buttonSize,
    required this.dropSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(

      underline: null,
      isExpanded: true,
            hint: Text(
        hintText,
        style: TextStyle(
          // fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  valueToString(item),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      value: value,
      onChanged: onChanged, //value 변환 해줘야 함.
      buttonStyleData: ButtonStyleData(
        height: 40,
        width: buttonSize,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.0,color: Color(0xFFBDBDBD)))
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        width: dropSize,
        maxHeight: 400,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: kMinInteractiveDimension,
      ),
      dropdownSearchData: DropdownSearchData(
        searchController: textEditingController,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: textEditingController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search ...',
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return item.value
              .toString()
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        },
      ),
      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          textEditingController.clear();
        }
      },
    );
  }
}
