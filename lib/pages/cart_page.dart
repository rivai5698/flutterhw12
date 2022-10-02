import 'package:flutter/material.dart';
import 'package:flutterhw12/model/item_model.dart' as im;
import 'package:flutterhw12/pages/category_page.dart';
import 'package:flutterhw12/provider/item_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void setState(VoidCallback fn) {
    context.read<ItemProvider>().getCartItem();
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var heightM = MediaQuery.of(context).size.height - 240;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: Consumer(
          builder: (_, ItemProvider itemProvider, __) {
            context.read<ItemProvider>().getItem();
            return IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider<ItemProvider>.value(
                      value: itemProvider,
                      child: const CategoryPage(),
                    ),
                  ),
                );
                print(itemProvider.listItems);
              },
              icon: const Icon(Icons.arrow_back_ios),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: heightM,
            color: Colors.yellow,
            child: Consumer(
              builder: (_, ItemProvider itemProvider, __) {
                print('${itemProvider.currentStatus}');
                if (itemProvider.currentStatus == Status.addCartSuccess ||
                    itemProvider.currentStatus == Status.removeCartSuccess ||
                    itemProvider.currentStatus == Status.addCategorySuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemProvider.cart.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return item(itemProvider.cart[index]);
                    },
                  );
                }
                if (itemProvider.currentStatus == Status.removingCart) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text('Empty'),
                );
              },
            ),
          ),
          Container(
            color: Colors.black45,
            width: double.infinity,
            height: 1,
          ),
          Consumer(
            builder: (_, ItemProvider itemProvider, __) {
              return Expanded(
                  child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.yellow,
                child: buyItems(itemProvider.cart),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget buyItems(List<im.ItemModel> items) {
    var price = 0;
    for (int i = 0; i < items.length; i++) {
      price += items[i].price;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('\$$price',
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 48,
            )),
        const Text(
          'Buy',
          style: TextStyle(color: Colors.blue, fontSize: 48),
        )
      ],
    );
  }

  Widget item(im.ItemModel item) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.black45,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            item.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  context.read<ItemProvider>().removeItem(item);
                },
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 64,
          )
        ],
      ),
    );
  }
}
