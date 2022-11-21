import 'package:cafebanter/Utils/cafeBanterConstantColors.dart';
import 'package:cafebanter/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class CafeBanterHomePageView extends StatelessWidget {
  const CafeBanterHomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Image.asset("assets/cafeBanter-removebg.png"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => DecisionTimeLogin()));
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              "Current Availabe Products @Cafe",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc("yhPR6ekC1DbfcvaSgMf0rnT4pU73")
                    .collection("Products")
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: CafeBanterColors.appMainColor,
                      ),
                    );
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.food_bank),
                            title: Text(
                              "₹ ${data['price']} ${data["name"]} #${data["category"]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("${data["description"]}"),
                            trailing: IconButton(
                              onPressed: () {
                                var uuid = Uuid().v4();
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection("Cart")
                                    .doc(uuid)
                                    .set({
                                  "name": data["name"],
                                  "price": data["price"],
                                  "category": data["category"],
                                  "description": data["description"],
                                  "id": uuid
                                }).then((value) {
                                  Fluttertoast.showToast(msg: "Added to Cart");
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
