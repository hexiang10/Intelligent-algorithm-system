package com.ruoyi.ai.car;


/**
 * 自定义runtime异常
 * @author yuxue
 * @date 2018-09-07
 */
public class ResultReturnException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    private String msg = ErrorEnum.COMMON_ERROR.msg;
    private int code = ErrorEnum.COMMON_ERROR.code;

    public ResultReturnException(ErrorEnum error) {
        super(error.msg);
        this.msg = error.msg;
        this.code = error.code;
    }

    public ResultReturnException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public ResultReturnException(String msg, Throwable e) {
        super(msg, e);
        this.msg = msg;
    }

    @Deprecated
    public ResultReturnException(String msg, int code) {
        super(msg);
        this.msg = msg;
        this.code = code;
    }

    @Deprecated
    public ResultReturnException(String msg, int code, Throwable e) {
        super(msg, e);
        this.msg = msg;
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public int getCode() {
        return code;
    }

}
