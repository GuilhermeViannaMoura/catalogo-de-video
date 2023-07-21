class Genero{
  final int? id;
  final String name;
  

  const Genero({required this.name, this.id});

  factory Genero.fromJson(Map<String,dynamic> json) => Genero(
    id: json['id'],
    name: json['name']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name
  };

}