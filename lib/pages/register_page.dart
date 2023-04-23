import 'package:flutter/material.dart';



class MyRegisterPage extends StatelessWidget {
  
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(111, 19, 110, 170),
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
                      
          
                // logo
                Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                size: 200,
                color: Colors.white,
              ),
              Text(
                'IMPACT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                 fontSize: 26,
                ),
              ),
            ],
          ),
            const SizedBox(height: 20,),
              Text(
                  'REGISTER',
                  
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 32,
                    fontWeight: FontWeight.w900
                    
                    
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: false,
                    textAlign: TextAlign.center,
                        
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.white),),
                            hintText: 'Username',
                            fillColor:  Colors.grey.shade200,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: Colors.white),

                              ),
                          )
                ),

                
                ),
                              const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                        obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.white),),
                            hintText: 'Email',
                            fillColor:  Colors.grey.shade200,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: Colors.white),

                              ),
                          )
                ),

                
                ),
                              const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                     obscureText: true,
                        
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.white),),
                            hintText: 'Password',
                            fillColor:  Colors.grey.shade200,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: Colors.white),

                              ),
                          )
                ),

                
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 60,
                  width: 300,
                  
                  child: ElevatedButton(onPressed:(){
                
                
                  },
                  
                  child: Text('Sign Up',
                  style:TextStyle(
                    color: Colors.black
                   ) ,),
            
                   style:ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),),
         
                 
                ),backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                
          


          ),),)  ],),
        ),
      )),
    );
  }
}