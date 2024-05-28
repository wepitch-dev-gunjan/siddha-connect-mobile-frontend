import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// //  Selected Date
Future selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
  );

  if (pickedDate != null) {
    final String formattedDate =
        "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    return formattedDate;
  }
}

// //  Selected Time
Future selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(primaryColor: Colors.green),
        child: child!,
      );
    },
  );

  if (pickedTime != null && context.mounted) {
    return pickedTime.format(context);
  }
}

EdgeInsets contentPadding =
    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0);

class TxtField extends StatelessWidget {
  // // TextFormField
  final String? headTxt, labelText, hintText, errorText, initialValue;
  final TextEditingController? controller;
  final int? maxLines, minLines, maxLength;
  final dynamic onTap;
  final dynamic onTapOutside;
  final double? cursorHeight;
  final Function? validator;
  final BoxDecoration? decoration;
  final Function(String?)? onSaved, onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon, prefixIcon;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;

  final bool? readOnly, filled, border;
  final Color? fillColor;
  final TextStyle? style;
  final bool? enabled;
  final InputBorder? enabledBorder;

  const TxtField(
      {super.key,
      this.headTxt,
      this.enabled,
      this.cursorHeight,
      this.contentPadding,
      this.textAlign,
      this.decoration,
      this.controller,
      this.labelText,
      this.errorText,
      this.inputFormatters,
      this.keyboardType,
      this.initialValue,
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.onSaved,
      this.onChanged,
      this.readOnly,
      this.onTap,
      this.suffixIcon,
      this.prefixIcon,
      this.hintText,
      this.border = true,
      this.filled,
      this.fillColor,
      this.validator,
      this.style,
      this.onTapOutside,
      this.enabledBorder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enabled ?? true,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        onTap: onTap,
        initialValue: initialValue,
        style: style ??
            const TextStyle(fontSize: 16.0, height: 1.5, color: Colors.black87),
        textAlign: textAlign ?? TextAlign.start,
        onChanged: onChanged,
        cursorHeight: cursorHeight ?? 25.0,
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        controller: controller,
        onSaved: onSaved,
        keyboardType: keyboardType,
        validator: validator != null ? (value) => validator!(value) : null,
        readOnly: readOnly ?? false,
        scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
            fillColor: fillColor ?? const Color(0XFFfafafa),
            filled: filled ?? true,
            errorStyle: const TextStyle(color: Colors.red),
            errorText: errorText,
            counter: const Offstage(),
            labelStyle: const TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
            labelText: labelText,
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xff1F0A68), width: 1)),
            border: border == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: Colors.amber, width: 0.5))
                : null,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding));
  }
}

// ! Validation For  TextFormField
validateField(String value) {
  if (value.isEmpty) {
    return 'Field is Required.';
  } else {
    return null;
  }
}

validateName(String value) {
  if (value.isEmpty) {
    return 'Name is Required.';
  } else {
    return null;
  }
}

validateMobile(String value) {
  if (value.isEmpty) {
    return 'Mobile Number is Required.';
  } else if (value.length < 10) {
    return 'Mobile Number required at least 10 numbers';
  } else if (value.length > 11) {
    return 'Mobile Number required 10 numbers';
  } else {
    return null;
  }
}

validateOTP(String value) {
  if (value.isEmpty) {
    return 'OTP is Required.';
  } else if (value.length < 6) {
    return 'OTP required at least 6 numbers';
  } else if (value.length > 6) {
    return 'OTP required at most 6 numbers';
  } else {
    return null;
  }
}

validateEmail(String value) {
  bool validEmail = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (value.isEmpty) {
    return 'Email is Required.';
  } else if (validEmail == false) {
    return 'Invalid email address';
  } else {
    return null;
  }
}

validateRequired({required var value, String message = ''}) {
  if (value.isEmpty) {
    return "$message is Required";
  }

  return null;
}
