import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required FocusNode focusNode,
    required TextEditingController editingController,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.label,
    this.autofocus = false,
  })  : _focusNode = focusNode,
        _editingController = editingController;

  final FocusNode _focusNode;
  final TextEditingController _editingController;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? label;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: autofocus,
        focusNode: _focusNode,
        controller: _editingController,
        autovalidateMode: AutovalidateMode.disabled,
        decoration: InputDecoration(
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: label,
          counterStyle: const TextStyle(color: Colors.white),
          filled: true,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted);
  }
}
