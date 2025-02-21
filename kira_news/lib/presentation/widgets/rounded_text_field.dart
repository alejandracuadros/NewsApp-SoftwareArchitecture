import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../core/theme/app_colors.dart';
import 'custom_text_field_error_message.dart';

class RoundedTextField extends StatefulWidget {
  const RoundedTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.isObscure = false,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.errorMessage,
    this.isFieldOptional = false,
    this.borderColor = AppColors.border,
    this.suffix,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.isEnabled = true,
    this.prefixIcon,
    this.backgroundColor = Colors.white,
    this.focusNode,
    this.onTap,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onChanged,
    this.autofocus = false,
    this.inputFormatters,
    this.addClearIcon = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final bool isObscure;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final List<dynamic>? errorMessage;
  final bool isFieldOptional;
  final Color borderColor;
  final Widget? suffix;
  final AutovalidateMode autovalidateMode;
  final bool isEnabled;
  final IconData? prefixIcon;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  final void Function(String)? onChanged;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final bool addClearIcon;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool showText = false;

  bool showClearIcon = false;

  late final StreamController<List<dynamic>?> errorMessageStreamController;

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(_checkClearIconState);
    widget.focusNode?.addListener(_checkClearIconState);

    errorMessageStreamController = StreamController<List<dynamic>?>()
      ..add(null);
  }

  @override
  void dispose() {
    errorMessageStreamController.close();
    widget.controller?.removeListener(_checkClearIconState);
    widget.focusNode?.removeListener(_checkClearIconState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    errorMessageStreamController.add(widget.errorMessage);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          enabled: widget.isEnabled,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          inputFormatters: widget.inputFormatters,
          autovalidateMode: widget.autovalidateMode,
          obscureText: widget.isObscure != showText,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          style: AppTextStyles.styleW600.copyWith(
            fontSize: 16.sp,
            color: AppColors.darkBlue,
          ),
          autofocus: widget.autofocus,
          keyboardType:
              (widget.keyboardType == TextInputType.number && Platform.isIOS)
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : widget.keyboardType,
          validator: _onValidate,
          decoration: InputDecoration(
            fillColor: widget.backgroundColor,
            filled: true,
            contentPadding: EdgeInsets.only(
              left: 18,
              right: widget.prefixIcon == null ? 18 : 0,
            ).r,
            hintText: widget.hintText,
            errorStyle: const TextStyle(height: 0),
            hintStyle: AppTextStyles.styleW600.copyWith(
              fontSize: 16.sp,
              color: const Color(0xff9A9A9A),
            ),
            // suffixIconConstraints:
            //     const BoxConstraints(minWidth: 48, minHeight: 48).r,
            suffixIcon: showClearIcon
                ? clearTextIcon()
                : (() {
                    if (widget.suffix != null) {
                      return widget.suffix;
                    }

                    if (widget.isObscure) {
                      return IconButton(
                        splashRadius: 20.r,
                        onPressed: () => setState(() {
                          showText = !showText;
                        }),
                        icon: Icon(
                            showText ? Icons.visibility : Icons.visibility_off),
                      );
                    }
                    return null;
                  }()),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon!,
                  )
                : null,
            // prefixIconConstraints:
            //     const BoxConstraints(minWidth: 48, minHeight: 48).r,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: widget.borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: widget.borderColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: widget.borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.darkBlue, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: widget.borderColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
          ),
        ),
        CustomTextFieldErrorMessage(
          streamController: errorMessageStreamController,
        )
      ],
    );
  }

  void _checkClearIconState() {
    if (widget.focusNode?.hasFocus == true &&
        widget.controller?.text.trim().isNotEmpty == true &&
        widget.addClearIcon) {
      if (showClearIcon == false) {
        setState(() {
          showClearIcon = true;
        });
      }
    } else {
      if (showClearIcon == true) {
        setState(() {
          showClearIcon = false;
        });
      }
    }
  }

  Widget clearTextIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        widget.controller?.clear();
      },
      icon: const Icon(Icons.cancel),
    );
  }

  String? _onValidate(String? value) {
    if (widget.isFieldOptional) {
      return null;
    }
    if (widget.errorMessage != null) {
      errorMessageStreamController.add(widget.errorMessage!);
    } else if (value == null || value.isEmpty) {
      errorMessageStreamController.add(['Required']);
      return '';
    } else {
      errorMessageStreamController.add(null);
    }

    return null;
  }
}
