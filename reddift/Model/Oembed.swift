//
//  Oembed.swift
//  reddift
//
//  Created by sonson on 2015/04/20.
//  Copyright (c) 2015年 sonson. All rights reserved.
//

import Foundation

/**
Media represents the content which is embeded a link.
*/
public struct Oembed {
    /**
    example, "http://i.imgur.com",
    */
    var providerUrl = ""
    /**
    example, "The Internet's visual storytelling community. Explore, share, and discuss the best visual stories the Internet has to offer.",
    */
    var description = ""
    /**
    example, "Imgur GIF",
    */
    var title = ""
    /**
    example, 245,
    */
    var thumbnailWidth = 0
    /**
    example, 333,
    */
    var height = 0
    /**
    example, 245,
    */
    var width = 0
    /**
    example, "&lt;iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Fi.imgur.com%2FkhgfcrQ.mp4&amp;src_secure=1&amp;url=http%3A%2F%2Fi.imgur.com%2FkhgfcrQ.gifv&amp;image=http%3A%2F%2Fi.imgur.com%2FkhgfcrQ.gif&amp;key=2aa3c4d5f3de4f5b9120b660ad850dc9&amp;type=video%2Fmp4&amp;schema=imgur\" width=\"245\" height=\"333\" scrolling=\"no\" frameborder=\"0\" allowfullscreen&gt;&lt;/iframe&gt;",
    */
    var html = ""
    /**
    example, "1.0",
    */
    var version = ""
    /**
    example, "Imgur",
    */
    var providerName = ""
    /**
    example, "http://i.imgur.com/khgfcrQ.gif",
    */
    var thumbnailUrl = ""
    /**
    example, "video",
    */
    var type = ""
    /**
    example, 333
    */
    var thumbnailHeight = 0
    /**
    Update each property with JSON object.
    
    :param: json JSON object which is included "t2" JSON.
    */
    public init (json:JSONDictionary) {
		self.providerUrl = json["provider_url"] as? String ?? ""
		self.description = json["description"] as? String ?? ""
		self.title = json["title"] as? String ?? ""
		self.thumbnailWidth = json["thumbnail_width"] as? Int ?? 0
		self.height = json["height"] as? Int ?? 0
		self.width = json["width"] as? Int ?? 0
		self.html = json["html"] as? String ?? ""
		self.version = json["version"] as? String ?? ""
		self.providerName = json["provider_name"] as? String ?? ""
		self.thumbnailUrl = json["thumbnail_url"] as? String ?? ""
		self.type = json["type"] as? String ?? ""
		self.thumbnailHeight = json["thumbnail_height"] as? Int ?? 0
    }
}