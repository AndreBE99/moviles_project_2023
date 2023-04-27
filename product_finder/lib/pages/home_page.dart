import 'package:flutter/material.dart';
import 'package:product_finder/pages/favorites_page.dart';
import 'package:product_finder/pages/login_page.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Favorites(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Scaffold(body: _widgetOptions.elementAt(_selectedIndex)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
              backgroundColor: Colors.red,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


// import 'package:product_finder/pages/bloc/product_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:product_finder/pages/result_list_page.dart';

// child: ElevatedButton(
//           onPressed: () {
//             BlocProvider.of<ProductBloc>(context).add(LoadProductListEvent());
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BlocBuilder<ProductBloc, ProductState>(
//                   builder: (context, state) {
//                     if (state is ProductListLoadedState) {
//                       return ResultList(products: state.productList);
//                     } else {
//                       return CircularProgressIndicator();
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//           child: Text('Lista de productos'),
//         ),