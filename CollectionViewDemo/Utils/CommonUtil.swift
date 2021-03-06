//
//  CommonUtil.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 24/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit

class CommonUtil: NSObject {
    static let sharedUtil = CommonUtil()
    
    static let WEIBO_REDIRECT_URL = "https://api.weibo.com/oauth2/default.html"
    static let WEIBO_USER = "WEIBO_USER"
    
    private override init(){
    
    }
}

struct ConstantUtil {
    static let WEIBO_APPKEY = "1436716591"
    static let WEIBO_LOGIN_NOTIFICATION = "WEIBO_LOGIN_NOTIFICATION"
    
    // MARK: Weibo url list
    static let WB_COMMENT_URL = "https://api.weibo.com/2/comments/create.json"
    static let WB_GOOD_URL = "https://api.weibo.com/2/interest/like.json"
    static let WB_REPOST_URL = "https://api.weibo.com/2/statuses/repost.json"
    
    // Weibo comment
    static let ANIMATION_DURATION = 0.3
    static let COMMENT_CONTENT_HEIGHT: CGFloat = 180.0
}

extension NSUserDefaults {
    func saveCustomObject(customObject object: NSCoding, key: String) {
        let encodedObject = NSKeyedArchiver.archivedDataWithRootObject(object)
        self.setObject(encodedObject, forKey: key)
        self.synchronize()
    }
    
    func getCustomObject(forKey key: String) -> AnyObject? {
        let decodedObject = self.objectForKey(key) as? NSData
        
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObjectWithData(decoded)
            return object
        }
        
        return nil
    }
}

class WeiboUserModel: NSObject, NSCoding {
    struct PropertyKey {
        static let userIdKey = "userId"
        static let accessTokenKey = "accessToken"
        static let expirationDateKey = "expirationDate"
        static let refreshTokenKey = "refreshToken"
    }
    
    var userId: String?
    var accessToken: String?
    var expirationDate: NSDate?
    var refreshToken: String?
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userId, forKey: PropertyKey.userIdKey)
        aCoder.encodeObject(accessToken, forKey: PropertyKey.accessTokenKey)
        aCoder.encodeObject(expirationDate, forKey: PropertyKey.expirationDateKey)
        aCoder.encodeObject(refreshToken, forKey: PropertyKey.refreshTokenKey)
    }
    
    override init() {
        
    }
    
    init?(weiboUser: WBAuthorizeResponse?) {
        super.init()
        
        if let u = weiboUser {
            userId = u.userID
            accessToken = u.accessToken
            expirationDate = u.expirationDate
            refreshToken = u.refreshToken
        } else {
            return nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        userId = aDecoder.decodeObjectForKey(PropertyKey.userIdKey) as? String
        accessToken = aDecoder.decodeObjectForKey(PropertyKey.accessTokenKey) as? String
        expirationDate = aDecoder.decodeObjectForKey(PropertyKey.expirationDateKey) as? NSDate
        refreshToken = aDecoder.decodeObjectForKey(PropertyKey.refreshTokenKey) as? String
    }
}
