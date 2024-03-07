import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SelfServicePage extends StatefulWidget {
  const SelfServicePage({super.key});

  @override
  State<SelfServicePage> createState() => _SelfServicePageState();
}

class _SelfServicePageState extends State<SelfServicePage>
    with MessageViewMixin {
  final controller = Injector.get<SelfServiceController>();

  @override
  void initState() {
    messageListener(controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startProcess();

      effect(() {
        var baseRoute = '/self-service/';
        final step = controller.step;

        switch (step) {
          case FormsSteps.none:
            return;
          case FormsSteps.whoIAm:
            baseRoute += 'whoIAm';
          case FormsSteps.findPatient:
            baseRoute += 'find-patient';
          case FormsSteps.patient:
            baseRoute += 'patient';
          case FormsSteps.documents:
            baseRoute += 'documents';
          case FormsSteps.done:
            baseRoute += 'done';
          case FormsSteps.restart:
            Navigator.of(context)
                .popUntil(ModalRoute.withName('/self-service'));
            controller.startProcess();
            return;
        }

        Navigator.of(context).pushNamed(baseRoute);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
