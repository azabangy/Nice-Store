import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imageview360/imageview360.dart';
import 'package:shoesapp/cartpage.dart';
import 'package:shoesapp/cubit/card_cubit.dart';
import 'package:shoesapp/db.dart';

import 'dashboard_screen.dart';
import 'data.dart';
import 'my_colors.dart';
// @override
// void initState() {
//   super.initState();
//   updateImageList(context);
// }
//
// void updateImageList(BuildContext context) {
//   for (int i = 1; i <= 21; i++) {
//     imageList.add(AssetImage('assets/s$i.png'));
//   }
// }
class DetailScreen extends StatelessWidget {
  int productId;

  DetailScreen({Key? key, required this.productId}) : super(key: key);

  SqlDb sql = SqlDb();

  List<ImageProvider> imageList = <ImageProvider>[];

  bool autoRotate = false;

  int rotationCount = 22;

  int swipeSensitivity = 2;

  bool allowSwipeToRotate = true;

  bool imagePrecached = true;

  List<Widget> buildColorWidgets() {
    return Data.generateCategories()
        .map(
          (e) => Container(
            padding: const EdgeInsets.only(left: 5, bottom: 10, top: 15),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: e.id == 1 ? MyColors.myOrange : Colors.white),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  e.image,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: MyColors.myOrange,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          "Men's Shoes",
          style: TextStyle(color: MyColors.myOrange),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<CardCubit>(context).readData();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Cart(),));
            },
            child: Stack(
                alignment: Alignment.center,
                children:[
                  Image.asset("assets/card.png",height: 30,width: 30,),
                  Positioned(
                      right: 0,
                      top: 2,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            shape: BoxShape.circle
                        ),
                        child: Text('4',style: TextStyle(color: Colors.white),),))
                ] ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: size.width - 30,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: Image.asset("assets/ring.png"),
                        )),
                    // ImageView360(
                    //   key: UniqueKey(),
                    //   imageList: imageList,
                    //   autoRotate: autoRotate,
                    //   rotationCount: rotationCount,
                    //   swipeSensitivity: swipeSensitivity,
                    //   allowSwipeToRotate: allowSwipeToRotate,
                    //   onImageIndexChanged: (currentImageIndex) {
                    //     print("currentImageIndex: $currentImageIndex");
                    //   },
                    // ),
                  ],
                ),
              ),
              Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: MyColors.grayBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: Data.generateProductId(productId)
                                    .title,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async{
                                BlocProvider.of<CardCubit>(context).addToCard(context, productId);

                                // int response = await sql.insert('products', {
                                //   "title":Data.generateProductId(productId).title,
                                //   "type":Data.generateProductId(productId).type,
                                //   "description":Data.generateProductId(productId).description,
                                //   "image":Data.generateProductId(productId).image,
                                //   "price":Data.generateProductId(productId).price,
                                //   "amount":Data.amount,
                                //   "total_price": Data.generateProductId(productId).price
                                // });
                                // if (response > 0 ) {
                                //   print('created Database ############');
                                //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Cart(),), (route) => true);
                                // }
                              },
                              splashColor: Colors.lightBlueAccent,
                              color: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(10),
                              child: const Text("Pay it",
                                  style: TextStyle(color: Colors.white,fontSize: 20)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            RichText(
                              textAlign: TextAlign.start,
                              text: const TextSpan(
                                  text: "5.0",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                  )),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            RichText(
                              textAlign: TextAlign.start,
                              text: const TextSpan(
                                  text: "(1125 Review)",
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16.0,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text:
                                  Data.generateProductId(productId).type,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16.0,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: Data.generateProductId(productId)
                                  .description,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16.0,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text:
                                      'Price: ${Data.generateProductId(productId).price.toString()} \$',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.0,
                                  )),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: const TextSpan(
                              text: "Select Color :",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20.0,
                              )),
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: buildColorWidgets(),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
