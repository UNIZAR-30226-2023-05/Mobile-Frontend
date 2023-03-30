import 'package:flutter/material.dart';
import 'package:oca_app/components/forms.dart';
import 'package:oca_app/pages/main_menu.dart';
import 'package:oca_app/styles/buttons_styles.dart';
import 'package:oca_app/backend_funcs/log_in_func.dart';
import 'package:oca_app/pages/sign_up.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void logUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 28, 100, 116),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                //logo
                Image.asset('lib/images/logo.PNG', width: 200, height: 200),
                //const SizedBox(height: 25),
                //OCA LOCA
                const Text('OCA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontFamily: 'Caudex')),
                const Text('LOCA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Caudex')),

                //username textfield
                MyForm(
                  controller: usernameController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),

                //password textfield
                MyForm(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
                //forgot password?
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          //onPressed: () => Navigator.pushNamed(context, '/forgot_password'),
                          onPressed: () {},
                          child: const Text('¿Has olvidado la contraseña?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 201, 201, 201),
                                  fontSize: 17)),
                        ),
                      ],
                    )),

                const SizedBox(height: 20),
                //log in button
                //MyButton(onPressed: logUserIn, textoAMostrar: 'Iniciar sesión'),
                ElevatedButton(
                  style: GenericButton,
                  onPressed: () {
                    LogIn logIn =
                        LogIn(usernameController.text, passwordController.text);
                    logIn.enviar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main_Menu_Page()),
                    );
                  },
                  child: const Text("Iniciar sesión",
                      style: TextStyle(
                        color: Color.fromARGB(255, 8, 54, 65),
                        fontSize: 26,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Chivo',
                      )),
                ),
                //Sign up
                const SizedBox(height: 130),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Todavía no tienes cuenta? ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 201, 201, 201),
                            fontSize: 17)),
                    const SizedBox(width: 1),
                    TextButton(
                      //onPressed: () => Navigator.pushNamed(context, '/forgot_password'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: const Text('Registrate ahora',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
