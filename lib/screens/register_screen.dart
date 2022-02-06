import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/servises/auth.dart';
import 'package:e_commerce/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Register extends StatefulWidget {
  static String routName = 'Register';
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? name;
  String? email;
  String? password;
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                        name = value;
                      },
                      hint: 'Enter your Name',
                      icon: Icons.person),
                  SizedBox(
                    height: height * 0.02,
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
                      onPressed: () async {
                        final providerModel =
                            Provider.of<ModelHud>(context, listen: false);
                        providerModel.loadingChange(true);

                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          try {
                            await MyAuth().register(email!, password!);
                            // ignore: avoid_print
                            print('Done');
                            providerModel.loadingChange(false);
                          } catch (e) {
                            String? message = e.toString();
                            providerModel.loadingChange(false);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                            // ignore: avoid_print
                            print(e.toString());
                            // Scaffold.of(context).showBottomSheet((context) =>
                            //     SnackBar(content: Text(e.toString())));
                          }
                        }
                        providerModel.loadingChange(false);
                      },
                      child: const Text(
                        'Register',
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
                        'have an account?',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routName);
                        },
                        child: const Text(
                          'Login  ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
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
}
