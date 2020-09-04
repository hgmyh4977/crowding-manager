package cn.myh.crowdfunding.dao;

import cn.myh.crowdfunding.domain.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * description: UserDao <br>
 * date: 2020/9/3 10:51 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
public interface UserDao {
    @Select("select * from t_user where loginacct=#{loginacct} and loginpwd=#{loginpwd}")
    public User queryUser(User form);

    List<User> pageQuery(Map<String, Object> map);

    int queryUserCount(Map<String, Object> map);

    @Insert("insert into t_user (username,loginacct,loginpwd,email,createtime) values(#{username},#{loginacct},#{loginpwd},#{email},#{createtime})")
    void addUser(User form);

    @Select("select * from t_user where loginacct=#{loginacct}")
    User queryByLoginacct(String loginacct);

    void deleteUsers(Map<String, Object> map);

    @Delete("delete from t_user where id=#{userid}")
    void deleteUserById(Integer userid);

    @Select("select * from t_user where id=#{id}")
    User queryUserById(Integer id);

    @Update("update t_user set username=#{username},loginacct=#{loginacct},email=#{email},createtime=#{createtime} where id=#{id}")
    void updateUser(User form);
}
