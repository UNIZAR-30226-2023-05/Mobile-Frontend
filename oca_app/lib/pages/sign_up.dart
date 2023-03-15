import 'package:flutter/material.dart';
import 'package:oca_app/components/Buttons.dart';
import 'package:oca_app/components/forms.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Container(
                width: 390,
                height: 700,
                color: Colors.white,
                child: Container(
                  color: const Color.fromARGB(255, 170, 250, 254),
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                        const Text('REGÍSTRATE', style: TextStyle(color: Color.fromARGB(255, 28, 100, 116), fontSize: 36, fontFamily: 'Trocchi')),
                        const SizedBox(height: 20),
                        const Text("Añade una foto", style: TextStyle(color: Colors.black, fontSize: 20)),
                        //OJO, NO SE POR QUÉ NECESITAS UNA SIZED BOX AQUI PARA QUE SE CENTRE EL ICONO
                        SizedBox(
                          width: double.infinity,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.image, color: Colors.black, size: 90),
                          ),
                        ),
                        const SizedBox(height: 50),
                        const Text("Nombre de usuario*", style: TextStyle(color: Colors.black, fontSize: 20)),
                        MyForm(
                          controller: usernameController, 
                          hintText: "", 
                          obscureText: false),

                        const SizedBox(height: 10),
                        const Text("E-mail*", style: TextStyle(color: Colors.black, fontSize: 20)),
                        MyForm(
                          controller: emailController, 
                          hintText: "", 
                          obscureText: false),
                          
                        const SizedBox(height: 10),
                        const Text("Contraseña*", style: TextStyle(color: Colors.black, fontSize: 20)),
                        MyForm(
                          controller: passwordController, 
                          hintText: "", 
                          obscureText: true),

                        const SizedBox(height: 10),
                        const Text("Repetir Contraseña*", style: TextStyle(color: Colors.black, fontSize: 20)),
                        MyForm(
                          controller: repeatpasswordController, 
                          hintText: "", 
                          obscureText: true),
                  
                        const Text("Campo obligatorio*", style: TextStyle(color: Colors.black, fontSize: 15)),
                        const SizedBox(height: 15),
                        SignUpButton(onPressed: () {}, textoAMostrar: "REGISTRARSE"),
                        
                    ]),
                ),
              )
              

            ]
          ),
        )
        ),
    );
  }
}