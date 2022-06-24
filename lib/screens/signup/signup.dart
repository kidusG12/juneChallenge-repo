import 'package:flutter/material.dart';
import 'package:flutterchallenge1/screens/login/widgets/textField.dart';
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
  final TextEditingController _passwordFieldController =TextEditingController();
  final TextEditingController _ConformPasswordFieldController =TextEditingController();
  final TextEditingController _otherFieldController =TextEditingController();
  DateTime? _enteredDate;
  String _selectedRadio = 'Flutter is great!';
  bool _checkedValue = false;

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
      setState(() {
        _enteredDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _signupFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(_width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name
                      TextFormField(
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
                        obscureText: true,
                        controller: _passwordFieldController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      //conform password
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Type your password again';
                          } else if (value != _passwordFieldController) {
                            return 'Password don\'t match';
                          }
                          return null;
                        },
                        obscuringCharacter: '*',
                        obscureText: true,
                        controller: _ConformPasswordFieldController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Password again',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      //date of birth
                      ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onTap: () {
                          _pickDate();
                        },
                        leading: _enteredDate == null
                            ? const Text('Date of Birth')
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${DateFormat.yMEd().format(_enteredDate!)}',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                        trailing: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      //radio buttons
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
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
                        contentPadding: const EdgeInsets.all(0),
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
                        contentPadding: const EdgeInsets.all(0),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              controller: _otherFieldController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                labelText: 'other',
                                border: OutlineInputBorder(),
                              ),
                            )
                          : SizedBox.shrink(),
                      //checkbox
                      CheckboxListTile(
                        contentPadding: const EdgeInsets.all(0),
                        subtitle: const Text("I would like to receive your newsletter and other promotional information."),
                        value: _checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            _checkedValue = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),

                      // signUp button
                      GestureDetector(
                        onTap: null,
                        child: Container(
                          width: double.infinity,
                          color: Theme.of(context).primaryColor,
                          child:const Center(
                            child:Text('Sign Up',style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      //forgetPassword
                      GestureDetector(
                        onTap: null,
                        child: Center(
                          child: Text(
                            'forgot your password?',
                            style: TextStyle(color: Theme.of(context).primaryColor),),
                        ),
                          ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
