import 'package:flutter/material.dart';
import 'package:sample_app_create/repository/contentController.dart';
import 'package:sample_app_create/repository/local_repository.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myController = TextEditingController();
  final itemsController = ContentController();

  @override
  ContentController contentController = ContentController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  _makeList(List data) {
    return ListView.separated(
      itemBuilder: (BuildContext _context, int index) {
        return Container(
          child: Row(
            children: [
              Text(data[index]),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) {
        return Container(height: 1, color: Colors.black.withOpacity(0.4));
      },
      itemCount: data.length,
    );
  }

  Future<List<dynamic>?> _loadContentList() async {
    return await contentController.loadContent();
  }

  Widget _readdate() {
    return FutureBuilder(
        future: _loadContentList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("데이터 오류"));
          }
          if (snapshot.hasData) {
            return _makeList(snapshot.data as List);
          }
          return Center();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                // 컨트롤러에 필드 myController를 부여
                controller: myController,
              ),
            ),
            ElevatedButton(
              child: Icon(Icons.print),
              onPressed: () => itemsController.insertinput(myController.text),
            ),
            _readdate(),
          ],
        ),
      ),
    );
  }
}
