import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/page/login.dart';
import 'package:pa_mobile_tani_shop/services/authentication_service.dart';
import 'package:pa_mobile_tani_shop/services/user_services.dart';
import 'package:pa_mobile_tani_shop/validator/validator.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({Key? key}) : super(key: key);

  @override
  State<RegisPage> createState() => _RegisPageState();
}

enum User { Penjual, Pembeli }

class _RegisPageState extends State<RegisPage> {

  final _nameController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  User? _character = User.Penjual;

  String getAkses(){
    if(_character == User.Penjual) {
      return "Penjual";
    } else {
      return "Pembeli";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noTelpController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var Lebar = MediaQuery.of(context).size.width;
    var Tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
       }, 
       icon: Icon(Icons.arrow_back_ios_rounded)),
       iconTheme: IconThemeData(
         color: Colors.black,
       ),
      ),
      extendBodyBehindAppBar:true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(239, 152, 247, 175),
            ),
            child: Container(
              width: Lebar,
              height: Tinggi,
              margin: EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70)),
                color: Color(0xFFFDF6EC),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _nameController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(239, 152, 247, 175),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: " Nama ",
                            labelStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _emailController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(239, 152, 247, 175),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: " Alamat Email ",
                            labelStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _noTelpController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(239, 152, 247, 175),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: "No. Telpon",
                            labelStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _passController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(239, 152, 247, 175),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            margin: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.people_alt,
                              size: 24.0,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Hak Akses",
                              style: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                          visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                          title: const Text(
                            'Penjual',
                            style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 15
                            ),
                          ),
                          leading: Radio<User>(
                            fillColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 54, 60, 79)),
                            value: User.Penjual,
                            groupValue: _character,
                            onChanged: (User? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                          visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                          title: const Text(
                            'Pembeli',
                            style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 15
                            ),
                          ),
                          leading: Radio<User>(
                            fillColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 54, 60, 79)),
                            value: User.Pembeli,
                            groupValue: _character,
                            onChanged: (User? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 150,
                        height: 40,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(239, 152, 247, 175),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40),
                              )),
                          onPressed: () async {
                            var validator =  SignUpValidator(
                              _nameController.value.text,
                              _noTelpController.value.text,
                              _emailController.value.text,
                              _passController.value.text,
                            );
                          if(validator){
                              validator = await AuthServices.createUser(_emailController.value.text, _passController.value.text);
                              if(validator){
                                await UserServices.addUser(
                                  _nameController.value.text,
                                  _noTelpController.value.text,
                                  _emailController.value.text,
                                  getAkses(),
                                );
                                Get.to(() => LoginPage());
                              }
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(239, 152, 247, 175),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Please Login",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins'),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "To Your Account",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                              ),
                            );
                          },
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 60),
                            width: 150,
                            height: 20,
                            child: Text(
                              "Have any account?  ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Text("Log-In",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 40, 0, 108),
                                  fontFamily: 'Poppins',
                                )),
                            onTap: () => Get.to(LoginPage()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
