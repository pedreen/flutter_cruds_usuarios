import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget{

  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context){
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
    ? CircleAvatar(child: Icon(Icons.person))
    : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    // Criando um estilo para os modais de exclusão
    final ButtonStyle flatButtonStyleYes = TextButton.styleFrom(
      minimumSize: Size(88, 44),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      backgroundColor: Colors.green, // Cor de fundo verde para o botão "Sim"
    );

    final ButtonStyle flatButtonStyleNo = TextButton.styleFrom(
      minimumSize: Size(88, 44),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      backgroundColor: Colors.red, // Cor de fundo vermelha para o botão "Não"
    );
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
        children: <Widget> [
          IconButton(
             onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: user,
              );
            },
            color: Colors.orange,
            icon: Icon(Icons.edit)
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (ctx) => AlertDialog(
                  title: Text('Excluir Usuário'),
                  content: Text('Tem certeza??'),
                  actions: <Widget>[
                    TextButton(
                      style: flatButtonStyleNo,
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Não'),
                    ),
                    TextButton(
                      style: flatButtonStyleYes,
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Sim'),
                    ),
                  ],
                ),
              ).then((confirmed) {
                if(confirmed){
                  Provider.of<Users>(context, listen: false).remove(user);
                }
              });              
            }, 
            color: Colors.red,
            icon: Icon(Icons.delete),
          ),
        ], 
      ),
      ),
    );
  }
}