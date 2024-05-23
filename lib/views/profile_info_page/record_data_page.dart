import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/record_data_page/record_data_bloc.dart';
import 'package:jalur/bloc/record_data_page/record_data_event.dart';
import 'package:jalur/bloc/record_data_page/record_data_state.dart';

class RecordDataPage extends StatefulWidget {
  const RecordDataPage({super.key});

  @override
  State<RecordDataPage> createState() => _RecordDataPageState();
}

class _RecordDataPageState extends State<RecordDataPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecordDataBloc>().add(LoadRecordDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("История записей"),
      ),
      body: BlocBuilder<RecordDataBloc, RecordDataState>(
        builder: (context, state) {
          if (state is LoadingRecordDataState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadRecordDataSuccess) {
            return ListView.builder(
              itemCount: state.records.length,
              itemBuilder: (context, index) {
                final record = state.records[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Запись №${record.id}'),
                    subtitle: Text('Дата создания: ${record.createdAt}'),
                    trailing: TextButton(
                        onPressed: () {}, child: const Text('Отменить')),
                  ),
                );
              },
            );
          } else if (state is RecordErrorState) {
            return Center(
              child: Text('Ошибка: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('Нет данных о записях'),
            );
          }
        },
      ),
    );
  }
}
