class Cadastrar {
  String nome ='';
  String ra='';
  String curso='';
  String email='';
  String senha='';
  String imagem='';

  Cadastrar({
    required this.nome,
    required this.ra,
    required this.curso,
    required this.email,
    required this.senha,
    required this.imagem,
  });


  Map<String, dynamic> toMap(){
  
    var map = <String, dynamic>{
      'nome' : nome,
      'ra': ra,
      'curso' : curso,
      'email' : email,
      'senha' : senha,
      'imagem' : imagem
    };
    return map;
  }

  Cadastrar.fromMap(Map<dynamic,dynamic> map){
    nome = map['nome'];
    ra = map['ra'];
    curso = map['curso'];
    email = map['email'];
    senha = map['senha'];
    imagem = map['imagem'];
  } 

}