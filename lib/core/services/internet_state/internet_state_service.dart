abstract class InternetStateService {
  Future<bool> isConnected();


  Stream<bool> connectionStream();
}