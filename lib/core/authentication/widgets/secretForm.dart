import 'package:flutter/material.dart';

class SecretForm extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextEditingController? parent_controller;
  const SecretForm({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.textInputAction,
    required this.parent_controller,
  });

  @override
  State<SecretForm> createState() => _SecretFormState();
}

class _SecretFormState extends State<SecretForm> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscure,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: widget.hint,
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        ),
      ),
      onChanged: (value) {
        setState(() {
          value = widget.controller.text;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        if (widget.label == 'Confirm Password' &&
            widget.parent_controller != null) {
              if (value != widget.parent_controller!.text) {
                return 'Passwords do not match';
              }
              return null;
        }
        return null;
      },
    );
  }
}
