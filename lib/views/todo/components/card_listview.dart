import 'package:flutter/material.dart';

class CardListView extends StatelessWidget {
  const CardListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.isLoading,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        child: Builder(builder: (_) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (itemCount == 0) {
            return const Center(
              child: Text("Está tudo vazio por aqui!"),
            );
          }
          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          );
        }),
      ),
    );
  }
}
