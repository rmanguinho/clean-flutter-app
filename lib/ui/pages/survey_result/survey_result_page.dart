import 'package:flutter/material.dart';

import './survey_result.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';

class SurveyResultPage extends StatelessWidget
    with LoadingManager, SessionManager {
  final SurveyResultPresenter presenter;

  SurveyResultPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(R.string.surveyResult)),
      body: Builder(
        builder: (BuildContext context) {
          handleLoading(context, presenter.isLoadingStream);
          handleSessionExpired(presenter.isSessionExpiredStream);
          presenter.loadData();

          return StreamBuilder<SurveyResultViewModel?>(
            stream: presenter.surveyResultStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<SurveyResultViewModel?> snapshot,
            ) {
              if (snapshot.hasError) {
                return ReloadScreen(
                  error: '${snapshot.error}',
                  reload: presenter.loadData,
                );
              }
              if (snapshot.hasData) {
                return SurveyResult(
                  viewModel: snapshot.data!,
                  onSave: presenter.save,
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
