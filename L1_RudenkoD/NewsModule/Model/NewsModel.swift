

import Foundation

// MARK: - NewsFeed
class NewsFeed: Codable {
    let response: Response?

    init(response: Response?) {
        self.response = response
    }
}

// MARK: - Response
class Response: Codable {
    let items: [ResponseItem]?
    let profiles: [Profile]?
    let groups: [Group]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }

    init(items: [ResponseItem]?, profiles: [Profile]?, groups: [Group]?, nextFrom: String?) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
        self.nextFrom = nextFrom
    }
}

// MARK: - Group
class Group: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }

    init(id: Int?, name: String?, screenName: String?, isClosed: Int?, type: String?, isAdmin: Int?, isMember: Int?, isAdvertiser: Int?, photo50: String?, photo100: String?, photo200: String?) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.type = type
        self.isAdmin = isAdmin
        self.isMember = isMember
        self.isAdvertiser = isAdvertiser
        self.photo50 = photo50
        self.photo100 = photo100
        self.photo200 = photo200
    }
}

// MARK: - ResponseItem
class ResponseItem: Codable {
    let sourceID, date: Int?
    let canDoubtCategory, canSetCategory: Bool?
    let topicID: Int?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [Attachment]?
    let postSource: PostSource?
    let comments: Comments?
    let likes: PurpleLikes?
    let reposts: Reposts?
    let views: Views?
    let isFavorite: Bool?
    let donut: Donut?
    let shortTextRate: Double?
    let postID: Int?
    let type: String?
    let pushSubscription: PushSubscription?
    let trackCode: String?
    let photos: Photos?
    let extID: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case topicID = "topic_id"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case donut
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type
        case pushSubscription = "push_subscription"
        case trackCode = "track_code"
        case photos
        case extID = "ext_id"
    }

    init(sourceID: Int?, date: Int?, canDoubtCategory: Bool?, canSetCategory: Bool?, topicID: Int?, postType: String?, text: String?, markedAsAds: Int?, attachments: [Attachment]?, postSource: PostSource?, comments: Comments?, likes: PurpleLikes?, reposts: Reposts?, views: Views?, isFavorite: Bool?, donut: Donut?, shortTextRate: Double?, postID: Int?, type: String?, pushSubscription: PushSubscription?, trackCode: String?, photos: Photos?, extID: String?) {
        self.sourceID = sourceID
        self.date = date
        self.canDoubtCategory = canDoubtCategory
        self.canSetCategory = canSetCategory
        self.topicID = topicID
        self.postType = postType
        self.text = text
        self.markedAsAds = markedAsAds
        self.attachments = attachments
        self.postSource = postSource
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
        self.views = views
        self.isFavorite = isFavorite
        self.donut = donut
        self.shortTextRate = shortTextRate
        self.postID = postID
        self.type = type
        self.pushSubscription = pushSubscription
        self.trackCode = trackCode
        self.photos = photos
        self.extID = extID
    }
}

// MARK: - Attachment
class Attachment: Codable {
    let type: String?
    let photo: Photo?
    let link: Link?

    init(type: String?, photo: Photo?, link: Link?) {
        self.type = type
        self.photo = photo
        self.link = link
    }
}

// MARK: - Link
class Link: Codable {
    let url: String?
    let title, caption, linkDescription: String?
    let photo: Photo?
    let amp: Amp?
    let target: String?
    let isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case url, title, caption
        case linkDescription = "description"
        case photo, amp, target
        case isFavorite = "is_favorite"
    }

    init(url: String?, title: String?, caption: String?, linkDescription: String?, photo: Photo?, amp: Amp?, target: String?, isFavorite: Bool?) {
        self.url = url
        self.title = title
        self.caption = caption
        self.linkDescription = linkDescription
        self.photo = photo
        self.amp = amp
        self.target = target
        self.isFavorite = isFavorite
    }
}

// MARK: - Amp
class Amp: Codable {
    let url: String?
    let views: Int?
    let isFavorite: Bool?
    let title, caption: String?

    enum CodingKeys: String, CodingKey {
        case url, views
        case isFavorite = "is_favorite"
        case title, caption
    }

    init(url: String?, views: Int?, isFavorite: Bool?, title: String?, caption: String?) {
        self.url = url
        self.views = views
        self.isFavorite = isFavorite
        self.title = title
        self.caption = caption
    }
}

