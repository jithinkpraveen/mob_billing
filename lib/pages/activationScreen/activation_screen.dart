import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mob_billing/pages/homeScreen/home_screen.dart';
import 'package:mob_billing/services/activate_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({Key? key}) : super(key: key);

  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  String key = "";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isKeyboard = WidgetsBinding.instance!.window.viewInsets.bottom > 0.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextFormField(
                  // smartDashesType: SmartDashesType.enabled,

                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a key';
                    }
                    key = value;
                    return null;
                  },
                  obscureText: false,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    // prefixIcon: Icon(Icons.lock),\
                    hintText: "xxxx - xxxx - xxxx - xxxx",
                    hintStyle: TextStyle(color: Colors.grey),
                    // hintTextDirection: ,
                    filled: true,
                    fillColor: Color(0x156B779A),
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color(0xff39A2DB),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Enter your key to \n get your Service",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 30, 20),
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: loading ? null : activateApp,
                        child: loading
                            ? const CircularProgressIndicator()
                            : const Icon(
                                Icons.arrow_forward,
                                size: 30,
                                color: Color(0xff39A2DB),
                              ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              !_isKeyboard ? const SizedBox(height: 90) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void activateApp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      var res = await ActivateAppServices().activateDevice(key);
      if (res['success']) {
        setState(() {
          loading = false;
        });
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setBool("isActivate", true);
        _prefs.setString("key", key);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res['message'])));
      }
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
