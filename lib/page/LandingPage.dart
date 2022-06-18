import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:pa_mobile_tani_shop/page/login.dart';


class LandingPage extends StatelessWidget {
  const LandingPage ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        decoration: BoxDecoration(
          color: Color.fromARGB(239,152,247,175),
        ), 
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 65,
                bottom: 10,
              ),
              child:Column(
                children: [ 
                  Text(
                    'Welcome to Tani Shop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255,2,62,74),
                    ),
                  ), 
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Tani Shop adalah sebuah aplikasi tempat berbelanja kebutuhan pertanian dan perkebunan kita semua ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255,2,62,74),
                    ),
                  ), 
                ]
              ),  
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/1.gif',scale: 0.2 ,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/2.gif',scale: 0.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/3.gif',scale: 0.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/4.gif',scale: 0.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/5.gif',scale: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:55),
              height: 40,
              width: 150 ,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }, 
              child: Text(
                'MULAI',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Colors.white,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}