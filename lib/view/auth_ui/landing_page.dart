import 'package:currency/cubit/app_start_cubit.dart';
import 'package:currency/cubit/auth_cubit.dart';
import 'package:currency/cubit/stream_cubit.dart';
import 'package:currency/repository/user_model_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AuthCubit _authCubit;
  final IntStreamCubit _switchPage = IntStreamCubit();

  @override
  void initState() {
    _authCubit=AuthCubit(_scaffoldKey);
    super.initState();
  }


  @override
  void dispose() {
    _switchPage.close();
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height / 1.3,
                child:CarouselAnimation()
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 2.5,
              child:MultiBlocProvider(
                providers: [
                  BlocProvider<IntStreamCubit>(create: (context)=>_switchPage),
                  BlocProvider<AuthCubit>(create: (context)=>_authCubit),
                ],
                child: BlocBuilder<IntStreamCubit,int>(
                  cubit: _switchPage,
                  builder: (context,state){
                    return IndexedStack(
                      index: state,
                      children: [
                        LoginPage(),
                        SignUpPage(),
                      ],
                    );
                  },
                ),
              )
            )
          ],
        ));
  }
}


class LoginPage extends StatelessWidget {
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Login",style:Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 25, fontWeight: FontWeight.normal)),
          Column(
            children: [

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: TextField(
                    onChanged: (text)=>username=text,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username"
                    ),
                  ), //avatar: Icon(Icons.email_outlined,size: 15,),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: TextField(
                    onChanged: (text)=>password=text,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password"
                    ),
                  ), //avatar: Icon(Icons.email_outlined,size: 15,),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ActionChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: ()=>BlocProvider.of<AuthCubit>(context).add(LoginAuthCubitEvent(username,password)),
                label: Text("Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 2)),
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          InkWell(
            onTap:()=> BlocProvider.of<IntStreamCubit>(context).add(1),
            child: Text(
              "Don't have account? Sign-up",
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}


class SignUpPage extends StatelessWidget {

  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Signup",style:Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 25, fontWeight: FontWeight.normal)),
          Column(
            children: [

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: TextField(
                    onChanged: (text)=>username=text,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Choose Username"
                    ),
                  ), //avatar: Icon(Icons.email_outlined,size: 15,),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: TextField(
                    onChanged: (text)=>password=text,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Create Password"
                    ),
                  ), //avatar: Icon(Icons.email_outlined,size: 15,),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ActionChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () =>BlocProvider.of<AuthCubit>(context).add(SignUpAuthCubitEvent(username,password)),

                label: Text("SignUp",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 2)),
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          InkWell(
            onTap:()=> BlocProvider.of<IntStreamCubit>(context).add(0),
            child: Text(
              "have an account? Sign-in",
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}




class CarouselAnimation extends StatelessWidget {
  final IntStreamCubit intStreamCubit = IntStreamCubit();
  final List<String> imageList = [
    "https://lh3.googleusercontent.com/proxy/kHKLhQAGefCS0BLknwfMZHlS7q4ExBM4TggMg8-fi_TKe37Di9pOGhx46azfkMSltmEFXuzVRkAik_Wp89f5e2_BWyxu3E0-qaYmnJ3fNHxF6LpYQ7nzZxSBsct-",
    "https://fsa.zobj.net/crop.php?r=ES98Nw5_mn5nGbeFx2ZeJ_P_N3kWHLKJ5Go8goH9ptAhwTAGprSoeCBu-5s-GGGoTLesKONwWcRCBsHktqVKsU8LWzlAXalp4GTRMm_0teE6FMzqKBwXopnJ_9064DUO7lE8_jTyoFTFqHx5YpOaVibA9rtKubS-i-Sd0iNUYS-7xILfS_S8sRWtK00",
    "https://s1.1zoom.me/b4853/678/Money_Banknotes_Dollars_554891_1080x1920.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: PageView.builder(
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return Image(
                image: NetworkImage(imageList[index]),
                fit: BoxFit.cover,
              );
            },
            onPageChanged: (i) => intStreamCubit.add(i),
          ),
        ),
        Positioned(
            height: 32,
            bottom: 150,
            left: 0,
            right: 0,
            child: StreamBuilder<int>(
              stream: intStreamCubit,
              builder: (context, stream) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        margin: EdgeInsets.all(8),
                        height: 15,
                        width: stream.data == index ? 40 : 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.5)),
                      );
                    },
                    itemCount: imageList.length);
              },
            ))
      ],
    );
  }
}

