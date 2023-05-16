import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';


class ContentPage extends StatefulWidget {
  const ContentPage({Key? key, this.word}) : super(key: key);

  final String? word;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: rootBundle.loadString(widget.word!= null? 'words/${widget.word}.txt' : 'home.txt'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Html(
                  data: snapshot.data,
                  style: _style(),
                  customRender: _customRender(),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }

  Map<String, CustomRender> _customRender() {
    return {
      'u': (context, parsedChild) {
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                        color: Colors.grey[500]!,
                        width: 5,
                      ))),
              child: parsedChild,
            ),
          ],
        );
      },
      'i': (context, parsedChild) {
        return Row(
          children: [Expanded(child: parsedChild)],
        );
      }
    };
  }

  Map<String, Style> _style() {
    return {
      '.word': Style(
          color: const Color.fromRGBO(157, 23, 77, 1),
          fontSize: FontSize.rem(
            1.5,
          )),
      'U': Style(color: const Color.fromRGBO(6, 95, 70, 1)),
      'SUP': Style(color: const Color.fromRGBO(30, 64, 175, 1)),
      'TT': Style(color: const Color.fromRGBO(30, 64, 175, 1)),
      'p': Style(fontWeight: FontWeight.w500, fontSize: FontSize.rem(1.2)),
      'ul': Style(fontWeight: FontWeight.w400, fontSize: FontSize.rem(1.1)),
    };
  }
}
