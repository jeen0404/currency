
import 'package:currency/cubit/stream_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarItem {
  String text;
  IconData icon;
  Color color;
  BarItem({this.text, this.icon, this.color});
}



class BottomBar extends StatefulWidget {
  ///[barItems] is list of [BarItem] model
  ///class
  ///// it mean it hold data text,icon and color
  final List<BarItem> barItems =[
    BarItem(text: "home", icon: Icons.home, color: Colors.blue),
    BarItem(text: "Real Time", icon: Icons.timeline, color: Colors.green),
    BarItem(text: "History", icon: Icons.history_outlined, color: Colors.orange),
    BarItem(text: "Setting", icon: Icons.settings_outlined, color: Colors.red),
  ];

  ///  [animationDuration] is holds time  duration
  ///  of animation in click of bottom bar item
  final Duration animationDuration =  Duration(milliseconds: 250);

  final selectedIndex;

  BottomBar({Key key, this.selectedIndex}) : super(key: key);


  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  IntStreamCubit _intStreamCubit;

  @override
  void initState() {
    _intStreamCubit = BlocProvider.of<IntStreamCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).colorScheme.background,width: 0.2))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        ///[_buildBarItems] will return the list of ui.widget or bottom items
        children: _buildBarItems(),
      ),
    );
  }

  /// [_buildBarItems] function will generate ui.widget list or items of
  /// bottom bar
  ///
  List<Widget> _buildBarItems() {
    ///[_barItems] is for making a list of ui.widget and return
    List<Widget> _barItems = List();

    for (int i = 0; i < widget.barItems.length; i++) {
      ///[isSelected] is bool
      /// it comparing selected index to i so
      /// than can return selected index with different ui
      ///
      bool isSelected = widget.selectedIndex == i;

      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () => setState(() {
          _intStreamCubit.add(i);
        }),
        child: AnimatedContainer(
          decoration: isSelected
              ? BoxDecoration(
            color: widget.barItems[i].color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            //  border: Border.all(color: ui.widget.barItems[i].color.withOpacity(1.0),width: 5.0)
          )
              : BoxDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          duration: widget.animationDuration,
          child: Row(
            children: <Widget>[
              Icon(widget.barItems[i].icon,
                  color: isSelected
                      ? widget.barItems[i].color
                      : Theme.of(context).colorScheme.onSurface,
                  size:15),

              SizedBox(
                width: 2.0,
              ),
              AnimatedSize(
                duration: widget.animationDuration,
                curve: Curves.easeInOutCirc,
                vsync: this,
                ///
                child: Text(
                  isSelected ? widget.barItems[i].text : "",
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15,color:widget.barItems[i].color ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }
}
