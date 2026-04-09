# 🎵 Professional iOS Audio Player

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Framework](https://img.shields.io/badge/AVFoundation-Native-lightgrey.svg)
![UI](https://img.shields.io/badge/UIKit-AutoLayout-blue.svg)

A high-performance music player for iOS that leverages native Apple frameworks to provide a seamless audio experience. This project demonstrates deep understanding of audio lifecycle management and responsive UI design.

## 🚀 Key Features
* **Advanced Playback Engine:** Full control over audio states (Play, Pause, Skip, Seek).
* **Dynamic UI Updates:** Real-time progress bars and time tracking synced with the audio buffer.
* **Volume Management:** Precision volume control using hardware-accelerated APIs.
* **Adaptive Layout:** Built with AutoLayout to ensure a perfect look on all iPhone screen sizes.

## 🛠 Engineering & Tech Stack
* **Engine:** `AVFoundation` & `AVAudioPlayer`. I chose this for low-latency audio processing and native power efficiency.
* **UI Architecture:** UIKit with **Storyboards** and **AutoLayout Constraints**. Focus on pixel-perfect alignment.
* **Pattern:** MVC. Separation of data (audio files) from playback logic and view updates.

## 🧠 Technical Challenges Solved
* **Audio Interruption Handling:** Managed how the app behaves when a phone call comes in or headphones are disconnected.
* **Memory Optimization:** Optimized audio buffering to ensure low memory footprint during playback.

