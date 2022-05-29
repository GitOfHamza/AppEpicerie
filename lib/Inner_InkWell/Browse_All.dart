import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/No%20data.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_application_1/Widgets/Product_Info.dart';
import 'package:flutter_application_1/Widgets/Products.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BrowseAll extends StatefulWidget {
  const BrowseAll({Key? key}) : super(key: key);

  @override
  State<BrowseAll> createState() => _BrowseAllState();
}

class _BrowseAllState extends State<BrowseAll> {
  final TextEditingController? searchController = TextEditingController();
  final FocusNode searchFocusController = FocusNode();

  @override
  void dispose() {
    searchController!.dispose();
    searchFocusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool __isEmpty = false;
    Size __size = MyTools(context).getScreenSize;
    final Color couleur = MyTools(context).color;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tous les Produits',
          style: TextStyle(color: couleur, fontWeight: FontWeight.bold),
        ),
        leading: const BackLastPage(),
        elevation: 0,
        
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: __isEmpty
          ? const PageIsEmpty()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocusController,
                        onChanged: (valeur) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.blue.shade200, width: 2),
                          ),
                          hintText: "A quoi penses-tu ?",
                          prefixIcon: const Icon(Icons.search_outlined),
                          suffixIcon: IconButton(
                              onPressed: () {
                                searchController!.clear();
                                searchFocusController.unfocus();
                              },
                              icon: Icon(
                                Icons.close_outlined,
                                color: searchFocusController.hasFocus
                                    ? Colors.red
                                    : couleur,
                              )),
                        ),
                      ),
                    ),
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // crossAxisSpacing: 2,
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      childAspectRatio: __size.width / (__size.height * 0.55),
                      children: List.generate(16, (index) {
                        return const Products();
                      })),
                ],
              ),
            ),
    );
  }
}
