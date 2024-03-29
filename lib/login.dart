import 'package:flutter/material.dart';
import 'dailyexpenses.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ipAddressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder:(BuildContext context) => Dialog(
                    elevation: 10,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Enter The Server IP Address"),

                            Expanded(
                              child: TextField(
                                controller: ipAddressController,
                                decoration: InputDecoration(
                                  labelText: "IP Address",
                                  filled: true,
                                  fillColor: Colors.white70,
                                ),),
                            ),

                            /**
                             * button to set IPAddress
                             * which is useful
                             */
                            ElevatedButton(onPressed: () async{
                              final prefs = await SharedPreferences.getInstance();
                              String ip = ipAddressController.text;
                              await prefs.setString("ip", ip);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Ip ${ipAddressController.text} is added"
                                      )
                                  )
                              );
                            }, child: Text("Save IP Address")),
                          ],
                        )
                    ),
                  )
              );
            },
            child: Icon(Icons.network_wifi),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: "https://w7.pngwing.com/pngs/978/821/"
                        "png-transparent-money-finance-wallet-payment-daily"
                        "-expenses-saving-service-personal-finance.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true, // Hide the password
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),

              ElevatedButton(
                  onPressed: (){
                    String username = usernameController.text;
                    String password = passwordController.text;
                    if(username == 'test' && password == '12345678'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> DailyExpensesApp(username: username),
                        ),
                      );

                    }
                    else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Login Failed'),
                              content: const Text('Invalid username or password.'),
                              actions: [
                                TextButton(
                                    child: const Text('OK'),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }
                                )
                              ],
                            );
                          }
                      );
                    }
                  },
                  child: Text("Login")
              ),
            ],
          ),
        )
    );
  }
}

