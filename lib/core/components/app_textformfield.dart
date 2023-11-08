import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    FocusNode? focusNode,
    TextEditingController? editingController,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.label,
    this.autofocus = false,
    this.readonly = false,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.disabled,
    required this.formFieldKey,
    this.errorText,
    this.inputFormatters,
    this.maxLength,
    this.prefixIcon,
  })  : _focusNode = focusNode,
        _editingController = editingController;

  final FocusNode? _focusNode;
  final TextEditingController? _editingController;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? hintText;
  final Widget? label;
  final bool autofocus;
  final bool readonly;
  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormFieldState> formFieldKey;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: formFieldKey,
        readOnly: readonly,
        autofocus: autofocus,
        focusNode: _focusNode,
        controller: _editingController,
        onChanged: (e) {
          onChanged?.call(e);
          formFieldKey.currentState?.validate();
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: label,
          counterStyle: const TextStyle(color: Colors.white),
          filled: true,
          border: const OutlineInputBorder(),
          errorText: errorText,
        ),
        validator: validator,
        onFieldSubmitted: (e) {
          onFieldSubmitted?.call(e);
          formFieldKey.currentState?.validate();
        });
  }
}
