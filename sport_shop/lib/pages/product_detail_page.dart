import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_shop/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
    });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}


class _ProductDetailsPageState extends State<ProductDetailsPage> {

  late int selectedSize;

  @override
  void initState() {
    selectedSize = -1;
    super.initState();
  }

  void onTapHandler(){
    if(selectedSize != -1){
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.product['id'],
          'title': widget.product['title'],
          'price': widget.product['price'],
          'imageUrl': widget.product['imageUrl'],
          'company': widget.product['company'],
          'size': selectedSize,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product added succesfully", style: TextStyle(
            fontSize: 18,
          )),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please, select a size", style: TextStyle(
            fontSize: 18,
          )),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.product['title'] as String,
            style : Theme.of(context).textTheme.titleLarge
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String,height: 250,),
          ),
          const Spacer(flex : 2),
          Container(
            height : 250,
            width: double.infinity,
            decoration:  BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Text('\$${widget.product['price'] as double}', style : Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.product['sizes'] as List<int>).length,
                  itemBuilder: (BuildContext context, int index) {
                    final size = (widget.product['sizes'] as List<int>)[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedSize == size ? Theme.of(context).colorScheme.primary : null,
                          label: Text(size.toString()),
                        ),
                      ),
                    );
                  },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: onTapHandler,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    fixedSize: const Size(350, 50)
                  ),
                  child: const Text('Add to cart', style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              ],
              ),
          )
        ],
      ),
    );
  }
}