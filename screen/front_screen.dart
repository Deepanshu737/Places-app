import 'package:favourite_places/model/blueprint.dart';
import 'package:favourite_places/widget/inside_screen.dart';
import 'package:favourite_places/screen/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places/provider/consumer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FrontScreen extends ConsumerStatefulWidget {
  const FrontScreen({super.key});

  @override
  ConsumerState<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends ConsumerState<FrontScreen> {
  late Future<void> onAddData;
  late Future<void> onDeleteData;
  @override
  void initState() {
    onAddData = ref.watch(screenProvider.notifier).onLoadingData();
    onDeleteData=ref.watch(screenProvider.notifier).onDeleteData();
    super.initState();
  }

  void nxtScreen(BuildContext context) async {
    final newItem = await Navigator.of(context).push<Blueprint>(
      MaterialPageRoute(builder: ((context) => SecondScreen())),
    );
    if (newItem != null) {
      ref.watch(screenProvider.notifier).getData(newItem);
      //this step is necessary as if it's not there the app will not work as i am sending info.from second_screen but never conveying it to front_screen
    } else {
      return;
    }
  }
  @override
  Widget build(context) {
    final cScreen = ref.watch(screenProvider);
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(15),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          Text(
            'Your Places',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              nxtScreen(context);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: cScreen.length,
          itemBuilder: (ctx, index) {
            return Dismissible(confirmDismiss: (direction) async {
              await onDeleteData;
              return true;
            },
              onDismissed: (direction) {
                ref.watch(screenProvider.notifier).getData(cScreen[index]);
              },
              key: ValueKey(cScreen[index].id),
              child: FutureBuilder(
                future: onAddData,
                builder: (ctx, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundImage: FileImage(cScreen[index].image),
                        ), //FileImage is atype of ImageProvider
                        title: Text(
                          cScreen[index].name,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        contentPadding: EdgeInsets.only(bottom: 0.1),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => InsideScreen(cScreen[index]),
                            ),
                          );
                        },
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
