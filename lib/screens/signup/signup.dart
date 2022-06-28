import 'package:flutter/material.dart';
import 'package:flutterchallenge1/screens/login/login.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signupScreen';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final TextEditingController _conformPasswordFieldController =
      TextEditingController();
  final TextEditingController _otherFieldController = TextEditingController();
  DateTime? _enteredDate;
  var _selectedRadio = 'Flutter is great!';
  var _checkedValue = false;
  var _isEligible = false;
  var _formIsValid = false;
  var _obscureText = true;
  var _obscureText2 = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1922),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      if (pickedDate.isBefore(DateTime(2004))) {
        _isEligible = true;
      }
      setState(() {
        _enteredDate = pickedDate;
      });
    });
  }

  void _canSignup() {
    if (_signupFormKey.currentState!.validate() && _isEligible) {
      setState(() {
        _formIsValid = true;
      });
    }
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
                        SizedBox(height: _width * 0.08),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: _width * 0.1),
                        //name
                        TextFormField(
                          style: const TextStyle(height: 0.5),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          controller: _nameFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: _width * 0.05),

                        //email
                        TextFormField(
                          style: const TextStyle(height: 0.5),
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
                          style: const TextStyle(height: 0.5),
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

                        //conform password
                        TextFormField(
                          style: const TextStyle(height: 0.5),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Type your password again';
                            } else if (value != _passwordFieldController.text) {
                              return 'Password don\'t match';
                            }
                            return null;
                          },
                          obscuringCharacter: '*',
                          obscureText: _obscureText2,
                          controller: _conformPasswordFieldController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Password again',
                              border: const OutlineInputBorder(),
                              suffixIcon: FlatButton(
                                  onPressed: _toggle2,
                                  child: Text(
                                    _obscureText2 ? 'SHOW' : 'HIDE',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ))),
                        ),
                        SizedBox(height: _width * 0.05),

                        //date of birth
                        ListTile(
                          visualDensity:
                          VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onTap: () {
                            _pickDate();
                            _canSignup();
                          },
                          leading: _enteredDate == null
                              ? Text(
                                  'Date of Birth',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600]),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat.yMEd().format(_enteredDate!),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                          trailing: const Padding(
                            padding: EdgeInsets.only(right: 25.0),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        //radio buttons
                        ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: const EdgeInsets.all(0),
                          horizontalTitleGap: 0,
                          leading: Radio<String>(
                            value: 'Flutter is great!',
                            groupValue: _selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadio = value!;
                              });
                            },
                          ),
                          title: const Text('Flutter is great!'),
                        ),
                        ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: const EdgeInsets.all(0),
                          horizontalTitleGap: 0,
                          leading: Radio<String>(
                            value: 'Flutter is awesome!',
                            groupValue: _selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadio = value!;
                              });
                            },
                          ),
                          title: const Text('Flutter is awesome!'),
                        ),
                        ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: const EdgeInsets.all(0),
                          horizontalTitleGap: 0,
                          leading: Radio<String>(
                            value: 'other',
                            groupValue: _selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadio = value!;
                              });
                            },
                          ),
                          title: const Text('other:'),
                        ),

                        //other field
                        _selectedRadio == 'other'
                            ? TextFormField(
                                style: const TextStyle(height: 0.5),
                                validator: (value) {
                                  if (_selectedRadio == 'other' &&
                                      (value == null || value.isEmpty)) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                controller: _otherFieldController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (_) {
                                  _canSignup();
                                },
                                decoration: const InputDecoration(
                                  labelText: 'other',
                                  border: OutlineInputBorder(),
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(height: _width * 0.05),
                        // checkbox
                        CheckboxListTile(
                          contentPadding: const EdgeInsets.all(0),
                          subtitle: const Text(
                              "I would like to receive your newsletter and other promotional information."),
                          value: _checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              _checkedValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // signUp button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.06),
              child: GestureDetector(
                onTap: _formIsValid
                    ? () =>
                        Navigator.of(context).pushNamed(LoginScreen.routeName)
                    : null,
                child: Container(
                  height: _width * 0.12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: _formIsValid
                          ? Theme.of(context).primaryColor
                          : Colors.grey[100],
                      border: Border.all(width: 1,color: _formIsValid?Theme.of(context).primaryColor:Colors.black),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style:
                          TextStyle(color: _formIsValid ? Colors.white : null),
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
