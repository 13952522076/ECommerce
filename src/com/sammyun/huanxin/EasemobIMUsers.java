package com.sammyun.huanxin;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.glassfish.jersey.client.JerseyWebTarget;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.sammyun.huanxin.comm.Constants;
import com.sammyun.huanxin.comm.HTTPMethod;
import com.sammyun.huanxin.comm.Roles;
import com.sammyun.huanxin.utils.JerseyUtils;
import com.sammyun.huanxin.vo.ClientSecretCredential;
import com.sammyun.huanxin.vo.Credential;
import com.sammyun.huanxin.vo.EndPoints;

/**
 * REST API Demo : 用户体系集成 Jersey2.9实现 Doc URL:
 * http://www.easemob.com/docs/rest/userapi/
 * 
 * @author Lynch 2014-09-09
 */
@Service("easemobIMUsers")
public class EasemobIMUsers {

    private static Logger LOGGER = LoggerFactory.getLogger(EasemobIMUsers.class);

    private static final String APPKEY = Constants.APPKEY;

    private static JsonNodeFactory factory = new JsonNodeFactory(false);

    // 通过app的client_id和client_secret来获取app管理员token
    private static Credential credential = new ClientSecretCredential(Constants.APP_CLIENT_ID,
            Constants.APP_CLIENT_SECRET, Roles.USER_ROLE_APPADMIN);

    /**
     * 注册IM用户[单个]
     */
    public ObjectNode createUserSingle(String username, String password)
    {
        ObjectNode datanode = JsonNodeFactory.instance.objectNode();
        datanode.put("username", username);
        datanode.put("password", password);
        ObjectNode createNewIMUserSingleNode = createNewIMUserSingle(datanode);
        return createNewIMUserSingleNode;
    }

    /**
     * IM用户登录
     */
    public ObjectNode userLogin(String username, String password)
    {
        ObjectNode datanode = JsonNodeFactory.instance.objectNode();
        datanode.put("username", username);
        datanode.put("password", password);
        ObjectNode imUserLoginNode = imUserLogin(datanode.get("username").asText(), datanode.get("password").asText());
        return imUserLoginNode;
    }

    /**
     * 注册IM用户[批量生成用户然后注册]
     */
    public ObjectNode createUserBatch(List<String> usernames, String password)
    {
        int perNumber = 10;
        int totalNumber = usernames.size();
        ObjectNode createNewIMUserBatchGenNode = createNewIMUserBatchGen(usernames, password, perNumber, totalNumber);
        return createNewIMUserBatchGenNode;
    }

    /**
     * 获取IM用户[主键查询]
     */
    public void getUsersByPrimaryKey(String userPrimaryKey)
    {
        ObjectNode getIMUsersByPrimaryKeyNode = getIMUsersByPrimaryKey(userPrimaryKey);
        if (null != getIMUsersByPrimaryKeyNode)
        {
            LOGGER.info("获取IM用户[主键查询]: " + getIMUsersByPrimaryKeyNode.toString());
        }
    }

    /**
     * 重置IM用户密码 提供管理员token
     */
    public ObjectNode modifyUserPassword(String username, String newpassword)
    {
        ObjectNode json2 = JsonNodeFactory.instance.objectNode();
        json2.put("newpassword", newpassword);
        ObjectNode modifyIMUserPasswordWithAdminTokenNode = modifyIMUserPasswordWithAdminToken(username, json2);
        return modifyIMUserPasswordWithAdminTokenNode;
    }

    /**
     * 添加好友[单个]
     */
    public ObjectNode addFriend(String ownerUserPrimaryKey, String friendUserPrimaryKey)
    {
        ObjectNode addFriendSingleNode = addFriendSingle(ownerUserPrimaryKey, friendUserPrimaryKey);
        return addFriendSingleNode;
    }

    /**
     * 查看好友
     */
    public ObjectNode viewFriends(String ownerUserPrimaryKey)
    {
        ObjectNode getFriendsNode = getFriends(ownerUserPrimaryKey);
        return getFriendsNode;
    }

    /**
     * 解除好友关系
     **/
    public void deleteFriend(String ownerUserPrimaryKey, String friendUserPrimaryKey)
    {
        ObjectNode deleteFriendSingleNode = deleteFriendSingle(ownerUserPrimaryKey, friendUserPrimaryKey);
        if (null != deleteFriendSingleNode)
        {
            LOGGER.info("解除好友关系: " + deleteFriendSingleNode.toString());
        }
    }

