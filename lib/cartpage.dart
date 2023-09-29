import 'package:flutter/material.dart';

import 'data.dart';
import 'db.dart';
import 'my_colors.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  SqlDb sql = SqlDb();
  List<Map> products = [];

  Future<List<Map>> readData() async {
    List<Map> response = await sql.read("products");
    products.clear();
    products.addAll(response);

    if (mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myOrange,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
      ListView.builder(
        itemCount: products.length,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SizedBox(
              height: 120, child: _productList(context, products, index));
        },
      ),
      bottomNavigationBar:  Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: MyColors.myOrange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: MyColors.grayBackground,
                  blurRadius: 10,
                  offset: Offset(-5, -5))
            ]),
        child: Row(
          children: [
            const Spacer(),
            Container(
              child: MaterialButton(
                onPressed: () async {
                  // int response = await sql.insert('products', {
                  //   "title":Data.generateProductId(widget.productId).title,
                  //   "type":Data.generateProductId(widget.productId).type,
                  //   "description":Data.generateProductId(widget.productId).description,
                  //   "image":Data.generateProductId(widget.productId).image,
                  //   "price":Data.generateProductId(widget.productId).price,
                  //   "amount":Data.amount,
                  //   "total_price": Data.generateProductId(widget.productId).price
                  // });
                  // if (response > 0 ) {
                  //   print('created Database ############');
                  //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Cart(),), (route) => true);
                  // }
                },
                splashColor: Colors.lightBlueAccent,
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                child: const Text("Check Out",
                    style:
                    TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),

    );
  }

  updateAmount() {
    setState(() {
      readData();
    });
  }

  Widget _productList(BuildContext context, List products, int i) {
    return Card(
      elevation: 10,
      child: Center(
        child: ListTile(
          isThreeLine: true,
          subtitleTextStyle: const TextStyle(height: 2),
          leading: Image.asset(products[i]['image']),
          title: Text(
            '${products[i]['title']}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${products[i]['type']}\ntotal price: ${{
              (products[i]['price'] * products[i]['amount'])
            }} \$ ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Container(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () async {


                      int response = await sql.delete(
                          'products', 'id = ${products[i]['id']}');

                      if (response > 0) {
                        products.removeWhere(
                            (element) => element['id'] == products[i]['id']);
                        setState(() {});
                      }
                    },
                    child: const Icon(Icons.clear)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          if (products[i]['amount'] != 1){

                          int response = await sql.update(
                              'products',
                              {
                                "title": products[i]['title'],
                                "type": products[i]['type'],
                                "description": products[i]['description'],
                                "image": products[i]['image'],
                                "price": products[i]['price'],
                                "amount": products[i]['amount'] - 1,
                                "total_price": products[i]['price'] *
                                        products[i]['amount'] -
                                    1
                              },
                              "id = ${products[i]['id']}");
                          if (response > 0) {
                            readData();
                            setState(() {});
                          }
                          }

                        },
                        child: const Icon(
                          Icons.remove,
                          color: MyColors.myOrange,
                        )),
                    const Spacer(),
                    Text(
                      '${products[i]['amount']}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () async {
                          {
                            int response = await sql.update(
                                'products',
                                {
                                  "title": products[i]['title'],
                                  "type": products[i]['type'],
                                  "description": products[i]['description'],
                                  "image": products[i]['image'],
                                  "price": products[i]['price'],
                                  "amount": products[i]['amount'] + 1,
                                  "total_price": products[i]['price'] *
                                          products[i]['amount'] +
                                      1
                                },
                                "id = ${products[i]['id']}");
                            if (response > 0) {
                              setState(() {
                                readData();
                              });
                            }
                          }
                        },
                        child: const Icon(
                          Icons.add,
                          color: MyColors.myOrange,
                        )),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
