//
//  data.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

var me = User(uuid: "Xv7JV1aN5u8AX", username: "resoul.ua", fullName: "YM", profilePicture: "https://uploads.airlance.org/22/avatar.jpg", isPrivate: false, biography: "Explorer", media: 236, followers: 69, following: 22)

var account = User(uuid: "Xv7JV1aN5u7AX", username: "resoul", fullName: "YM", profilePicture: "https://uploads.airlance.org/22/avatar.jpg", isPrivate: false, biography: "Explorer", media: 236, followers: 69, following: 22)


var storiesData = StoriesData(totalStories: 9, stories: [
    Stories(user: me, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/238257307_186514896749135_1240845163032602559_n.jpg", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/238257307_186514896749135_1240845163032602559_n.jpg", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/238440237_2713067282329650_1903914208165994197_n.jpg", date: "1hr"),
        Storie(type: .video, path: "https://uploads.airlance.org/22/238191631_281250753761558_2326865499224532597_n.mp4", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/236971541_209029461078234_784231696019005946_n.jpg", date: "1hr"),
        Storie(type: .image, path: "https://uploads.airlance.org/22/236982597_4345962708822760_8558333529909679048_n.jpg", date: "1hr"),
        Storie(type: .video, path: "https://uploads.airlance.org/22/238689329_875604286380211_7558656618610710209_n.mp4", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/236153711_375634934077268_3741895848752662936_n.jpg", date: "1hr"),
        Storie(type: .image, path: "https://uploads.airlance.org/22/236452750_196524329189831_1272306585797424879_n.jpg", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/236512220_423330415721797_6150542845822462931_n.jpg", date: "1hr"),
        Storie(type: .image, path: "https://uploads.airlance.org/22/236666560_538501423937104_5605207647376237740_n.jpg", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/236493749_4335712153130804_3557483292759278855_n.jpg", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/236866248_984006912385839_7911931141984088894_n.jpg", date: "1hr"),
        Storie(type: .video, path: "https://uploads.airlance.org/22/239013319_811860752817388_6368178735875283046_n.mp4", date: "1hr")
    ]),
    Stories(user: account, currentStoriesIndex: 0, stories: [
        Storie(type: .image, path: "https://uploads.airlance.org/22/236409314_2958256531083884_340897945131076951_n.jpg", date: "1hr")
    ])
])
