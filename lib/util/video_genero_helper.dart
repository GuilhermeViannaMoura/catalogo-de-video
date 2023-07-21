import 'package:videos/classes/genero.dart';
import 'package:videos/classes/video_genero.dart';
import 'package:videos/controller/db_controller.dart';
import '../classes/video.dart';
import '../classes/usuario.dart';



Map<int,List<Genero>>? getMapGenerosByVideoId(List<Genero> generos, List<VideoGenero> videoGenero){
  Map<int,List<Genero>> map = Map();
  for(int i = 0; i < videoGenero.length;i ++){
    int generoId = videoGenero[i].genreId;
    int videoId = videoGenero[i].videoId;
    Genero? genero;
    for(int j = 0; j < generos.length;j ++){
      if(generos[j].id == generoId){
        genero = generos[j];
      }
    }
    if(map.containsKey(videoId)){
      List<Genero> updateGeneros = map[videoId]!;
      updateGeneros.add(genero!);
      map.update(videoId, (value) => updateGeneros);
    }else{
      map.addAll({videoId:[genero!]});
    }
  }
  if(map.isEmpty){
    return null;
  }
  return map;
}


void setUp(DataBaseController controller) async {
    
  bool userCheck = await controller.checkCadastro('email');

  if (userCheck) {
        Genero genero1 = Genero(
          name: "Aventura",
          );
        Genero genero2 = Genero(
          name: "Acao",
        );
        Genero genero3 = Genero(
          name: "Suspense",
        );
        Genero genero4 = Genero(
          name: "Terror",
        );
        Genero genero5 = Genero(
          name: "Drama",
        );
        Genero genero6 = Genero(
          name: "Comedia",
        );
        int genero1Id = await controller.addGenero(genero1);
        int genero2Id = await controller.addGenero(genero2);
        await controller.addGenero(genero3);
        await controller.addGenero(genero4);
        await controller.addGenero(genero5);
        int genero6Id = await controller.addGenero(genero6);
       
        Usuario user = Usuario(name: 'name', email: 'email', password: 'password');
        int idUser = await controller.addUsuario(user);
        Video video1 = Video(
            title: "Vídeo 1",
            description: "Descrição do Vídeo 1",
            type: 0,
            ageRestriction: "Livre",
            durationMinutes: 150,
            releaseDate: "2023-01-01",
            idUsuario: idUser,
        );

        Video video2 = Video(
            title: "Vídeo 2",
            description: "Descrição do Vídeo 2",
            type: 1,
            ageRestriction: "18+",
            durationMinutes: 105,
            releaseDate: "2023-03-15",
            idUsuario: idUser,
        );

        List<int> video1Generos = [genero1Id, genero2Id];
        List<int> video2Generos = [genero6Id];
        await controller.addVideo(video1, video1Generos);
        await controller.addVideo(video2, video2Generos);
  }else{
      print('setup feito');
  }
  }