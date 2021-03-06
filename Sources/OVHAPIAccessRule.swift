//
//  OVHAPIAccessRule.swift
//
//  Copyright (c) 2016, OVH SAS.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  * Neither the name of OVH SAS nor the
//  names of its contributors may be used to endorse or promote products
//  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY OVH SAS AND CONTRIBUTORS ``AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL OVH SAS AND CONTRIBUTORS BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import Foundation
import Alamofire

/**
The different methods of the OVH APIs.
*/
public enum OVHAPIMethod : String {
    case get = "GET", post = "POST", delete = "DELETE", put = "PUT", head = "HEAD", options = "OPTIONS", path = "PATH", trace = "TRACE", connect = "CONNECT"
}

/**
This struct represents a rule to access the OVH APIs.
*/
public struct OVHAPIAccessRule {
    
    // MARK: - Static properties
    
    fileprivate static let cachedAllRights : [OVHAPIAccessRule] = {
        return OVHAPIAccessRule.allRights(forPath: "/*")
    }()
    
    fileprivate static let cachedReadOnlyRights : [OVHAPIAccessRule] = {
        return OVHAPIAccessRule.readOnlyRights(forPath: "/*")
    }()
    
    
    // MARK: - Properties
    
    // HTTP method to apply the rules.
    public let method: OVHAPIMethod
    
    // Pattern to apply the rules (i.e. "/*", "/vps/*").
    public let path: String
    
    
    // MARK: - Lifecycle
    
    /**
    Initializes the `OVHAPIAccessRule` instance with the specified method and path.
    
    - parameter method: The method of the rule.
    - parameter path:   The path of the rule.
    
    - returns: The new `OVHAPIWrapper` instance.
    */
    public init(method: OVHAPIMethod, path: String) {
        self.method = method
        self.path = path
    }
    
    
    // MARK: - Methods
    
    /**
    Returns this rule to a NSDictionary object representation.
    */
    public func dictionaryRepresentation() -> [String:String] {
        return ["method": method.rawValue, "path": path]
    }
    
    
    // MARK: - Static methods
    
    /**
     Shorthand to get all the rights (read and write) on all the API.
    
     - returns: An array of access rules.
     */
    public static func allRights() -> [OVHAPIAccessRule] {
        return OVHAPIAccessRule.cachedAllRights
    }
    
    /**
     Shorthand to get all the rights (read and write) on some paths of the API.
     
     - parameter path:  The path to access.
     
     - returns: An array of access rules.
     */
    public static func allRights(forPath path: String) -> [OVHAPIAccessRule] {
        return [OVHAPIAccessRule(method: .get, path: path), OVHAPIAccessRule(method: .post, path: path), OVHAPIAccessRule(method: .put, path: path), OVHAPIAccessRule(method: .delete, path: path)]
    }
    
    /**
     Shorthand to get the read-only rights on all the API.
    
     - returns: An array of access rules.
     */
    public static func readOnlyRights() -> [OVHAPIAccessRule] {
        return OVHAPIAccessRule.cachedReadOnlyRights
    }
    
    /**
     Shorthand to get the read-only rights on some paths of the API.
     
     - parameter path:  The path to access.
     
     - returns: An array of access rules.
     */
    public static func readOnlyRights(forPath path: String) -> [OVHAPIAccessRule] {
        return [OVHAPIAccessRule(method: .get, path: path)]
    }
}
