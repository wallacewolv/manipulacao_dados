import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _textoSalvo = "Nada salvo!";
  TextEditingController _controllerCampo = TextEditingController();

  _salvar() async {
    String valorDigitado = _controllerCampo.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);

    // print("operação (Salvar): $valorDigitado");
  }

  _recuperar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Sem valor";

      // print("operação (Recuperar): $_textoSalvo");
    });
  }

  _remover() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");

    // print("operação (Remover)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              _textoSalvo,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite algo",
              ),
              controller: _controllerCampo,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: _salvar,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Recuperar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: _recuperar,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Remover",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: _remover,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
