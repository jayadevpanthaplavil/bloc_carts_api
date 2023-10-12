import 'package:bloc_carts_api/cart_bloc/carts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Carts.dart';
import 'Products.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CartsBloc>(
        create: (BuildContext context) => CartsBloc(),
      ),

    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<CartsBloc>().add(FetchEvent());

    return Scaffold(
      body: BlocBuilder<CartsBloc, CartsState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.cartlist?.length,
              itemBuilder: (BuildContext context, int index) {
                Carts cart1 = state.cartlist![index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Cart ID - ${cart1.id}"),
                        Text("User ID - ${cart1.userId}"),

                        Container(
                          height: 60,
                          child: ListView.builder(itemCount: cart1.products
                              ?.length,
                              itemBuilder: (BuildContext context, int index) {
                                Products products = cart1
                                    .products![index] as Products;
                                return Column(
                                  children: [
                                    Text("${products.title}")
                                  ],
                                );
                              }),
                        ),

                        // Row(
                        //   children: [
                        //     Text("Status  - "),
                        //     Container(child: us.completed==true ? Icon(Icons.done): Icon(Icons.error)),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
