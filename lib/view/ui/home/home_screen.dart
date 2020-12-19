import 'package:currency/cubit/home_cubit.dart';
import 'package:currency/cubit/stream_cubit.dart';
import 'package:currency/model/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // home cibit
  HomeCubit _homeCubit ;

  IntStreamCubit _fromlistcubit=IntStreamCubit();
  IntStreamCubit _tolistcubit=IntStreamCubit();

  String fromName="AED";

  String toName="AED";

  double value=00;


  @override
  void initState() {
    _homeCubit = HomeCubit(_scaffoldKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Currency", style: GoogleFonts.pacifico()),
        actions: [
          IconButton(icon: Icon(Icons.save_outlined),onPressed: ()=>_homeCubit.add(AddToHistoryHomeCubitEvent(fromName, toName, value)),)
        ],
      ),
      body: Column(
        children: [
          Divider(thickness: 1,height: 1,),
          SizedBox(height: 20,),
          Text("From",style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      label: TextField(
                        onChanged: (i){
                          try {
                            value = double.parse(i);
                          }
                          catch(error){
                            value=0;
                          }
                          _homeCubit.add(CalculateHomeCubitEvent(fromName, toName, value));
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                        decoration: InputDecoration(
                        //    filled: true,
                            border: InputBorder.none, hintText: "00"),
                      ),
                    ),
                  ),
                ),
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_rounded),
                ),),
                Flexible(child: Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).colorScheme.background,width: 0.5)
                  ),
                  height: 200,
                  child: FutureBuilder<List<CurrencyModel>>(future: _homeCubit.getCurrencysList,
                    builder: (context,future){
                    if(!future.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    return BlocBuilder<IntStreamCubit,int>(
                      cubit: _fromlistcubit,
                        builder: (context,state){
                      return  PageView.builder(
                        onPageChanged:(i){
                          _fromlistcubit.add(i);
                          fromName=future.data[i].name;
                          _homeCubit.add(CalculateHomeCubitEvent(fromName, toName, value));
                        },
                        controller: PageController(viewportFraction: 0.2),
                        scrollDirection: Axis.vertical,
                        itemCount: future.data.length,
                        itemBuilder: (context,index){
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: state==index?BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(5)
                            ):BoxDecoration(),
                            child: Center(
                              child: Text(future.data[index].name,style:  TextStyle(
                                  fontSize: 20,
                                  color: state==index?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 2),),
                            ),
                          );
                        },
                      );
                    });
                    },
                  ),
                ),)
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 20,),
          Text("To",style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),),
          Expanded(
            child: Row(
              children: [
                Flexible(child: Center(child:BlocBuilder<HomeCubit,double>(
                  cubit: _homeCubit,
                  builder: (context,state){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.toStringAsFixed(2),style:  TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),),
                    );
                  },
                )
                  ,),),
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_outlined),
                ),),
                Flexible(child: Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Theme.of(context).colorScheme.background,width: 0.5)
                  ),
                  height: 200,
                  child: FutureBuilder<List<CurrencyModel>>(future: _homeCubit.getCurrencysList,
                    builder: (context,future){
                      if(!future.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      return BlocBuilder<IntStreamCubit,int>(
                          cubit: _tolistcubit,
                          builder: (context,state){
                            return  PageView.builder(
                              onPageChanged:(i){
                                _tolistcubit.add(i);
                                toName=future.data[i].name;
                                _homeCubit.add(CalculateHomeCubitEvent(fromName, toName, value));
                              },
                              controller: PageController(viewportFraction: 0.2),
                              scrollDirection: Axis.vertical,
                              itemCount: future.data.length,
                              itemBuilder: (context,index){
                                return Container(
                                  height:30,
                                  margin: EdgeInsets.all(5),
                                  decoration: state==index?BoxDecoration(
                                      color: Theme.of(context).colorScheme.background,
                                      borderRadius: BorderRadius.circular(5)
                                  ):BoxDecoration(),
                                  child: Center(
                                    child: Text(future.data[index].name,style:  TextStyle(
                                        fontSize: 20,
                                        color: state==index?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 2),),
                                  ),
                                );
                              },
                            );
                          });
                    },
                  ),
                ),)
              ],
            ),
          ),
        ],
      ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}
