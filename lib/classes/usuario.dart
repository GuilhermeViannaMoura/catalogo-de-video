class Usuario{
  final int? id;
  final String name;
  final String email;
  final String password;

  const Usuario({required this.name, required this.email, this.id, required this.password});

  factory Usuario.fromJson(Map<String,dynamic> json) => Usuario(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password' : password
  };
}