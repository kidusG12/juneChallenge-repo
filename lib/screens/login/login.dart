import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
  TextEditingController();

  var _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(_width * 0.06),
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: _width * 0.2),
                        const Text(
                          'Log In',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: _width * 0.1),
                        //email
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          controller: _emailFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: _width * 0.05),

                        //password
                        TextFormField(
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid password';
                              } else {
                                return null;
                              }
                            }
                          },
                          obscuringCharacter: '*',
                          obscureText: _obscureText,
                          controller: _passwordFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: FlatButton(
                                  onPressed: _toggle,
                                  child: Text(
                                    _obscureText ? 'SHOW' : 'HIDE',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ))),
                        ),
                        SizedBox(height: _width * 0.05),

                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Login button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.06),
              child: GestureDetector(
                onTap: null,
                child: Container(
                  height: _width * 0.12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color:  Theme.of(context).primaryColor,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style:
                      TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: _width * 0.05),
            //forgetPassword
            GestureDetector(
              onTap: null,
              child: Center(
                child: Text(
                  'forgot your password?',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: _width * 0.05),
          ],
        ),
      ),
    );
  }
}
