// Copyright (c) 2023 Eray Erdin
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_future_builder/get_it_future_builder.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/logic/add_favorite_form/add_favorite_form_bloc.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/repositories/station/station.repository.dart';
import 'package:izmirferry/shared/constants.dart';

class AddFavoriteDialogComponent extends StatelessWidget {
  const AddFavoriteDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetItFutureBuilder<StationRepository>(
      loading: (context) => const CircularProgressIndicator().toCenter(),
      ready: (context, stationRepo) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AddFavoriteFormBloc(
                stationRepository: stationRepo,
              )..add(
                  AddFavoriteFormEvent.changeStartStation(
                    station: allStation.firstWhere((s) => s.name == 'Konak'),
                  ),
                ),
            ),
          ],
          child: BlocBuilder<AddFavoriteFormBloc, AddFavoriteFormState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Header(),
                  const Divider(),
                  state.map(
                    processing: (state) => const LinearProgressIndicator(),
                    valid: (state) => 0.heightBox,
                  ),
                  const _Body(),
                  const Divider(),
                  const _Footer(),
                ],
              );
            },
          ).paddingAll(16),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Text('add_favorite')
        .textStyle(context.headlineMedium)
        .textAlignment(TextAlign.center)
        .tr();
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFavoriteFormBloc, AddFavoriteFormState>(
      builder: (context, state) {
        final AddFavoriteFormBloc formBloc = context.read();

        return Column(
          children: [
            const Text('departure_station')
                .textStyle(context.titleMedium)
                .textAlignment(TextAlign.center)
                .tr(),
            TextButton(
              onPressed: state.map(
                processing: (state) => null,
                valid: (state) => () async {
                  await _pickStartStation(context);
                },
              ),
              child: state.map(
                processing: (state) => Text(formBloc.startStation.name),
                valid: (state) => Text(state.favorite.startStation.name),
              ),
            ),
            const Text('destination_station')
                .textStyle(context.titleMedium)
                .textAlignment(TextAlign.center)
                .tr(),
            TextButton(
              onPressed: state.map(
                processing: (state) => null,
                valid: (state) => () async {
                  await _pickEndStation(context);
                },
              ),
              child: state.map(
                processing: (state) => Text(formBloc.endStation.name),
                valid: (state) => Text(state.favorite.endStation.name),
              ),
            ),
            _buildDayPicker(context),
          ],
        );
      },
    );
  }

  Future<void> _pickStartStation(BuildContext context) async {
    final Station? station = await showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allStation.length,
        itemBuilder: (context, index) {
          final station = allStation[index];

          return ListTile(
            title: Text(station.name),
            onTap: () {
              context.pop(result: station);
            },
          );
        },
      ),
    );

    if (station != null) {
      final AddFavoriteFormBloc formBloc = context.read();
      formBloc.add(AddFavoriteFormEvent.changeStartStation(station: station));
    }
  }

  Future<void> _pickEndStation(BuildContext context) async {
    final AddFavoriteFormBloc formBloc = context.read();

    final Station? station = await showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: formBloc.endStations.length,
        itemBuilder: (context, index) {
          final station = formBloc.endStations[index];

          return ListTile(
            title: Text(station.name),
            onTap: () {
              context.pop(result: station);
            },
          );
        },
      ),
    );

    if (station != null) {
      formBloc.add(AddFavoriteFormEvent.changeEndStation(station: station));
    }
  }

  Widget _buildDayPicker(BuildContext context) {
    return BlocBuilder<AddFavoriteFormBloc, AddFavoriteFormState>(
      builder: (context, state) {
        final AddFavoriteFormBloc formBloc = context.read();

        return Column(
          children: [
            const Text('day')
                .textStyle(context.titleMedium)
                .textAlignment(TextAlign.center)
                .tr(),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 4,
              children: [
                ChoiceChip(
                  label: const Text('always_today').tr(),
                  selected: formBloc.day == null,
                  onSelected: state.map(
                    processing: (state) => null,
                    valid: (state) => (isSelected) {
                      if (isSelected) {
                        formBloc.add(
                          const AddFavoriteFormEvent.changeDay(day: null),
                        );
                      }
                    },
                  ),
                ),
                ...Day.values
                    .map(
                      (d) => ChoiceChip(
                        label: Text(d.name).tr(),
                        selected: formBloc.day == d,
                        onSelected: state.map(
                          processing: (state) => null,
                          valid: (state) => (isSelected) {
                            if (isSelected) {
                              formBloc.add(
                                AddFavoriteFormEvent.changeDay(day: d),
                              );
                            }
                          },
                        ),
                      ),
                    )
                    .toList(growable: false),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFavoriteFormBloc, AddFavoriteFormState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: state.map(
                processing: (state) => null,
                valid: (state) => () {
                  final AddFavoriteFormBloc formBloc = context.read();
                  context.pop(
                    result: Favorite(
                      id: -1,
                      startStation: formBloc.startStation,
                      endStation: formBloc.endStation,
                      day: formBloc.day,
                      lastUpdate: DateTime.now(),
                    ),
                  );
                },
              ),
              child: const Text('add').tr(),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('cancel').tr(),
            ),
          ],
        );
      },
    );
  }
}
