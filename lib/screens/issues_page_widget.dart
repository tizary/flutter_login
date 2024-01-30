import 'package:flutter/material.dart';
import '../models/issues.dart';
import '../server/api_sentry_issues.dart';

class IssuesPageWidget extends StatefulWidget {
  const IssuesPageWidget({super.key});

  @override
  State<IssuesPageWidget> createState() => _IssuesPageWidgetState();
}

class _IssuesPageWidgetState extends State<IssuesPageWidget> {
  Future getIssues() async {
    List<Issues> issuesList = [];
    var resultList = await ApiSentryIssues.getIssues();
    if (resultList != null) {
      for (var result in resultList) {
        issuesList.add(Issues.fromMap(result));
      }
    }
    return issuesList;
  }

  @override
  Widget build(BuildContext context) {
    const styleText = TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FutureBuilder(
        future: getIssues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
            if (snapshot.hasData) {
              final List<Issues> data = snapshot.data;
              if (data.isEmpty) {
                return const Center(
                  child: Text('no issues'),
                );
              }
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Issue ${index + 1}',
                          style: styleText,
                        ),
                        RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                              const TextSpan(text: 'Title: ', style: styleText),
                              TextSpan(text: data[index].title),
                            ])),
                        RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                              const TextSpan(text: 'Type: ', style: styleText),
                              TextSpan(text: data[index].metadataType),
                            ])),
                        RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                              const TextSpan(text: 'Value: ', style: styleText),
                              TextSpan(text: data[index].metadataValue),
                            ])),
                        const Divider(),
                      ],
                    );
                  });
            }
          }
          return const Text('data');
        },
      ),
    );
  }
}
