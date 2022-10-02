import 'package:flutter/material.dart';

import '../model/item_model.dart';

class ItemProvider extends ChangeNotifier{

  List<ItemModel> listItems = [];
  List<ItemModel> cart = [];
  Status currentStatus = Status.init;

  Future<void> addItem(List<ItemModel> list) async {
    listItems.addAll(list);
    currentStatus = Status.addingCategory;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    currentStatus = Status.addCategorySuccess;
    notifyListeners();
  }

  Future<void> addCart(ItemModel itemModel) async {
    //currentStatus = Status.addingCart;
    cart.add(itemModel);
    currentStatus = Status.addCartSuccess;
    getItem();
    notifyListeners();
  }

  void getItem(){
   // print('cart: $cart');
    for(ItemModel itemModel1 in items){
        if(cart.contains(itemModel1)){
          itemModel1.isAdd = true;
        }else{
          itemModel1.isAdd = false;
        }

      //print('item:  $items');
    }


  }

  void getCartItem() {
    //print('cart: $cart');
    for (ItemModel itemModel1 in items) {
      for(ItemModel itemModel2 in cart){
        if(itemModel1.id != itemModel2.id){
          if (itemModel1.isAdd == true) {
            cart.add(itemModel1);
          }
        }
      }

      //print('item:  $items');
    }
  }

    // currentStatus = Status.addCartSuccess;
    // notifyListeners();


   Future<void>removeItem(ItemModel itemModel) async {
    currentStatus = Status.removingCart;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    cart.removeWhere((element) => element.id==itemModel.id);
    if(cart.isEmpty){
      currentStatus = Status.emptyCart;
    }else{
      currentStatus = Status.removeCartSuccess;
    }
    notifyListeners();
  }

}

enum Status{
  init,
  addCartSuccess,
  addingCart,
  removeCartSuccess,
  removingCart,
  addingCategory,
  addCategorySuccess,
  emptyCart,
  emptyCategory,
}