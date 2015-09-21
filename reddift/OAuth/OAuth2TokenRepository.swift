//
//  OAuth2TokenRepository.swift
//  reddift
//
//  Created by sonson on 2015/04/14.
//  Copyright (c) 2015年 sonson. All rights reserved.
//

import Foundation

/**
Repository to contain OAuth2 tokens for reddit.com based on "KeychanAccess".
You can manage mulitple accounts using this class.
OAuth2TokenRepository, is utility class, has only class method.
*/
public class OAuth2TokenRepository {
    /**
    Restores OAuth2Token from Keychain.
    
    - parameter name Specifies reddit username which was used hwne saving it into Keychain.
    - 
    */
    public class func restoreFromKeychainWithName(name:String) -> Result<OAuth2Token> {
        let keychain = Keychain(service:Config.sharedInstance.bundleIdentifier)
        do {
            if let data = try keychain.getData(name) {
                if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String:AnyObject] {
                    return Result(value:OAuth2Token(json))
                }
            }
            return Result(error: ReddiftError.Unknown.error)
        }
        catch {
            try! removeFromKeychainTokenWithName(name)
            return Result(error:error as NSError)
        }
    }
    
    public class func savedNamesInKeychain() -> [String] {
        var keys:[String] = []
        let keychain = Keychain(service:Config.sharedInstance.bundleIdentifier)
        keys += keychain.allKeys()
        return keys
    }
    
    public class func saveIntoKeychainToken(token:OAuth2Token) throws {
        if token.name.isEmpty {
            throw ReddiftError.KeychainTargetNameIsEmpty.error
        }
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(token.JSONObject(), options: NSJSONWritingOptions())
            let keychain = Keychain(service:Config.sharedInstance.bundleIdentifier)
            try keychain.set(data, key:token.name)
        }
        catch {
            throw error
        }
    }
    
    public class func saveIntoKeychainToken(token:OAuth2Token, name:String) throws {
        if name.isEmpty {
            throw ReddiftError.KeychainTargetNameIsEmpty.error
        }
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(token.JSONObject(), options: NSJSONWritingOptions())
            let keychain = Keychain(service:Config.sharedInstance.bundleIdentifier)
            try keychain.set(data, key:name)
        }
        catch {
            throw error
        }
    }
    
    public class func removeFromKeychainTokenWithName(name:String) throws {
        if name.isEmpty {
            throw ReddiftError.KeychainTargetNameIsEmpty.error
        }
        do {
            let keychain = Keychain(service:Config.sharedInstance.bundleIdentifier)
            try keychain.remove(name);
        }
        catch {
            throw error
        }
    }
}
