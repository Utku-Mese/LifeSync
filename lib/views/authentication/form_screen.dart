import 'package:flutter/material.dart';
import 'package:life_sync/controller/auth_controller.dart';
import 'package:life_sync/utils/app_theme.dart';
import 'login_screen.dart';
import 'widgets/my_text_field.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _legthController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  AuthController authController = AuthController();

  DateTime selectedDate = DateTime.now();
  String _gender = 'Diğer';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Kayıt Formu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: AppTheme.fontName,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await authController.createUserWithEmailAndPassword(
                  email: widget.email,
                  password: widget.password,
                  name: _nameController.text,
                  surname: _surnameController.text,
                  username: _userNameController.text,
                  profilePhoto: authController.image,
                  height: int.parse(_legthController.text),
                  weight: double.parse(_weightController.text),
                  birdDate: selectedDate,
                  gender: _gender,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 20.0),
                ),
              ),
              child: const Text(
                'Kayıt Ol',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: AppTheme.nearlyDarkBlue.withOpacity(0.4),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_rounded,
                        size: 85,
                        color: AppTheme.nearlyDarkBlue.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: InkWell(
                    onTap: () => authController.pickImage(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Color(0XFF767676),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MyTextField(
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    emailController: _nameController,
                    text: 'Adınız',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MyTextField(
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    emailController: _surnameController,
                    text: 'Soyadınız',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MyTextField(
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    emailController: _userNameController,
                    text: 'Kullanıcı Adınız',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MyTextField(
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    emailController: _legthController,
                    text: 'Boyunuz (cm)',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MyTextField(
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    emailController: _weightController,
                    text: 'Kilonuz (kg)',
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Doğum Tarihinizi Seçin:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: const Text('Tarih Seç'),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Seçilen Tarih: ${selectedDate.toLocal().day}/${selectedDate.toLocal().month}/${selectedDate.toLocal().year}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Cinsiyetinizi Seçin:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              fillColor: MaterialStateProperty.all<Color>(
                                AppTheme.nearlyDarkBlue,
                              ),
                              value: 'Erkek',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value.toString();
                                });
                              },
                            ),
                            const Text('Erkek', style: TextStyle(fontSize: 16)),
                            Radio(
                              fillColor: MaterialStateProperty.all<Color>(
                                AppTheme.nearlyDarkBlue,
                              ),
                              value: 'Kadın',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value.toString();
                                });
                              },
                            ),
                            const Text('Kadın', style: TextStyle(fontSize: 16)),
                            Radio(
                              fillColor: MaterialStateProperty.all<Color>(
                                AppTheme.nearlyDarkBlue,
                              ),
                              value: 'Diğer',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value.toString();
                                });
                              },
                            ),
                            const Text('Diğer', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
