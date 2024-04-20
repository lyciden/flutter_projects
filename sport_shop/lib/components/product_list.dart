import 'package:flutter/material.dart';
import 'package:sport_shop/global_variables.dart';
import 'package:sport_shop/components/product_card.dart';
import 'package:sport_shop/pages/product_detail_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}


class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Addidas',
    'Nike',
    'Bata'
  ];

  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  List<dynamic> get filteredProducts {
    if (selectedFilter == 'All') {
      return products;
    } else {
      return products.where((product) => product['company'] == selectedFilter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(225, 225, 225, 1),
                      ),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                      ),
                    );
    return SafeArea(
        child: Column(
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                "Shoes\nCollection",
                style : Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                )
              ),
            ],
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: ((context, index) {
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, 
                      ),
                      child: GestureDetector(
                        onTap:() {
                         setState(() {
                           selectedFilter = filter;
                         }); 
                        } ,
                        child: Chip(
                          backgroundColor: selectedFilter == filter ? Theme.of(context).colorScheme.primary: const Color.fromRGBO(245, 247, 249, 1),
                          label: Text(filter),
                          labelStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          shape: const StadiumBorder(
                            side : BorderSide(
                              color: Color.fromRGBO(245, 247, 249, 1),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                      ),
                    );
                  }),
                ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                  if(constraints.maxWidth > 1080){
                    return GridView.builder(
                    itemCount: filteredProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.75,
                      ),
                      itemBuilder: (context, index ){
                        final product = filteredProducts[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context){
                                  return ProductDetailsPage(product: product);
                                },
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product['title'] as String, 
                            price: product['price'] as double, 
                            image: product['imageUrl'] as String,
                            backgroundColor : index.isEven ? const Color.fromRGBO(215, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1), ),
                        );
                      },
                    );
                  }else{
                    return  ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context){
                              return ProductDetailsPage(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String, 
                        price: product['price'] as double, 
                        image: product['imageUrl'] as String,
                        backgroundColor : index.isEven ? const Color.fromRGBO(215, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1), ),
                    );                  
                  },
                );
                  }
                },
              ),
            ),

          ],
        ),
      );
  }
}