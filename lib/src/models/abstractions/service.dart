// abstract class RpcAbstract<R, T> implements EndpointBase<R, T> {
//   @override
//   Future<R> request(T data);
// }

abstract class ServiceAbstract {
  final Object addRpc;
  final Object addAllRpc;
  final Object getAllRpc;
  final Object deleteRpc;
  final Object deleteAllRpc;

  const ServiceAbstract({
    required this.addRpc,
    required this.addAllRpc,
    required this.getAllRpc,
    required this.deleteRpc,
    required this.deleteAllRpc,
  });
}

abstract class ServiceArticleAbstract extends ServiceAbstract {
  final Object getCalibresRpc;
  final Object addAllCalibresRpc;
  final Object updateLineRpc;
  final Object deleteForeverLineRpc;
  final Object updateArticleRpc;
  final Object createLineArticleRpc;
  final Object createArticleRpc;
  final Object deleteForeverArticleRpc;
  final Object deleteAllCalibresRpc;

  ServiceArticleAbstract({
    required this.getCalibresRpc,
    required this.addAllCalibresRpc,
    required this.updateLineRpc,
    required this.deleteForeverLineRpc,
    required this.updateArticleRpc,
    required this.createLineArticleRpc,
    required this.createArticleRpc,
    required this.deleteForeverArticleRpc,
    required this.deleteAllCalibresRpc,
  }) : super(
            addRpc: createLineArticleRpc,
            addAllRpc: addAllCalibresRpc,
            getAllRpc: getCalibresRpc,
            deleteRpc: deleteForeverLineRpc,
            deleteAllRpc: deleteAllCalibresRpc);
}

abstract class ServiceTicketAbstract {
  final Object addTicketRpc;
  final Object disableTicketRpc;
  final Object getAllTicketsRpc;
  final Object restoreTicketRpc;
  final Object addAllTicketsRpc;
  final Object deleteTicketRpc;
  final Object deleteAllTicketsRpc;

  const ServiceTicketAbstract({
    required this.addTicketRpc,
    required this.disableTicketRpc,
    required this.getAllTicketsRpc,
    required this.restoreTicketRpc,
    required this.addAllTicketsRpc,
    required this.deleteTicketRpc,
    required this.deleteAllTicketsRpc,
  });
}
