import 'package:smartgarden_app/models/observation.dart';
import 'package:smartgarden_app/models/post.dart';
import 'package:smartgarden_app/controllers/remote_service.dart';
import 'package:flutter/material.dart';

import '../models/observation_set.dart';

class DemoFetchAPI extends StatefulWidget {
  const DemoFetchAPI({Key? key}) : super(key: key);

  @override
  _DemoFetchAPIState createState() => _DemoFetchAPIState();
}

class _DemoFetchAPIState extends State<DemoFetchAPI> {
  // List<Post>? posts;
  ObservationSet? observationSet;
  var data;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getData();
  }

  // getData() async {
  //   posts = await RemoteService().getPosts();
  //   if (posts != null) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  getData() async {
    // observationSet = await RemoteService().getObservations();
    data = observationSet?.value;
    if (observationSet != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observations'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          // itemCount: posts?.length,
          itemCount: observationSet?.value.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          observationSet!.value[index].resultTime.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // posts![index].body ?? '',
                          observationSet!.value[index].result.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
