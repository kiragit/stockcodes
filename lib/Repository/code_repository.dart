import 'package:stockcodes/dao/code_dao.dart';
import 'package:stockcodes/entity/code.dart';

class CodeRepository {
  final codeDao = CodeDao();
  Future getAllCades(user) => codeDao.selectByUser(user);
  Future insertCode(user, Code code) => codeDao.create(user, code);
  Future updateCode(user, id, Code code) => codeDao.updateByID(user, id, code);
  Future deleteCodeById(user, String id) => codeDao.deleteByID(user, id);
}
