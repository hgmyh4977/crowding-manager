package cn.myh.crowdfunding.service;

import cn.myh.crowdfunding.domain.User;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

/**
 * description: UserService <br>
 * date: 2020/9/3 10:49 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
public interface UserService {
    public User queryUser(User form) throws UserException;

    List<User> pageQuery(Map<String, Object> map);

    User queryUserByLoginacct(String loginacct);

    int queryUserCount(Map<String, Object> map);

    void addUser(User form) throws UserException;

    void deleteUsers(Map<String, Object> map);

    void deleteUser(Integer userid);

    User queryUserById(Integer id);

    void updateUser(User form);
}
