package com.sammyun.service.impl.friendship;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sammyun.dao.friendship.FriendshipDao;
import com.sammyun.entity.Member;
import com.sammyun.entity.MemberDeviceInfo;
import com.sammyun.entity.friendship.Friendship;
import com.sammyun.entity.message.Message;
import com.sammyun.huanxin.EasemobIMUsers;
import com.sammyun.plugin.MessagePushPlugin;
import com.sammyun.service.friendship.FriendshipService;
import com.sammyun.service.impl.BaseServiceImpl;
import com.tencent.xinge.XingeApp;

/**
 * Friendship * ServiceImpl - 
 * 
 * @author Sencloud Team
 * @version 3.0
 */
@Service("friendshipServiceImpl")
public class FriendshipServiceImpl extends BaseServiceImpl<Friendship, Long> implements FriendshipService
{
    
    @Resource(name = "easemobIMUsers")
    private EasemobIMUsers easemobIMUsers;
    
    @Resource(name = "friendshipDaoImpl")
    private FriendshipDao friendshipDao;

    @Resource(name = "friendshipDaoImpl")
    public void setBaseDao(FriendshipDao friendshipDao)
    {
        super.setBaseDao(friendshipDao);
    }

    @Override
    public void createFriendship()
    {
        List<Friendship> friendships = friendshipDao.findFriendship(false, 10);
        if (friendships != null && friendships.size() != 0)
        {
            for (Friendship friendship : friendships)
            {
                 String ownerUserPrimaryKey = friendship.getOwnerUserPrimaryKey();
                 String friendUserPrimaryKey = friendship.getFriendUserPrimaryKey();
                 easemobIMUsers.addFriend(ownerUserPrimaryKey, friendUserPrimaryKey);
                 friendship.setHasCreated(true);
                 this.update(friendship);
            }
               
        }
    }

}
