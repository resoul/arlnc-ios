//
//  data.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

var account = User(uuid: "Xv7JV1aN5u8AX", username: "resoul.ua", fullName: "YM", profilePicture: "https://instagram.fdnk1-4.fna.fbcdn.net/v/t51.2885-19/47053939_345844452866127_4549742191903244288_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fdnk1-4.fna.fbcdn.net&_nc_cat=103&_nc_ohc=Xv7JV1aN5u8AX-DS9sc&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfD-5cH-vFR6Zw2jlhxHtqjHX7eRZ--D3C-d03exK9WrVA&oe=65EC7B89&_nc_sid=8b3546", isPrivate: false, biography: "Explorer", media: 236, followers: 69, following: 22)

var stories: [Story] = [
    Story(username: "resoul", imagePath: "https://thumbs.filmix.biz/posters/3654/thumbs/w220/superseks-2024_171003.jpg"),
    Story(username: "resoul", imagePath: "https://thumbs.filmix.biz/posters/1013/orig/vals-mefistofelya-the-mephisto-waltz-1971_12867.jpg"),
    Story(username: "resoul", imagePath: "https://thumbs.filmix.biz/posters/1821/thumbs/w220/orel-2024_170967.jpg"),
    Story(username: "resoul", imagePath: "https://thumbs.filmix.biz/posters/1240/thumbs/w220/byvshaya-zhena-2022_161637.jpg"),
    Story(username: "resoul", imagePath: "https://thumbs.filmix.biz/posters/5456/thumbs/w220/rezhim-2024_170952.jpg"),
    Story(username: "resoul", imagePath: "https://thumbs.filmix.biz/posters/0706/thumbs/w220/bezgranichnaya-lyubov-2023_168218.jpg"),
    Story(username: "resoul", imagePath: "https://thumbs.filmix.biz/posters/2216/thumbs/w220/korolevy-2024_170978.jpg"),
]

var stories1: [Story] = [
    Story(username: "resoul.ua", imagePath: "https://thumbs.filmix.biz/posters/3654/thumbs/w220/superseks-2024_171003.jpg"),
    Story(username: "resoul.ua", imagePath: "https://thumbs.filmix.biz/posters/1013/orig/vals-mefistofelya-the-mephisto-waltz-1971_12867.jpg"),
    Story(username: "resoul.ua", imagePath: "https://thumbs.filmix.biz/posters/1821/thumbs/w220/orel-2024_170967.jpg"),
    Story(username: "resoul.ua", imagePath: "https://thumbs.filmix.biz/posters/1240/thumbs/w220/byvshaya-zhena-2022_161637.jpg"),
]

var fetchedData: [Stories] = [
    Stories(user: account, isMe: true, isLive: false, lastViewedIndex: 0, stories: stories),
    Stories(user: account, isMe: false, isLive: false, lastViewedIndex: 1, stories: stories1),
    Stories(user: account, isMe: false, isLive: false, lastViewedIndex: 0, stories: stories),
    Stories(user: account, isMe: false, isLive: false, lastViewedIndex: 3, stories: stories1),
    Stories(user: account, isMe: false, isLive: false, lastViewedIndex: 0, stories: stories),
    Stories(user: account, isMe: false, isLive: false, lastViewedIndex: 3, stories: stories1),
    Stories(user: account, isMe: false, isLive: false, lastViewedIndex: 0, stories: stories),
    Stories(user: account, isMe: false, isLive: false, lastViewedIndex: 3, stories: stories1),
]
