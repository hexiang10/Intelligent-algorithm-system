package com.ruoyi.ai.car;

/**
 * 系统错误提示
 * @author yuxue
 * @date 2018-09-07
 */
public enum ErrorEnum {

  // 200-->Success!
  // 6000-->Fail！

  // common
  COMMON_ERROR("Fail！", 6000),
  COMMON_PARAMS_ERR("提交参数不合法", 6001),
  COMMON_PARAMS_ID_ERR("提交参数ID不合法", 6002),
  COMMON_EMPTY_CONDITION_RESULT("没有找到符合条件的数据", 6003),
  COMMON_PARAMS_NOT_EXIST("提交的字段不存在,或者参数格式错误", 6004),

  // sql
  SQL_ERROR("mysql通用错误", 6100),
  SQL_INSERT_FAIL("增加失败", 6101),
  SQL_DELETE_FAIL("删除失败", 6102),
  SQL_UPDATE_FAIL("修改失败", 6103),
  SQL_RECORD_EXIST("添加重复记录", 6104),
  SQL_ID_NOT_EXIST("主键ID不能为空", 6105),
  SQL_VERSION_NOT_EXIST("数据版本version不能为空", 6106),

  // io
  FILE_IO_ERROR("io通用错误", 6200),
  FILE_NOT_EXIST("文件没找到，请联系管理员", 6201),
  FILE_DATA_NULL("文档中不不存在有效的数据", 6202),
  FILE_DATA_ERR("文档中的数据格式错误", 6203),

  // form
  INVALID_PASSWORD("密码格式错误", 6300),
  INVALID_EMAIL("邮件格式错误", 6301),
  INVALID_NAME("账号格式错误", 6302),
  INVALID_PARAMS("填写字段不合法", 6303),


  // shiro-login
  NO_LOGIN("用户未登录", 401),
  UNAUTHORIZED("权限不足", 7001),
  ADMIN_ONLY("只有管理员账号可以调用这个接口", 6402),
  NO_PERSSIOM("没有权限请求", 6403),
  WRONG_ACCOUNT_OR_PSW("账号或密码错误", 6404),
  WRONG_ACCOUNT_PSW("账号密码错误", 6405),
  WRONG_ACCOUNT_WRONG("用户没有权限（令牌、用户名、密码错误）", 401),

  // uploading
  UPLOAD_FILE_TYPE_ERROR("上传文件格式错误", 6500),
  UPLOAD_FILE_UPLOADING("uploading", 6501),
  UPLOAD_FILE_NOT_EXIST("文件不存在", 6502),
  UPLOAD_FILE_SIZE_MAX("上传的文件大小超出限制", 6503),

  // es
  ES_BIG_PAGE_SEARCH("单页查询数据不能超过10000!", 9000);

  // NoSQL

  public final String msg;
  public final int code;

  ErrorEnum(String msg, int code) {
    this.msg = msg;
    this.code = code;
  }
}
