import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesapp/cartpage.dart';
import 'cubit/card_cubit.dart';
import 'data.dart';
import 'detail_screen.dart';
import 'my_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> buildCategories() {
    return Data.generateCategories()
        .map(
          (e) => Container(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      e.id == 1 ? Colors.white : Colors.black38),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      e.id == 1 ? MyColors.myOrange : Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: MyColors.grayBackground,
                      child: Image.asset(
                        e.image,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(e.title, style: const TextStyle(fontSize: 14)),
                ],
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
            icon: Image.asset("assets/ic_menu.png"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            shape: BoxShape.circle
                          ),
                          child:  Text('${BlocProvider.of<CardCubit>(context).cardItemCount}',
                            style: TextStyle(color: Colors.white),),))
                  ] ),
            ),
            const SizedBox(width: 10,),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/img_banner.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: "New Release",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: const TextSpan(
                            text: "Nike Air\nMax 90",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 28),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.myBlack),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                            onPressed: () {},
                            child: Text("  Buy now  ".toUpperCase(),
                                style: const TextStyle(fontSize: 14))),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: buildCategories(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                textAlign: TextAlign.start,
                text: const TextSpan(
                    text: "New Men's",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.count(
              childAspectRatio: 0.9,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(5.0),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: Data.generateProducts()
                  .map(
                    (e) => Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 20,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(productId: e.id-1),));
                          },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                e.image,
                                height: 90,
                                width: double.infinity,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: e.type,
                                    style: const TextStyle(
                                        color: MyColors.myOrange,
                                        fontSize: 16.0)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: e.title,
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 18.0)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: "\$ ${e.price}",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black87),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)))),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.myOrange,
          onPressed: () {
            print('OK');
          },
          tooltip: "start FAB",
          elevation: 4.0,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Image.asset("assets/ic_shop.png"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Cart(),));
                },
              ),
              IconButton(
                icon: Image.asset("assets/ic_wishlist.png"),
                onPressed: () {},
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                icon: Image.asset("assets/ic_notif.png"),
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset("assets/ic_notif.png"),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
