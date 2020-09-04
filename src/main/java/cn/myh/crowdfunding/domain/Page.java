package cn.myh.crowdfunding.domain;

import java.util.List;

/**
 * description: Page <br>
 * date: 2020/9/3 15:07 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
public class Page<T> {
    private Integer pageno;
    private Integer pagesize;
    private Integer totalno;
    private List<T> datas;

    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        this.pageno = pageno;
    }

    public Integer getPagesize() {
        return pagesize;
    }

    public void setPagesize(Integer pagesize) {
        this.pagesize = pagesize;
    }

    public Integer getTotalno() {
        return totalno;
    }

    public void setTotalno(Integer totalno) {
        this.totalno = totalno;
    }

    public List<T> getDatas() {
        return datas;
    }

    public void setDatas(List<T> datas) {
        this.datas = datas;
    }
}
