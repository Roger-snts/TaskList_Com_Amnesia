import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
            onSurface: Colors.white, onPrimary: Color(0xFF014040)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Lista de Tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentindex = 0;
  late List pages;

  List<Map<String, dynamic>> fisicList = [
    {"title": "Dark", "description": "WEB"},
    {"title": "Mode", "description": "WEB"},
    {"title": "rkMo", "description": "WEB"},
    {"title": "kM", "description": "WEB"},
  ];

  @override
  void initState() {
    pages = [
      ListPage(fisicList: fisicList),
      CreateListItem(
        titleController: TextEditingController(),
        descriptionController: TextEditingController(),
        createItem: createItem,
      )
    ];
    super.initState();
  }

  void createItem(TextEditingController title, TextEditingController subtitle) {
    return fisicList
        .add({"title": title.text, "description": subtitle.text.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: pages[_currentindex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF731702),
          iconSize: 35,
          selectedFontSize: 16,
          currentIndex: _currentindex,
          onTap: (value) {
            setState(() {
              _currentindex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_sharp), label: "Notas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_note_sharp), label: "Nova")
          ]),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.fisicList});

  final List<Map<String, dynamic>> fisicList;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        itemCount: widget.fisicList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 100,
            shadowColor: const Color(0xFF731702),
            child: ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              tileColor: const Color(0xFF02735E),
              leading: const Icon(Icons.sticky_note_2_rounded,
                  color: Color(0xFFF27405)),
              title: Text(widget.fisicList[index]["title"].toString()),
              subtitle: Text(widget.fisicList[index]["description"].toString()),
              trailing: IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Color(0xFF03A678),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Text("AVISO"),
                                ),
                                Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Color(0xFF03A678),
                                ),
                              ],
                            ),
                    content: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Marcar esta tarefa como concluída?"),
                    ),
                    actions: [
                      Container(
                        color: const Color(0x96014040),
                        child: CupertinoDialogAction(
                          onPressed: () {
                            setState(() {
                              widget.fisicList.removeAt(index);
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text("Sim"),
                        ),
                      ),
                      Container(
                        color: const Color(0x6B014040),
                        child: CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Não"),
                        ),
                      )
                    ],
                  ),
                ),
                icon: const Icon(Icons.task_alt_rounded),
                color: const Color(0xFF03A678),
              ),
            ),
          );
        });
  }
}

class CreateListItem extends StatefulWidget {
  const CreateListItem(
      {super.key,
      required this.titleController,
      required this.descriptionController,
      required this.createItem});
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Function createItem;

  @override
  State<CreateListItem> createState() => _CreateListItemState();
}

class _CreateListItemState extends State<CreateListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "NOVA TAREFA",
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              controller: widget.titleController,
              autocorrect: true,
              cursorColor: const Color(0xFFF27405),
              minLines: 1,
              maxLines: 2,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(label: Text("Título")),
            ),
            TextFormField(
              controller: widget.descriptionController,
              autocorrect: true,
              cursorColor: const Color(0xFFF27405),
              minLines: 1,
              maxLines: 4,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(label: Text("Descrição")),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(24),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    backgroundColor: const Color(0xFF014040)),
                onPressed: () {
                  setState(() {
                    if (widget.descriptionController.text.isNotEmpty &&
                        widget.descriptionController.text.isNotEmpty) {
                      widget.createItem(
                          widget.titleController, widget.descriptionController);
                      widget.titleController.clear();
                      widget.descriptionController.clear();
                      showDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.verified_outlined,
                                  color: Color(0xFF03A678),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Text("SUCESSO"),
                                ),
                                Icon(
                                  Icons.verified_outlined,
                                  color: Color(0xFF03A678),
                                ),
                              ],
                            ),
                            content: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text("Tarefa adicionada à lista."),
                            ),
                            actions: [
                              Container(
                                color: const Color(0x96014040),
                                child: CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Fechar"),
                                ),
                              ),
                            ]),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                  title: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.dangerous_outlined,
                                        color: Color(0xFFF27405),
                                      ),
                                      Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                        child: Text("AVISO"),
                                      ),
                                      Icon(
                                        Icons.dangerous_outlined,
                                        color: Color(0xFFF27405),
                                      ),
                                    ],
                                  ),
                                  content: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                        "Deve haver ao menos um Título e uma Descrição."),
                                  ),
                                  actions: [
                                    Container(
                                      color: const Color(0x96F27405),
                                      child: CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Fechar"),
                                      ),
                                    ),
                                  ]));
                    }
                  });
                },
                label: const Text("Adicionar à Lista"),
                icon: const Icon(Icons.edit_square))
          ],
        ),
      ),
    );
  }
}
