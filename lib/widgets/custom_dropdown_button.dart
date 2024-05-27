import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  const CustomDropdownButton(
      {super.key, this.value, required this.items, required this.onChanged});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: _selectedValue,
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          widget.onChanged(newValue);
        });
  }
}
