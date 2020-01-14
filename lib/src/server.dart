import 'dart:convert';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/http.dart';
import 'package:test_dart/src/db-handler.dart';

Future<AngelHttp>  initServer(DbAdapter dbAdapter) async {

  Angel angel = Angel();
  var http = AngelHttp(angel);

  angel.get('/', (req,res) async{
    var prodcuts = await dbAdapter.getProducts(10);
    res.json(prodcuts.map((f)=>f.toMap()).toList());
  });

  angel.post('/products', (req, res) async {
    await req.parseBody();
    var body = req.bodyAsMap;
    if(body['Name']!=null){
      if(body['Price']!=null){
        var product = Product(productName: body['Name'],price: body['Price'],description: body['Description'] ?? "Description not provided");
        await dbAdapter.postProduct(product);
        res.json(product.toMap());
      }
    } else{
      res.writeln("Error occured");
    }
    print(body);
  });
  return http;
}