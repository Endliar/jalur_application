import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/record_data_page/record_data_bloc.dart';
import 'package:jalur/bloc/record_data_page/record_data_event.dart';
import 'package:jalur/bloc/record_data_page/record_data_state.dart';

import '../../helpers/colors.dart';

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
        automaticallyImplyLeading: false,
        backgroundColor: kSecondaryColor,
        title: const Text(
          "История записей",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
                    isThreeLine: true,
                    title: Text('Запись №${record.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Дата записи: ${record.visitionDate?.visitionDate ?? "Не указана"}'),
                        Text('Количество тренировок: ${record.totalTraining}'),
                        Text(
                            'Статус: ${record.visitionDate?.status ?? "Отсутствует"}'),
                      ],
                    ),
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
