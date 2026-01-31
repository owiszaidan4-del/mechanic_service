class Stategetstateofwork {}

class InitState extends Stategetstateofwork {}

class StateSucssesgetstateOfWork extends Stategetstateofwork {
  final bool stateOfWork;
  final bool available;
  StateSucssesgetstateOfWork({
    required this.stateOfWork,
    required this.available,
  });
}

class StatefaieldgetstateOfWork extends Stategetstateofwork {
  final String err;
  StatefaieldgetstateOfWork({required this.err});
}