// MARK: - Photo
class Photo: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let sizes: [Size]?
    let text: String?
    let userID: Int?
    let accessKey: String?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text
        case userID = "user_id"
        case accessKey = "access_key"
        case postID = "post_id"
    }

    init(albumID: Int?, date: Int?, id: Int?, ownerID: Int?, hasTags: Bool?, sizes: [Size]?, text: String?, userID: Int?, accessKey: String?, postID: Int?) {
        self.albumID = albumID
        self.date = date
        self.id = id
        self.ownerID = ownerID
        self.hasTags = hasTags
        self.sizes = sizes
        self.text = text
        self.userID = userID
        self.accessKey = accessKey
        self.postID = postID
    }
}

// MARK: - Size
class Size: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?

    init(height: Int?, url: String?, type: String?, width: Int?) {
        self.height = height
        self.url = url
        self.type = type
        self.width = width
    }
}

// MARK: - Comments
class Comments: Codable {
    let count, canPost: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }

    init(count: Int?, canPost: Int?, groupsCanPost: Bool?) {
        self.count = count
        self.canPost = canPost
        self.groupsCanPost = groupsCanPost
    }
}

// MARK: - Donut
class Donut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }

    init(isDonut: Bool?) {
        self.isDonut = isDonut
    }
}

// MARK: - PurpleLikes
class PurpleLikes: Codable {
    let count, userLikes, canLike, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }

    init(count: Int?, userLikes: Int?, canLike: Int?, canPublish: Int?) {
        self.count = count
        self.userLikes = userLikes
        self.canLike = canLike
        self.canPublish = canPublish
    }
}

// MARK: - Photos
class Photos: Codable {
    let count: Int?
    let items: [PhotosItem]?

    init(count: Int?, items: [PhotosItem]?) {
        self.count = count
        self.items = items
    }
}

// MARK: - PhotosItem
class PhotosItem: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let accessKey: String?
    let postID: Int?
    let sizes: [Size]?
    let text: String?
    let userID: Int?
    let likes: FluffyLikes?
    let reposts: Reposts?
    let comments: Views?
    let canComment, canRepost: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
        case likes, reposts, comments
        case canComment = "can_comment"
        case canRepost = "can_repost"
    }

    init(albumID: Int?, date: Int?, id: Int?, ownerID: Int?, hasTags: Bool?, accessKey: String?, postID: Int?, sizes: [Size]?, text: String?, userID: Int?, likes: FluffyLikes?, reposts: Reposts?, comments: Views?, canComment: Int?, canRepost: Int?) {
        self.albumID = albumID
        self.date = date
        self.id = id
        self.ownerID = ownerID
        self.hasTags = hasTags
        self.accessKey = accessKey
        self.postID = postID
        self.sizes = sizes
        self.text = text
        self.userID = userID
        self.likes = likes
        self.reposts = reposts
        self.comments = comments
        self.canComment = canComment
        self.canRepost = canRepost
    }
}

// MARK: - Views
class Views: Codable {
    let count: Int?

    init(count: Int?) {
        self.count = count
    }
}

// MARK: - FluffyLikes
class FluffyLikes: Codable {
    let userLikes, count: Int?

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }

    init(userLikes: Int?, count: Int?) {
        self.userLikes = userLikes
        self.count = count
    }
}

// MARK: - Reposts
class Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }

    init(count: Int?, userReposted: Int?) {
        self.count = count
        self.userReposted = userReposted
    }
}

// MARK: - PostSource
class PostSource: Codable {
    let type: String?

    init(type: String?) {
        self.type = type
    }
}

// MARK: - PushSubscription
class PushSubscription: Codable {
    let isSubscribed: Bool?

    enum CodingKeys: String, CodingKey {
        case isSubscribed = "is_subscribed"
    }

    init(isSubscribed: Bool?) {
        self.isSubscribed = isSubscribed
    }
}

// MARK: - Profile
class Profile: Codable {
    let id: Int?
    let firstName, lastName: String?
    let isClosed, canAccessClosed, isService: Bool?
    let sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let online: Int?
    let onlineInfo: OnlineInfo?
    var name: String {
      (firstName ?? "") + " " + (lastName ?? "")
  }
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case isService = "is_service"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
        case onlineInfo = "online_info"
    }

    init(id: Int?, firstName: String?, lastName: String?, isClosed: Bool?, canAccessClosed: Bool?, isService: Bool?, sex: Int?, screenName: String?, photo50: String?, photo100: String?, online: Int?, onlineInfo: OnlineInfo?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.isClosed = isClosed
        self.canAccessClosed = canAccessClosed
        self.isService = isService
        self.sex = sex
        self.screenName = screenName
        self.photo50 = photo50
        self.photo100 = photo100
        self.online = online
        self.onlineInfo = onlineInfo
    }
}

// MARK: - OnlineInfo
class OnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }

    init(visible: Bool?, isOnline: Bool?, isMobile: Bool?) {
        self.visible = visible
        self.isOnline = isOnline
        self.isMobile = isMobile
    }
}
