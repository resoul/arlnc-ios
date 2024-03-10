//
//  data.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

var me = User(uuid: "Xv7JV1aN5u8AX", username: "resoul.ua", fullName: "YM", profilePicture: "https://instagram.fdnk1-4.fna.fbcdn.net/v/t51.2885-19/47053939_345844452866127_4549742191903244288_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fdnk1-4.fna.fbcdn.net&_nc_cat=103&_nc_ohc=Xv7JV1aN5u8AX-DS9sc&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfD-5cH-vFR6Zw2jlhxHtqjHX7eRZ--D3C-d03exK9WrVA&oe=65EC7B89&_nc_sid=8b3546", isPrivate: false, biography: "Explorer", media: 236, followers: 69, following: 22)

var account = User(uuid: "Xv7JV1aN5u7AX", username: "resoul", fullName: "YM", profilePicture: "https://instagram.fdnk1-4.fna.fbcdn.net/v/t51.2885-19/47053939_345844452866127_4549742191903244288_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fdnk1-4.fna.fbcdn.net&_nc_cat=103&_nc_ohc=Xv7JV1aN5u8AX-DS9sc&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfD-5cH-vFR6Zw2jlhxHtqjHX7eRZ--D3C-d03exK9WrVA&oe=65EC7B89&_nc_sid=8b3546", isPrivate: false, biography: "Explorer", media: 236, followers: 69, following: 22)

var storie = [
    Storie(type: .image, path: "https://scontent.cdninstagram.com/v/t51.29350-15/236493749_4335712153130804_3557483292759278855_n.jpg?stp=dst-jpg_e35_p640x640_sh0.08&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi43NTB4MTMzNC5zZHIifQ&_nc_ht=scontent.cdninstagram.com&_nc_cat=108&_nc_ohc=KjneySTRbJsAX_8x6A8&edm=APs17CUBAAAA&ccb=7-5&ig_cache_key=MjY0MDA4OTMyMTQ1NTc0MTg5Ng%3D%3D.2-ccb7-5&oh=00_AfCGSQbl3ubhEOL8Ip7teqfbyWP7-xWpluPqOsHH2PTy9Q&oe=65EF0F67&_nc_sid=10d13b", date: "1hr")
]

var storiesData = StoriesData(totalStories: 8, stories: [
    Stories(user: me, currentStoriesIndex: 0, stories: []),
    Stories(user: account, currentStoriesIndex: 0, stories: storie),
    Stories(user: account, currentStoriesIndex: 0, stories: storie),
    Stories(user: account, currentStoriesIndex: 0, stories: storie),
    Stories(user: account, currentStoriesIndex: 0, stories: storie),
    Stories(user: account, currentStoriesIndex: 0, stories: storie),
    Stories(user: account, currentStoriesIndex: 0, stories: storie),
    Stories(user: account, currentStoriesIndex: 0, stories: storie)
])
