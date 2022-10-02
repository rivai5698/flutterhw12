import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterhw12/model/item_model.dart' as im;
import 'package:flutterhw12/provider/item_provider.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}


class _CategoryPageState extends State<CategoryPage> {

  @override
  void initState() {
     Future.delayed(Duration.zero,() async {
        context.read<ItemProvider>().getItem();
    //    context.read<ItemProvider>().getCartItem();
     });
    Future.delayed(Duration.zero,() async {
      await context.read<ItemProvider>().addItem(im.items);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    Future.delayed(Duration.zero,() async {
     // context.read<ItemProvider>().getItem();
      //context.read<ItemProvider>().getCartItem();
    });
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero,() async {
    //   await context.read<ItemProvider>().addItem(im.items);
    // });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        actions: [
          Consumer(builder: (_,ItemProvider itemProvider,__){
            return _cartWidget(itemProvider.cart.length, itemProvider.cart.isNotEmpty,itemProvider);
          })
        ],
      ),
      body: Consumer(
        builder: (_,ItemProvider itemProvider,__){
          // Future.delayed(Duration.zero,() async {
          //   await context.read<ItemProvider>().addItem(im.items);
          // });
          if(itemProvider.currentStatus == Status.addingCategory){
            return const Center(child: CircularProgressIndicator(color: Colors.blue,));
          }
          if(itemProvider.currentStatus == Status.addCategorySuccess||
            itemProvider.currentStatus == Status.emptyCart
          ){
            return ListView.separated(
                itemBuilder: (_,index){
                    return _itemWidget(itemProvider,index);
                },
                separatorBuilder: (_,index){
                  return const SizedBox(height: 10,);
                },
                itemCount: itemProvider.listItems.length
            );
          }
          return ListView.separated(
              itemBuilder: (_,index){
                return _itemWidget(itemProvider,index);
                //return _itemWidget(itemProvider.listItems[index],itemProvider.listItems[index].isAdd);
              },
              separatorBuilder: (_,index){
                return const SizedBox(height: 10,);
              },
              itemCount: itemProvider.listItems.length
          );
      },
      ),
    );
  }

  Widget _itemWidget(ItemProvider itemProvider, int index){
     im.ItemModel itemModel = itemProvider.listItems[index];
    bool visible = itemProvider.listItems[index].isAdd;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            itemModel.name,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                     Visibility(
                        visible: visible,
                        child: const Positioned(
                          child: Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                        )),
                    Visibility(
                      visible: !visible,
                      child: Positioned(
                        child: GestureDetector(
                          onTap: () {
                            context.read<ItemProvider>().addCart(itemModel);
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartWidget(int total, bool hasItems,ItemProvider itemProvider) {
    if (total > 0) {
      hasItems = true;
    }
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ChangeNotifierProvider<ItemProvider>.value(
                  value: itemProvider,
                  child: const CartPage(),
                )));
        // //_categoryCubit.getItemCart();
      },
      child: SizedBox(
        height: 60,
        width: 60,
        child: Stack(
          children: [

            const Positioned.fill(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),),
            Visibility(
              visible: hasItems,
              child: Positioned(
                  right: 15,
                  top: 5,
                  child: Text(
                    '$total',
                    style: const TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
