import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InteractivePickerSection extends StatefulWidget {
  const InteractivePickerSection({super.key});

  @override
  State<InteractivePickerSection> createState() => _InteractivePickerSectionState();
}

class _InteractivePickerSectionState extends State<InteractivePickerSection> {
  DateTime? _selectedDate;
  String _selectedRole = 'Student';

  // 1. Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 2. Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240, // Mengikut Screenshot 2026-10-31 192656.png
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  // 3. Selection Pickers: Cupertino Picker (Wheel)
  void _showCupertinoRolePicker(BuildContext context) {
    final List<String> roles = ['Student', 'Developer', 'Designer'];

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = roles[index]);
          },
          children: roles.map((role) => Center(child: Text(role))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const Divider(),
            const SizedBox(height: 8),

            Text(
              'Selected Date: ${_selectedDate != null ? _selectedDate!.toString().split(' ')[0] : 'None'}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(
              'Selected Role: $_selectedRole',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.blueAccent
              ),
            ),
            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.calendar_today, size: 18),
              label: const Text('Material Date Picker'),
            ),
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(Icons.calendar_month, size: 18),
              label: const Text('Cupertino Date Picker (Modal)'),
            ),
            const SizedBox(height: 20),


            Row(
              children: [
                const Text(
                    'Material Dropdown:  ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)
                ),
                DropdownButton<String>(
                  value: _selectedRole,
                  items: ['Student', 'Developer', 'Designer'].map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedRole = newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () => _showCupertinoRolePicker(context),
              icon: const Icon(Icons.swipe_vertical, size: 18),
              label: const Text('Cupertino Role Picker (Wheel)'),
            ),
          ],
        ),
      ),
    );
  }
}