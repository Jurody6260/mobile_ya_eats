import 'package:flutter/material.dart';
import 'package:mobile_ya_eats/models/category.dart';

import '../../../constants.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: SizedBox(
          height: 25,
          child: FutureBuilder<List<Category>>(
            future: fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => buildCategory(
                    snapshot.data![index].id,
                    snapshot.data![index].name,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text("Has Error");
              }
              return const Text("Loading");
            },
          )),
    );
  }

  Widget buildCategory(int id, String catName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = id;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              catName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == id ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: kDefaultPadding / 4),
              height: 1,
              width: 30,
              color: selectedIndex == id ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
