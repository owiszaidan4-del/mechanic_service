class StatesRegesterauthtransaction {}

class state_Inetial extends StatesRegesterauthtransaction {}

class state_success extends StatesRegesterauthtransaction {}

class state_failed extends StatesRegesterauthtransaction {
  state_failed({required this.typeFailed});
  final String typeFailed;
}
