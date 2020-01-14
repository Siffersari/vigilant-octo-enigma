

import 'package:postgres/postgres.dart';
import 'package:test_dart/src/db-handler.dart';
import 'package:test_dart/src/server.dart';

class Person {
  String name;
  int age;
//  Person(String name,int age) {
//    this.age = age;
//    this.name=name;
//  }
  Person({
    this.name,this.age
  });
}

class Persons {
  List<Person> persons = [
    Person(name: "Douglas",age: 12),
    Person(age: 34,name: "Leewell"),Person(age: 20,name: "Douglas"),
    Person(age: 34,name: "Leewell"),Person(age: 20,name: "Douglas"),
    Person(age: 34,name: "Leewell"),
  ];
  
  static List<String> getNames(List<Person> persons){
    return persons.map((person){
      return person.name;
    }).toList();
  }
  static List<int> getAges(List<Person> persons){
    // persons.forEach((f)=>print(f.name));
    return persons.map((person)=>person.age+20).toList();
  }
}

main(List<String> args) async{
  // args.forEach(((f)=>print(f)));
  // var persons = Persons();
  // var agesList = Persons.getAges(persons.persons);
  // agesList.forEach((f)=>print(f));

  PostgreSQLConnection connection = PostgreSQLConnection('localhost', 5432, 'product_app', username: 'leewel');

  DbAdapter adapter;

  await connection.open();

  if (connection.isClosed) {  
    print('Problem with connections');
    
  }
  else {
    adapter = DbAdapter(connection: connection );

    // var products = await adapter.getProducts(10);
    // products.forEach((f){
    //   print(f);
    // });

    var httpFw = await initServer(adapter);
    await httpFw.startServer('localhost',3001);
  }


}