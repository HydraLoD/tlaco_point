import 'package:postgres/postgres.dart';
import 'package:tlaco_point/models/puesto.dart';
import 'package:tlaco_point/providers/dbConnection_provider.dart';

class GetUserStandsService {
  static Future<List<Puesto>> buscar({
    String pEMAIL,
  }) async {
    PostgreSQLConnection connection =
        await DbConnectionProvider.postgreSql.connection;

    List<Map<String, Map<String, dynamic>>> result = await connection
        .mappedResultsQuery('''SELECT F.id_franquicia,
       F.nombre_franquicia,
       F.especialidad,
       S.id_sucursal,
       S.latitud::DOUBLE PRECISION,
       S.longitud::DOUBLE PRECISION
FROM tp_franquicia F
INNER JOIN tp_sucursal S ON f.id_franquicia = S.id_franquicia
INNER JOIN tp_usuarios T on F.id_dueno = T.id_usuario
WHERE T.email = @pEMAIL''',
            substitutionValues: {"pEMAIL": pEMAIL.toLowerCase()});

    //print(result);

    final puestos = Puestos.fromJsonList(result);
    //print(puestos.items[0].tpFranquicia.nombreFranquicia);

    return puestos.items;
  }
}
