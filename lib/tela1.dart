
import 'package:flutter/material.dart';

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {

  
  String pantalla = "0";

  double numero1 = 0;

  
  String operacion = "";

  
  bool nuevoNumero = false;

  
  bool hayError = false;

 
  void agregarNumero(String numero) {
    setState(() {
      if (nuevoNumero || hayError) {
        pantalla = numero;
        nuevoNumero = false;
        hayError = false;
      } else if (pantalla == "0") {
        pantalla = numero;
      } else {
        pantalla += numero;
      }
    });
  }

 
  void agregarPunto() {
    setState(() {
      if (nuevoNumero || hayError) {
        pantalla = "0.";
        nuevoNumero = false;
        hayError = false;
      } else if (!pantalla.contains(".")) {
        pantalla += ".";
      }
    });
  }

 
  void seleccionarOperacion(String op) {
    if (hayError) return;

    setState(() {
      numero1 = double.parse(pantalla);

      
      operacion = op;

      
      nuevoNumero = true;
    });
  }

  
  void calcular() {
    if (operacion == "" || hayError || nuevoNumero) {
      return;
    }

    double numero2 = double.parse(pantalla);
    double resultado = 0;

    
    if (operacion == "+") {
      resultado = numero1 + numero2;
    } else if (operacion == "-") {
      resultado = numero1 - numero2;
    } else if (operacion == "*") {
      resultado = numero1 * numero2;
    } else if (operacion == "/") {

      
      if (numero2 == 0) {
        setState(() {
          pantalla = "Error";
          operacion = "";
          hayError = true;
        });
        return;
      }

      resultado = numero1 / numero2;
    }

    setState(() {
    
      if (resultado == resultado.truncateToDouble()) {
        pantalla = resultado.toInt().toString();
      } else {
        pantalla = resultado.toString();
      }

      operacion = "";
      nuevoNumero = true;
    });
  }

  
  void limpiar() {
    setState(() {
      pantalla = "0";
      numero1 = 0;
      operacion = "";
      nuevoNumero = false;
      hayError = false;
    });
  }

 
  void borrar() {
    setState(() {
      if (hayError || nuevoNumero) {
        pantalla = "0";
        hayError = false;
        nuevoNumero = false;
      } else if (pantalla.length > 1) {
        pantalla = pantalla.substring(
          0,
          pantalla.length - 1,
        );
        if (pantalla == "-") {
          pantalla = "0";
        }
      } else {
        pantalla = "0";
      }
    });
  }

 
  Widget boton(String texto, VoidCallback accion) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: accion,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 22,
            ),
          ),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Calculadora"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // Pantalla donde mostramos los números
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                pantalla,
                style: const TextStyle(fontSize: 38),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 25),

            
            Row(
              children: [
                boton("7", () => agregarNumero("7")),
                boton("8", () => agregarNumero("8")),
                boton("9", () => agregarNumero("9")),
                boton("/", () => seleccionarOperacion("/")),
              ],
            ),

            Row(
              children: [
                boton("4", () => agregarNumero("4")),
                boton("5", () => agregarNumero("5")),
                boton("6", () => agregarNumero("6")),
                boton("*", () => seleccionarOperacion("*")),
              ],
            ),

         
            Row(
              children: [
                boton("1", () => agregarNumero("1")),
                boton("2", () => agregarNumero("2")),
                boton("3", () => agregarNumero("3")),
                boton("-", () => seleccionarOperacion("-")),
              ],
            ),

     
            Row(
              children: [
                boton("0", () => agregarNumero("0")),
                boton(".", agregarPunto),
                boton("=", calcular),
                boton("+", () => seleccionarOperacion("+")),
              ],
            ),

         
            Row(
              children: [
                boton("C", limpiar),
                boton("⌫", borrar),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
