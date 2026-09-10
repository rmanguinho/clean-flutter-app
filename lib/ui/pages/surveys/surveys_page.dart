import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './components/components.dart';
import './surveys.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';

class SurveysPage extends StatefulWidget {
  final SurveysPresenter presenter;

  const SurveysPage(this.presenter, {super.key});

  @override
  State<SurveysPage> createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage>
    with LoadingManager, NavigationManager, SessionManager, RouteAware {
  @override
  Widget build(BuildContext context) {
    Get.find<RouteObserver>()
        .subscribe(this, ModalRoute.of(context) as PageRoute);
    return Scaffold(
      appBar: AppBar(title: Text(R.string.surveys)),
      body: Builder(
        builder: (BuildContext context) {
          handleLoading(context, widget.presenter.isLoadingStream);
          handleSessionExpired(widget.presenter.isSessionExpiredStream);
          handleNavigation(widget.presenter.navigateToStream);
          widget.presenter.loadData();

          return StreamBuilder<List<SurveyViewModel>>(
            stream: widget.presenter.surveysStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<SurveyViewModel>> snapshot,
            ) {
              if (snapshot.hasError) {
                return ReloadScreen(
                  error: '${snapshot.error}',
                  reload: widget.presenter.loadData,
                );
              }
              if (snapshot.hasData) {
                return ListenableProvider(
                  create: (_) => widget.presenter,
                  child: SurveyItems(snapshot.data!),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  @override
  void didPopNext() {
    widget.presenter.loadData();
  }

  @override
  void dispose() {
    Get.find<RouteObserver>().unsubscribe(this);
    super.dispose();
  }
}
