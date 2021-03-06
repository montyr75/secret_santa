/**
  The program must take a list of people (first name, last name) and return pairs of
  Secret Santas. A person can't be their own santa, and a person can't be a santa for someone
  with the same last name.

  Example input:

  Zoe Washburne
  Hoban Washburne
  Malcolm Reynolds
  Simon Tam
  River Tam
  Buffy Summers
  Dawn Summers
**/

final List<Person> people = [
  new Person("Zoe", "Washburne"),
  new Person("Hoban", "Washburne"),
  new Person("Malcolm", "Reynolds"),
  new Person("Simon", "Tam"),
  new Person("River", "Tam"),
  new Person("Buffy", "Summers"),
  new Person("Dawn", "Summers")
];

final List<Person> santas = new List<Person>.from(people, growable: false);

void main() {
  int iterations = 0;

  // loop until there are no more invalid pairings
  while (people.any((Person person) => !person.validSanta)) {
    // randomize the santas list
    santas.shuffle();

    // map randomized santas list to the people list
    int i = 0;
    people.forEach((person) => people[i].secretSanta = santas[i++]);

    // count iterations required to achieve a valid list (for fun)
    iterations++;
  }

  // print results
  print("Iterations required: $iterations\n");
  people.forEach((Person person) => print("${person.secretSanta} gives to $person."));
}

class Person {
  String firstName;
  String lastName;
  Person secretSanta;

  Person(this.firstName, this.lastName);

  Person.fromMap(Map<String, String> map) {
   firstName =  map["firstName"];
   lastName = map["lastName"];
  }

  // Secret Santa rules enforced here
  bool get validSanta => secretSanta != null && !identical(secretSanta, this) && secretSanta.lastName != lastName;

  Map<String, String> toMap() => {"firstName": firstName, "lastName": lastName};

  @override String toString() => "$firstName $lastName";
}