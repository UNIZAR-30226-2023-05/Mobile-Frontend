import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:oca_app/pages/social.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import '../backend_funcs/peticiones_api.dart';
import '../components/ChatMessages.dart';
import '../components/User_instance.dart';
import '../components/socket_class.dart';

class ChatPriv extends StatelessWidget {
  String friendNickname;
  ChatPriv({super.key, required this.friendNickname});

  // Atributos para controlar el chat privado
  List<ChatMessage> messages = [];
  static final BehaviorSubject<ChatMessage> chatController =
      BehaviorSubject<ChatMessage>();
  final TextEditingController msgCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<List<ChatMessage>> cargarHistorialMensajes() async {
    final completer = Completer<List<ChatMessage>>();
    completer
        .complete(SocketSingleton.instance.getMessagesHistory(friendNickname));
    messages = await completer.future;

    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cargarHistorialMensajes(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // O cualquier otro indicador de carga
          } else {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: const Color.fromARGB(255, 28, 100, 116),
                appBar: AppBar(
                  toolbarHeight: 80,
                  elevation: 5,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white70,
                  flexibleSpace: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              // Cerrar sesión de chat privado
                              SocketSingleton.instance.cerrarSesionChat();

                              // Volver a lista de amigos
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  friendNickname,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.settings,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: SafeArea(
                    child: Container(
                  color: const Color.fromARGB(255, 195, 250, 254),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                          child: StreamBuilder<ChatMessage>(
                              stream: chatController.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<ChatMessage> snapshot) {
                                if (snapshot.hasData) {
                                  final name = snapshot.data?.username;
                                  // Si no es un msg mío o del jugador con el que tengo el chat, no se muestra
                                  if (name == User_instance.instance.nickname ||
                                      name == friendNickname) {
                                    messages.add(snapshot.data!);
                                  }
                                }
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  // Ajusta el scroll a la posición más reciente
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                });
                                return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: messages.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          left: 14,
                                          right: 14,
                                          top: 10,
                                          bottom: 10),
                                      child: Align(
                                        alignment:
                                            (messages[index].messageType ==
                                                    "receiver"
                                                ? Alignment.topLeft
                                                : Alignment.topRight),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: (messages[index]
                                                          .messageType ==
                                                      "receiver"
                                                  ? Colors.grey.shade200
                                                  : Colors.blue[200]),
                                            ),
                                            padding: const EdgeInsets.all(16),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    messages[index].username,
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 4.0),
                                                  Text(messages[index]
                                                      .messageContent),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                );
                              })),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 10, top: 10),
                          height: 60,
                          width: double.infinity,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  //
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: msgCtrl,
                                  decoration: const InputDecoration(
                                      hintText: "Escribe un mensaje",
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  if (msgCtrl.text != "") {
                                    // Comunicación con el stream (actualización local)
                                    chatController.sink.add(ChatMessage(
                                        username:
                                            User_instance.instance.nickname,
                                        messageContent: msgCtrl.text,
                                        messageType: "sender"));

                                    // Enviar mensaje a socket (actualización)
                                    SocketSingleton.instance.enviarMsgChatPriv(
                                        friendNickname, msgCtrl.text);

                                    // Limpiar textBox
                                    msgCtrl.clear();
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                backgroundColor: Colors.blue,
                                elevation: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
          }
        });
  }

  static void chatMsgRecevied(String friendName, String msg) {
    ChatPriv.chatController.sink.add(ChatMessage(
        username: friendName, messageContent: msg, messageType: "receiver"));
  }
}
