import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_mobile_tani_shop/page/Pembeli_page/Home_Pembeli.dart';
import 'package:pa_mobile_tani_shop/page/LandingPage.dart';
import 'package:pa_mobile_tani_shop/page/Penjual_page/Home_Penjual.dart';
import 'package:pa_mobile_tani_shop/page/registrasi.dart';
import 'package:pa_mobile_tani_shop/services/authentication_service.dart';
import 'package:pa_mobile_tani_shop/services/user_services.dart';
import 'package:pa_mobile_tani_shop/validator/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose(){
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
 }

 @override
 void initState(){
  super.initState();
  _emailController.text = "";
  _passwordController.text = "";
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
         Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
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
              margin: EdgeInsets.only(top: 100),
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
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40, left: 17),
                            width: Lebar,
                            height: 40,
                            child: Text(
                              "Welcome to Tani Shop",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: Lebar,
                        height: 50,
                        child: Text(
                          "Sign to your account and fullfill your farm and garden ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins',
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
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(239, 152, 247, 175),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: " Email ",
                            labelStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _passwordController,
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
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
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
                            var validator = LogInValidator(
                            _emailController.value.text,
                            _passwordController.value.text
                            );
                            if(validator){
                            validator = await AuthServices.signInWithEmail(
                              _emailController.value.text, 
                              _passwordController.value.text
                            );
                              if(validator){
                                UserServices.getUserData().then((value){                                    
                                  value['user'] == "Pembeli" 
                                    ? Get.off(() => MyHome()) : Get.off(() => PenjualHome());
                                });
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
                                                "Welcome",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins'),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "Happy Shopping",
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
                            "Login",
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
                              "Dont have an account?  ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Text("Sign-Up",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 40, 0, 108),
                                  fontFamily: 'Poppins',
                                )),
                            onTap: () => Get.to(RegisPage()),
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
