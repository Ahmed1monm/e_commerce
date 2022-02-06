import 'dart:ui';

import 'package:e_commerce/provider/admin_mode.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/register_screen.dart';
import 'package:e_commerce/servises/auth.dart';
import 'package:e_commerce/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routName = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String _adminPassword = 'Admin1234';

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? password;
  String? email;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final _adminModel = Provider.of<AdminMode>(context, listen: false);

    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 100),
            alignment: Alignment.center,
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Image.asset("assets/images/icons/cart.png"),
                  const Text('Buy now',
                      style: TextStyle(
                          fontFamily: 'Corinthia',
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomTextField(
                      onClick: (value) {
                        email = value;
                      },
                      hint: 'Enter your email',
                      icon: Icons.email_rounded),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                      onClick: (value) {
                        password = value;
                      },
                      hint: 'Enter your password',
                      icon: Icons.lock),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Builder(
                    builder: (context) => MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      color: Colors.black,
                      onPressed: () {
                        _validate();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have account?',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Register.routName);
                        },
                        child: const Text(
                          'Register  ',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Text(
                            'Admin mode',
                            style: TextStyle(
                                color: _adminModel.isAdmin
                                    ? Colors.white
                                    : kSecondaryColor),
                          ),
                          onTap: () {
                            _adminModel.changeAdminMode(true);
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          child: Text(
                            'User mode',
                            style: TextStyle(
                                color: _adminModel.isAdmin
                                    ? kSecondaryColor
                                    : Colors.white),
                          ),
                          onTap: () {
                            _adminModel.changeAdminMode(false);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }

  _validate() async {
    final _modelHud = Provider.of<ModelHud>(context, listen: false);
    final _adminModel = Provider.of<AdminMode>(context, listen: false);
    _modelHud.loadingChange(true);

    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      if (_adminModel.isAdmin && password == _adminPassword) {
        try {
          await MyAuth().sinIn(email!, password!);
          _modelHud.loadingChange(false);
        } catch (e) {
          String? message = e.toString();
          _modelHud.loadingChange(false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
          // ignore: avoid_print
          print(e.toString());
        }
      } else if (!_adminModel.isAdmin) // login as user
      {
        try {
          await MyAuth().sinIn(email!, password!);
          _modelHud.loadingChange(false);
        } catch (e) {
          String? message = e.toString();
          _modelHud.loadingChange(false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
          // ignore: avoid_print
          print(e.toString());
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong try reinstall this app')));
      }
    }
    _modelHud.loadingChange(false);
  }
}
