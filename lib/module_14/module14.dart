import 'package:flutter/material.dart';
import 'package:flutter_10_batch/module_14/ProductController.dart';
import 'package:flutter_10_batch/module_14/widget/ProductCard.dart';

class Module14 extends StatefulWidget {
  const Module14({super.key});

  @override
  State<Module14> createState() => _Module14State();
}

class _Module14State extends State<Module14> {
  final ProductController productController = ProductController();
   Future<void>fetchData ()async {
     await productController.fetchProducts();
     print(productController.products.length);
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    void productDialog({String ? id, String ? name,String ? img, int ? qty, int ? UnitPrice,int ? totalPrice,required bool isupdate}) {
      TextEditingController productNameController = TextEditingController();
      TextEditingController productQTYController = TextEditingController();
      TextEditingController productImageController = TextEditingController();
      TextEditingController productUnitPriceController =
          TextEditingController();
      TextEditingController productTotalPriceController =
          TextEditingController();

      productNameController.text = name ?? '';
      productImageController.text = img ?? '';
      productQTYController.text = qty != null ? qty.toString() : '0';
      productUnitPriceController.text = UnitPrice != null ? UnitPrice.toString() : '0';
      productTotalPriceController.text = totalPrice != null ? totalPrice.toString() : '0';

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(isupdate ? 'Edit product':'Add product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'product name'),
                  ),
                  TextField(
                    controller: productImageController,
                    decoration: InputDecoration(labelText: 'product image'),
                  ),
                  TextField(
                    controller: productQTYController,
                    decoration: InputDecoration(labelText: 'product qty'),
                  ),
                  TextField(
                    controller: productUnitPriceController,
                    decoration: InputDecoration(
                      labelText: 'product unit price',
                    ),
                  ),
                  TextField(
                    controller: productTotalPriceController,
                    decoration: InputDecoration(labelText: 'total price'),
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () async {

                            productController.CreateUpdateProducts(
                              productNameController.text,
                              productImageController.text,
                              int.parse(productQTYController.text.trim()),
                              int.parse(productUnitPriceController.text.trim()),
                              int.parse(productTotalPriceController.text.trim()),

                              id,isupdate



                            ) .then((
                                valur,
                                ) async {
                              if (valur) {
                                await productController.fetchProducts();
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isupdate ? 'product updated':'Product Created'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Something wrong.....!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            });

                            Navigator.pop(context);
                             await fetchData();
                            setState(() {

                            });
                          },

                        child: Text(isupdate ? 'Update Product':'Add product'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product CRUD'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemCount: productController.products.length,
        itemBuilder: (context, indext) {
          var product = productController.products[indext];
          return ProductCard(
            onEdit: () {
              productDialog(name:product.productName, img:product.img,id:product.sId , UnitPrice:product.unitPrice, totalPrice:product.totalPrice,qty:product.qty,isupdate: true);
            },
            onDelete: () {
              productController.DeleteProducts(product.sId.toString())
                  .then((
                valur,
              ) async {
                if (valur) {
                  await productController.fetchProducts();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product Deleted'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Something wrong.....!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
            product: product,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(isupdate: false),
        child: Icon(Icons.add),
      ),
    );
  }
}
