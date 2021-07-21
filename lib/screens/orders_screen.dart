import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widget/app_drawer.dart';
import 'package:shop_app/widget/order_Item.dart' as oi;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';

  @override
  Widget build(BuildContext context) {
    print('Building orders');
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                return Center(
                    child: Text(
                  'Error',
                  style: TextStyle(fontSize: 40.0),
                ));
              } else {
                final orderData = Provider.of<Orders>(context);
                return ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) {
                    return oi.OrderItem(orderData.orders[index]);
                  },
                );
              }
            }
          }),
    );
  }
}
