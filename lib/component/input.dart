import 'package:fani_wedding/util/XColors.dart';
import 'package:fani_wedding/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class XInputCustom extends StatefulWidget {
  const XInputCustom({
    this.labelText,
    required this.controller,
    this.value,
    this.errorText,
    Key? key,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.decoration,
    this.textAlign = TextAlign.left,
    this.style,
    this.maxLength,
    this.autofocus = false,
    this.isDense = false,
    this.inputFormatters,
    this.prefixIcon,
    this.validator,
    this.hintText,
    this.contentPadding,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.onTap,
    this.textInputAction,
    this.prefixIconWidget,
    this.onEditingComplete,
    this.helperText,
    this.maxLines,
  }) : super(key: key);

  final String? labelText;
  final TextEditingController controller;
  final String? value;
  final String? errorText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;

  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final int? maxLength;
  final bool autofocus;
  final IconData? prefixIcon;
  final Widget? prefixIconWidget;
  final Widget? suffixIcon;
  // style
  final TextAlign textAlign;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;

  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final String? helperText;

  final int? maxLines;

  final TextInputAction? textInputAction;

  @override
  State<XInputCustom> createState() => _XInputCustomState();
}

class _XInputCustomState extends State<XInputCustom> {
  String get value => widget.value ?? '';

  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(XInputCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget? _buildActions() {
      final List<Widget> actions = [];
      if (widget.obscureText) {
        actions.add(
          IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: Constants.kPaddingL,
              color: XColors.grey_60,
            ),
          ),
        );
      }

      if (widget.suffixIcon != null) {
        actions.add(widget.suffixIcon!);
      }

      if (actions.isEmpty) {
        return null;
      }
      if (actions.length == 1) {
        return actions[0];
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      );
    }

    if (widget.helperText == null) {
      return _field(_buildActions);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _field(_buildActions),
          const SizedBox(height: Constants.kPaddingXS),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.kPaddingL,
            ),
            child: Text(
              widget.helperText!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );
    }
  }

  TextFormField _field(Widget? Function() buildActions) {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      readOnly: widget.readOnly,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      style: widget.style,
      textAlign: widget.textAlign,
      obscureText: obscureText,
      maxLength: widget.maxLength,
      autofocus: widget.autofocus,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        labelStyle:
            widget.readOnly ? const TextStyle(color: XColors.grey_80) : null,
        focusedBorder: widget.readOnly
            ? Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                  borderSide: const BorderSide(
                    color: XColors.grey_40,
                  ),
                )
            : null,
        contentPadding: widget.contentPadding ??
            EdgeInsets.only(
              left: Constants.kPaddingL,
              right: widget.suffixIcon == null ? Constants.kPaddingL : 0,
            ),
        isDense: widget.isDense,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: Constants.kPaddingL,
              )
            : widget.prefixIconWidget,
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: widget.errorText,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: buildActions(),
      ),
    );
  }
}
