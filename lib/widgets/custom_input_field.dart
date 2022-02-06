import 'package:flutter/material.dart';
import '../constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.icon,
    required this.onClick,
  }) : super(key: key);
  final String hint;
  final IconData icon;
  final void Function(String?)? onClick;

  final OutlineInputBorder border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onSaved: onClick,
        validator: (value) {
          if (value!.isEmpty) {
            switch (hint) {
              case 'Enter your email':
                return 'Enter your Email';
              case 'Enter your Name':
                return 'Enter a name';
              case 'Enter your password':
                return 'Enter a password';
              default:
                return 'Enter a value';
            }
          }
          if (hint == 'Enter your email' && !value.contains('@')) {
            return 'Enter valid email';
          }
          if (hint == 'Enter your Name' && value.length < 3) {
            return 'Enter valid Name';
          }
          if (hint == 'Enter your password' && value.length < 5) {
            return 'your password is weak';
          }
        },
        obscureText: hint == 'Enter your password' ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          filled: true,
          fillColor: kSecondaryColor,
          focusedBorder: border,
          enabledBorder: border,
          border: border,
        ),
      ),
    );
  }
}
