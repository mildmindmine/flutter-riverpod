import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/home/data/model/user.dart';

final likeStateProvider = StateProvider<int>((ref) {
  return 0;
});

final selectedUserProvider = StateProvider<User?>((ref) {
  return null;
});

class DetailPage extends ConsumerWidget {
  DetailPage({Key? key}) : super(key: key);

  final List<String> infoKey = ['Name', 'Username', 'Email', 'Phone'];

  Iterable<Padding> _buildInfoRow(User? userDetail, BuildContext context) {
    print('build build list');
    return infoKey.mapIndexed((index, key) {
      List<String> data = [
        userDetail?.name ?? '',
        userDetail?.username ?? '',
        userDetail?.email ?? '',
        userDetail?.phone ?? '',
      ];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('${infoKey[index]}:', style: Theme.of(context).textTheme.headline6),
            const SizedBox(width: 24),
            Text(data[index]),
          ],
        ),
      );
    });
  }

  Widget _buildFloatingButton(WidgetRef ref) {
    print('build floating');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          // access the provider via ref.read(), then increment its state.
          onPressed: () => ref.read(likeStateProvider.state).state++,
          child: const Icon(Icons.thumb_up),
          backgroundColor: Colors.green,
          heroTag: 'like-button',
        ),
        const SizedBox(
          width: 24,
        ),
        FloatingActionButton(
          // access the provider via ref.read(), then increment its state.
          onPressed: () => ref.read(likeStateProvider.state).state--,
          child: const Icon(Icons.thumb_down),
          heroTag: 'dislike-button',
          backgroundColor: Colors.red,
        )
      ],
    );
  }

  Widget _buildCounterText(WidgetRef ref) {
    print('build counter text');
    final counter = ref.watch(likeStateProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text('Like: $counter'),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Reading and listening to providers
    final userDetail = ref.read(selectedUserProvider);
    ref.listen<StateController<int>>(likeStateProvider.state, (previous, current) {
      // note: this callback executes when the provider value changes,
      // not when the build method is called
      ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Current like number is ${current.state}')),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(userDetail?.name ?? ''),
      ),
      floatingActionButton: _buildFloatingButton(ref),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16),
        child: Column(
          children: [
            ..._buildInfoRow(userDetail, context),
            _buildCounterText(ref),
          ],
        ),
      ),
    );
  }
}
