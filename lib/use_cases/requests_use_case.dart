import '../repositories/requests_repo/requests_repo.dart';

class RequestsUseCase {
  final RequestsRepo requestsRepo;
  RequestsUseCase({required this.requestsRepo});
  Future<void> sendRequest({required Map<String, dynamic> data}) async {
    return requestsRepo.sendRequest(data: data);
  }
}
