![mirae logo](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3e576466-bf8e-46ba-87fa-02ef48a05d44/Group_109.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210329%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210329T100949Z&X-Amz-Expires=86400&X-Amz-Signature=79990f495501bb90eec2dcdced259fcabdec2da9b5949901e3644e80a967a419&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Group_109.png%22)

# Project mirae

---

### 🌱 Project mirae is an app that motivates and helps users to protect the Earth.

[![youtube link](https://github.com/Sungwooo/mirae/blob/main/readme%20image/스크린샷%202021-03-30%20오후%2011.55.51.png?raw=true)](https://www.youtube.com/watch?v=nx7B3li-cfs)

# Main features

---

- [AI camera]()
- [Trash information]()
- [World trash map]()
- [Ranking]()
- [E - challenges]()
- [UN environment news]()
- [Profile]()

## AI camera

![AI camera](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/528f016c-a29f-44a2-beb2-af220b447317/IMG_5234.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20210331%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20210331T140639Z&X-Amz-Expires=86400&X-Amz-Signature=f991a294fed2dde24ac2b9100d3cf83cef764c9515f713d814657eb76869492e&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22IMG_5234.png%22)

- When users run the AI trash camera, it categorizes the trash type. Users can choose whether DISCARD or PING(saving trash location) on the map.

## Trash information

![Readme%2040dcee5e30ad443aa99821926f7b844e/IMG_5235.png](Readme%2040dcee5e30ad443aa99821926f7b844e/IMG_5235.png)

![Readme%2040dcee5e30ad443aa99821926f7b844e/IMG_5236.png](Readme%2040dcee5e30ad443aa99821926f7b844e/IMG_5236.png)

- It categorizes trash types and provides information. It shows how it is recycled, effect of recycling and tips.

## World trash map

![Readme%2040dcee5e30ad443aa99821926f7b844e/IMG_5233.png](Readme%2040dcee5e30ad443aa99821926f7b844e/IMG_5233.png)

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.28.36.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.28.36.png)

- Users can view the location of trash on the map. Users can see where there is a lot of trash in the world, and it can be guided to the trash around them.

## Ranking

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.01.02.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.01.02.png)

- Users can get points while using the app and check your ranking based on the points.

## E - Challenges

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_17.59.49.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_17.59.49.png)

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.00.38.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.00.38.png)

- It provides users with 3 challenges they can do for the environment each day. Points will be given when the challenge is completed. In the challenges tab, you can see the challenges you have performed.

## UN environment news

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.02.24.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.02.24.png)

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.02.29.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.02.29.png)

- In the News tab, users can receive daily environmental news from the UN.

## Profile

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.02.11.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.02.11.png)

![Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.03.13.png](Readme%2040dcee5e30ad443aa99821926f7b844e/Simulator_Screen_Shot_-_iPhone_11_Pro_-_2021-03-29_at_18.03.13.png)

- In My tab, users can see your activities while using the app. Every time you get points, the tree grows and users can level up. Users can customize the profile and see more information in Edit profile.

# Project Structure

---

Project mirae is developed as a hybrid app using `flutter` to support Android and iOS.

Trash ai camera is designed using mobilenet-ssd with `tenserflow` lite for object detection. 

`Firebase` was used to store the location data of the found trash. In addition, google map api was used to provide route of trash location.

`Google cloud platform` was used to member management to check users' own profiles and view rankings.

# How to start

---

### ⬇️ Download APK file

### [APK file](https://raw.githubusercontent.com/Sungwooo/mirae/main/release/mirae(1.0.0).apk) (1.0.0)

---

### Or If you want debug

### **Client**

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

# External resources

---

[UN evironment news](https://news.un.org/en/news/topic/climate-change)

[Recycle information](https://www.recyclenow.com)

# Team

---

**Product manager / UI.UX :** [Sungwoo Cho](https://github.com/Sungwooo)

**Front / Back** **Developer  :** [Sihyeong Lee](https://github.com/mukjo96)

**Front / Back** **Developer**  **:** [Jaewang Lee](https://github.com/JaeWangL)

**Front / Back** **Developer**  **:** [Dukhyeon Kim](https://github.com/Kim-deokhyeon)
