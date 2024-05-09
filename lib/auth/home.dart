import 'package:ecomfix/bloc/products/bloc/product_event.dart';
import 'package:ecomfix/bloc/products/bloc/product_state.dart';
import 'package:ecomfix/urls/firebase_urls/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products/bloc/product_bloc.dart';
import '../models/products/top-rated-product.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(TopRatedApiFetchEvent());

  }

  Model_123? topRated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined))
        ],
      ),
      drawer:  Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 5,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35, color: Colors.deepOrange,)),
                accountName: Text("naresh"),
                accountEmail: Text("nkraj021@gmail.com"),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("SignOut"),
              onTap: (){
                FirebaseProvider.firebaseAuthMy.signOut();
              },
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state){
            if(state is ProductLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is ProductErrorState){
              return Text(state.errorMsg);
            }
            if(state is ProductLoadedState){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.products.length,
                  itemBuilder: (ctx, index){
                  return Container(
                    width: 100, height: 100, color: Colors.deepOrange,
                  );
                  }
              );
            }

            return Container();
          })
        ],
      ),
    );
  }
}