    /**
     * 删除IM用户[单个]
     */
    public ObjectNode deleteUserByUserPrimaryKey(String userPrimaryKey)
    {
        ObjectNode deleteIMUserByUserPrimaryKeyNode = deleteIMUserByUserPrimaryKey(userPrimaryKey);
        return deleteIMUserByUserPrimaryKeyNode;
    }

    /**
     * 删除IM用户[批量]
     */
    public void deleteIMUserByUsernameBatch()
    {
        Long limit = 2l;
        ObjectNode deleteIMUserByUsernameBatchNode = deleteIMUserByUsernameBatch(limit, null);
        if (null != deleteIMUserByUsernameBatchNode)
        {
            LOGGER.info("删除IM用户[批量]: " + deleteIMUserByUsernameBatchNode.toString());
        }
    }

    /**
     * 注册IM用户[单个] 给指定AppKey创建一个新的用户
     * 
     * @param dataNode
     * @return
     */
    public static ObjectNode createNewIMUserSingle(ObjectNode dataNode)
    {

        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        objectNode.removeAll();

        // check properties that must be provided
        if (null != dataNode && !dataNode.has("username"))
        {
            LOGGER.error("Property that named username must be provided .");

            objectNode.put("message", "Property that named username must be provided .");

            return objectNode;
        }
        if (null != dataNode && !dataNode.has("password"))
        {
            LOGGER.error("Property that named password must be provided .");

            objectNode.put("message", "Property that named password must be provided .");

            return objectNode;
        }

        try
        {
            JerseyWebTarget webTarget = null;
            webTarget = EndPoints.USERS_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                    "app_name", APPKEY.split("#")[1]);

            objectNode = JerseyUtils.sendRequest(webTarget, dataNode, credential, HTTPMethod.METHOD_POST, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 注册IM用户[批量] 给指定AppKey创建一批用户
     * 
     * @param dataArrayNode
     * @return
     */
    public static ObjectNode createNewIMUserBatch(ArrayNode dataArrayNode)
    {
        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);
            objectNode.put("message", "Bad format of Appkey");
            return objectNode;
        }

        // check properties that must be provided
        if (dataArrayNode.isArray())
        {
            for (JsonNode jsonNode : dataArrayNode)
            {
                if (null != jsonNode && !jsonNode.has("username"))
                {
                    LOGGER.error("Property that named username must be provided .");

                    objectNode.put("message", "Property that named username must be provided .");

                    return objectNode;
                }
                if (null != jsonNode && !jsonNode.has("password"))
                {
                    LOGGER.error("Property that named password must be provided .");

                    objectNode.put("message", "Property that named password must be provided .");

                    return objectNode;
                }
            }
        }

        try
        {

            JerseyWebTarget webTarget = null;
            webTarget = EndPoints.USERS_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                    "app_name", APPKEY.split("#")[1]);

            objectNode = JerseyUtils.sendRequest(webTarget, dataArrayNode, credential, HTTPMethod.METHOD_POST, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 注册IM用户[批量生成用户然后注册] 给指定AppKey创建一批用户
     * 
     * @param usernamePrefix 生成用户名的前缀
     * @param perNumber 批量注册时一次注册的数量
     * @param totalNumber 生成用户注册的用户总数
     * @return
     */
    public static ObjectNode createNewIMUserBatchGen(List<String> usernames, String password, int perNumber,
            int totalNumber)
    {
        ObjectNode objectNode = factory.objectNode();

        if (totalNumber == 0 || perNumber == 0)
        {
            return objectNode;
        }
        ArrayNode genericArrayNode = factory.arrayNode();

        for (String username : usernames)
        {
            ObjectNode userNode = factory.objectNode();
            userNode.put("username", username);
            userNode.put("password", password);
            genericArrayNode.add(userNode);
        }
        if (totalNumber <= perNumber)
        {
            objectNode = EasemobIMUsers.createNewIMUserBatch(genericArrayNode);
        }
        else
        {

            for (int i = 0; i < genericArrayNode.size(); i++)
            {
                ArrayNode tmpArrayNode = factory.arrayNode();
                tmpArrayNode.add(genericArrayNode.get(i));
                // 300 records on one migration
                if ((i + 1) % perNumber == 0)
                {
                    objectNode = EasemobIMUsers.createNewIMUserBatch(genericArrayNode);
                    tmpArrayNode.removeAll();
                    continue;
                }

                // the rest records that less than the times of 300
                if (i > (genericArrayNode.size() / perNumber * perNumber - 1))
                {
                    objectNode = EasemobIMUsers.createNewIMUserBatch(genericArrayNode);
                    tmpArrayNode.removeAll();
                }
            }
        }

        return objectNode;
    }

    /**
     * 获取IM用户
     * 
     * @param userPrimaryKey 用户主键：username或者uuid
     * @return
     */
    public static ObjectNode getIMUsersByPrimaryKey(String userPrimaryKey)
    {
        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        // check properties that must be provided
        if (StringUtils.isEmpty(userPrimaryKey))
        {
            LOGGER.error("The primaryKey that will be useed to query must be provided .");

            objectNode.put("message", "The primaryKey that will be useed to query must be provided .");

            return objectNode;
        }

        try
        {

            JerseyWebTarget webTarget = null;
            webTarget = EndPoints.USERS_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                    "app_name", APPKEY.split("#")[1]).path(userPrimaryKey);

            objectNode = JerseyUtils.sendRequest(webTarget, null, credential, HTTPMethod.METHOD_GET, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 删除IM用户[单个] 删除指定AppKey下IM单个用户
     * 
     * @param userPrimaryKey
     * @return
     */
    public static ObjectNode deleteIMUserByUserPrimaryKey(String userPrimaryKey)
    {
        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        try
        {
            JerseyWebTarget webTarget = null;
            webTarget = EndPoints.USERS_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                    "app_name", APPKEY.split("#")[1]).path(userPrimaryKey);

            objectNode = JerseyUtils.sendRequest(webTarget, null, credential, HTTPMethod.METHOD_DELETE, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 删除IM用户[批量] 批量指定AppKey下删除IM用户
     * 
     * @param limit
     * @param queryStr
     * @return
     */
    public static ObjectNode deleteIMUserByUsernameBatch(Long limit, String queryStr)
    {

        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        try
        {

            JerseyWebTarget webTarget = null;
            webTarget = EndPoints.USERS_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                    "app_name", APPKEY.split("#")[1]).queryParam("ql", queryStr).queryParam("limit",
                    String.valueOf(limit));

            objectNode = JerseyUtils.sendRequest(webTarget, null, credential, HTTPMethod.METHOD_DELETE, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 重置IM用户密码 提供管理员token
     * 
     * @param userPrimaryKey
     * @param dataObjectNode
     * @return
     */
    public static ObjectNode modifyIMUserPasswordWithAdminToken(String userPrimaryKey, ObjectNode dataObjectNode)
    {
        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        if (StringUtils.isEmpty(userPrimaryKey))
        {
            LOGGER.error("Property that named userPrimaryKey must be provided，the value is username or uuid of imuser.");

            objectNode.put("message",
                    "Property that named userPrimaryKey must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }

        if (null != dataObjectNode && !dataObjectNode.has("newpassword"))
        {
            LOGGER.error("Property that named newpassword must be provided .");

            objectNode.put("message", "Property that named newpassword must be provided .");

            return objectNode;
        }

        try
        {

            JerseyWebTarget webTarget = null;
            webTarget = EndPoints.USERS_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                    "app_name", APPKEY.split("#")[1]).path(userPrimaryKey).path("password");

            objectNode = JerseyUtils.sendRequest(webTarget, dataObjectNode, credential, HTTPMethod.METHOD_PUT, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 添加好友[单个]
     * 
     * @param ownerUserPrimaryKey
     * @param friendUserPrimaryKey
     * @return
     */
    public static ObjectNode addFriendSingle(String ownerUserPrimaryKey, String friendUserPrimaryKey)
    {
        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        if (StringUtils.isEmpty(ownerUserPrimaryKey))
        {
            LOGGER.error("Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            objectNode.put("message", "Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }

        if (StringUtils.isEmpty(friendUserPrimaryKey))
        {
            LOGGER.error("The userPrimaryKey of friend must be provided，the value is username or uuid of imuser.");

            objectNode.put("message",
                    "The userPrimaryKey of friend must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }

        try
        {
            JerseyWebTarget webTarget = null;
            webTarget = EndPoints.USERS_ADDFRIENDS_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                    "app_name", APPKEY.split("#")[1]).resolveTemplate("ownerUserPrimaryKey", ownerUserPrimaryKey).resolveTemplate(
                    "friendUserPrimaryKey", friendUserPrimaryKey);

            ObjectNode body = factory.objectNode();
            objectNode = JerseyUtils.sendRequest(webTarget, body, credential, HTTPMethod.METHOD_POST, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 解除好友关系
     * 
     * @param ownerUserPrimaryKey
     * @param friendUserPrimaryKey
     * @return
     */
    public static ObjectNode deleteFriendSingle(String ownerUserPrimaryKey, String friendUserPrimaryKey)
    {
        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        if (StringUtils.isEmpty(ownerUserPrimaryKey))
        {
            LOGGER.error("Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            objectNode.put("message", "Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }

        if (StringUtils.isEmpty(friendUserPrimaryKey))
        {
            LOGGER.error("The userPrimaryKey of friend must be provided，the value is username or uuid of imuser.");

            objectNode.put("message",
                    "The userPrimaryKey of friend must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }

        try
        {

            JerseyWebTarget webTarget = EndPoints.USERS_ADDFRIENDS_TARGET.resolveTemplate("org_name",
                    APPKEY.split("#")[0]).resolveTemplate("app_name", APPKEY.split("#")[1]).resolveTemplate(
                    "ownerUserPrimaryKey", ownerUserPrimaryKey).resolveTemplate("friendUserPrimaryKey",
                    friendUserPrimaryKey);

            ObjectNode body = factory.objectNode();
            objectNode = JerseyUtils.sendRequest(webTarget, body, credential, HTTPMethod.METHOD_DELETE, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * 查看好友
     * 
     * @param ownerUserPrimaryKey
     * @return
     */
    public static ObjectNode getFriends(String ownerUserPrimaryKey)
    {
        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }

        if (StringUtils.isEmpty(ownerUserPrimaryKey))
        {
            LOGGER.error("Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            objectNode.put("message", "Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }

        try
        {
            JerseyWebTarget webTarget = EndPoints.USERS_ADDFRIENDS_TARGET.resolveTemplate("org_name",
                    APPKEY.split("#")[0]).resolveTemplate("app_name", APPKEY.split("#")[1]).resolveTemplate(
                    "ownerUserPrimaryKey", ownerUserPrimaryKey).resolveTemplate("friendUserPrimaryKey", "");

            ObjectNode body = factory.objectNode();
            objectNode = JerseyUtils.sendRequest(webTarget, body, credential, HTTPMethod.METHOD_GET, null);

        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return objectNode;
    }

    /**
     * IM用户登录
     * 
     * @param ownerUserPrimaryKey
     * @param password
     * @return
     */
    public static ObjectNode imUserLogin(String ownerUserPrimaryKey, String password)
    {

        ObjectNode objectNode = factory.objectNode();

        // check appKey format
        if (!JerseyUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", APPKEY))
        {
            LOGGER.error("Bad format of Appkey: " + APPKEY);

            objectNode.put("message", "Bad format of Appkey");

            return objectNode;
        }
        if (StringUtils.isEmpty(ownerUserPrimaryKey))
        {
            LOGGER.error("Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            objectNode.put("message", "Your userPrimaryKey must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }
        if (StringUtils.isEmpty(password))
        {
            LOGGER.error("Your password must be provided，the value is username or uuid of imuser.");

            objectNode.put("message", "Your password must be provided，the value is username or uuid of imuser.");

            return objectNode;
        }

        try
        {
            ObjectNode dataNode = factory.objectNode();
            dataNode.put("grant_type", "password");
            dataNode.put("username", ownerUserPrimaryKey);
            dataNode.put("password", password);

            List<NameValuePair> headers = new ArrayList<NameValuePair>();
            headers.add(new BasicNameValuePair("Content-Type", "application/json"));

            objectNode = JerseyUtils.sendRequest(
                    EndPoints.TOKEN_APP_TARGET.resolveTemplate("org_name", APPKEY.split("#")[0]).resolveTemplate(
                            "app_name", APPKEY.split("#")[1]), dataNode, null, HTTPMethod.METHOD_POST, headers);

        }
        catch (Exception e)
        {
            throw new RuntimeException("Some errors ocuured while fetching a token by usename and passowrd .");
        }

        return objectNode;
    }

}
