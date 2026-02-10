import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'internet_state_service.dart';

class InternetStateServiceInternetPlusImplementation
    implements InternetStateService {
  @override
  Future<bool> isConnected() async {
    try {
      final internetConnection = InternetConnection();
      return !(await internetConnection.internetStatus ==
          InternetStatus.disconnected);
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<bool> connectionStream() {
    final internetConnection = InternetConnection();

    return internetConnection.onStatusChange.map(
      (status) => status == InternetStatus.connected,
    );
  }
}
