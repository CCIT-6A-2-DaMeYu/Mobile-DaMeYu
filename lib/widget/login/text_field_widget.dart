import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? errorText;
  final bool isPassword; // Tambahkan parameter isPassword

  const TextFieldWidget({super.key, 
    required this.label,
    // required this.hintText,
    required this.onChanged,
    this.controller,
    this.textInputType,
    this.errorText,
    this.isPassword = false, // Defaultnya bukan tipe kata sandi
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  bool _obscureText = true; // Tambahkan state _obscureText

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false, // Set tipe kata sandi
      decoration: InputDecoration(
        errorText: widget.errorText,
        label: Text(
          widget.label,
          style: const TextStyle(fontSize: 20),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: widget.isPassword // Tampilkan ikon mata jika tipe password
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Mengganti visibilitas kata sandi
                  });
                },
              )
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}