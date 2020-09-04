package cn.myh.crowdfunding.domain;

import org.apache.poi.ss.formula.functions.T;

/**
 * description: AjaxResult <br>
 * date: 2020/9/3 10:46 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
public class AjaxResult {
    private boolean success;
    private Object data;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
