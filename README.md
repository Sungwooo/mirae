# ![mirae logo](https://github.com/Sungwooo/mirae/blob/main/readme%20image/mirae%20readme%20logo.png?raw=true)    Project mirae


### 🌱 Project mirae is an app that motivates and helps users to protect the Earth. <br/>

**📺 Youtube introduce ⬇️Click⬇️**
[![youtube link](https://github.com/Sungwooo/mirae/blob/main/readme%20image/youtube%20thumbnail.png?raw=true)](https://www.youtube.com/watch?v=nx7B3li-cfs)
<br/>
Project mirae is designed to help users preserve the environment. 
When users find trash, it provides information about the trash and allows them to directly mark the trash location. As data accumulates, we can see where the trash is in the world and help us clear it up. Users can read UN news and perform environmental challenges. 
Project mirae will continue to develop into services that help users work to save the planet. 
<br/><br/><br/>



# Contents

- [Main features](#main-features)
- [Project Structure](#project-Structure)
- [How to start](#how-to-start)
- [External resources](#external-resources)
- [Team](#team)


<br/><br/>

## Main features

### AI camera

![AI camera](https://github.com/Sungwooo/mirae/blob/main/readme%20image/ai%20camera%20readme.png?raw=true)

- When users run the AI trash camera, it categorizes the trash type. Users can choose whether DISCARD or PING(saving trash location) on the map.

<br/><br/>

### Trash information

![trash](https://github.com/Sungwooo/mirae/blob/main/readme%20image/trash%20readme.png?raw=true)


- It categorizes trash types and provides information. It shows how it is recycled, effect of recycling and tips.

<br/><br/>

### World trash map

![worldtrashmap](https://github.com/Sungwooo/mirae/blob/main/readme%20image/map%20info%20readme.png?raw=true)

- Users can view the location of trash on the map. Users can see where there is a lot of trash in the world, and it can be guided to the trash around them.

<br/><br/>

### Ranking

![ranking](https://github.com/Sungwooo/mirae/blob/main/readme%20image/worldmap%20readme.png?raw=true)

- Users can get points while using the app and check your ranking based on the points.

<br/><br/>

### E - Challenges

![challenge](https://github.com/Sungwooo/mirae/blob/main/readme%20image/challenge%20readme.png?raw=true)

- It provides users with 3 challenges they can do for the environment each day. Points will be given when the challenge is completed. In the challenges tab, you can see the challenges you have performed.

<br/><br/>

### UN environment news

![UNnews](https://github.com/Sungwooo/mirae/blob/main/readme%20image/news%20readme.png?raw=true)

- In the News tab, users can receive daily environmental news from the UN.

<br/><br/>

### Profile

![profile](https://github.com/Sungwooo/mirae/blob/main/readme%20image/my%20readme.png?raw=true)

- In My tab, users can see your activities while using the app. Every time you get points, the tree grows and users can level up. Users can customize the profile and see more information in Edit profile.

<br/><br/><br/>

## Project Structure


Project mirae is developed as a hybrid app using `flutter` to support Android and iOS. <br/>
Trash ai camera is designed using mobilenet-ssd with `tenserflow lite` for object detection. <br/>
`Firebase` was used to store the location data of the found trash. In addition, google map api was used to provide route of trash location.<br/>
`Google cloud platform` was used to member management to check users' own profiles and view rankings.<br/>

<br/><br/><br/>

## How to start


### `Android` - ⬇️Download APK file⬇️
#### [APK file](https://raw.githubusercontent.com/Sungwooo/mirae/main/release/mirae(1.0.0).apk) --- version 1.0.0


----


### `iOS`  - Debug

#### **Client**

To build and run the mobile apps you’ll need to install [Flutter](https://flutter.dev/) and its dependencies. To verify your installation run in the project’s root directory:**‌**

```
$ flutter doctor

```

The app is optimised for Android and iOS phones in portrait mode.

**IMPORTANT:** The project only supports Flutter version 2.0.2, you will have to change your configuration to it. We cannot make sure that other Flutter versions will work.

```
$ flutter version 2.0.2

```

**Note:** Additionally you’ll need to setup the backend and add the GoogleService-Info of your Firebase app to your clients.

<br/><br/><br/>

## External resources


[UN evironment news](https://news.un.org/en/news/topic/climate-change)<br/>
[Recycle information](https://www.recyclenow.com)

<br/><br/><br/>

## Team


**Product manager / UI.UX : [Sungwoo Cho](https://github.com/Sungwooo)**<br/>
**Front / Back Developer : [Sihyeong Lee](https://github.com/mukjo96)**<br/>
**Front / Back Developer : [Jaewang Lee](https://github.com/JaeWangL)**<br/>
**Front / Back Developer : [Dukhyeon Kim](https://github.com/Kim-deokhyeon)**
