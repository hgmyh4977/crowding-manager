package cn.myh.crowdfunding.service;

/**
 * description: UserException <br>
 * date: 2020/9/3 10:58 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
public class UserException extends Exception{
    public UserException() {
        super();
    }

    public UserException(String message) {
        super(message);
    }
}
