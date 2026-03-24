# GitHubBrowser

An Objective-C iOS app that searches GitHub repositories using the GitHub REST API. Built as a showcase project to demonstrate proficiency in Objective-C and UIKit.

## Screenshots
<img width="200" height="2532" alt="IMG_8842" src="https://github.com/user-attachments/assets/3a2396af-dd65-47b0-9349-3c300a99bff7" />
<img width="200" height="2532" alt="IMG_8840" src="https://github.com/user-attachments/assets/7e9468f9-6bb8-4ec6-8e2d-9ace2783c5ff" />
<img width="200" height="2532" alt="IMG_8844" src="https://github.com/user-attachments/assets/cf9c40c8-5b21-4a1a-90c7-c2dde5d33fd6" />
<img width="200" height="2532" alt="IMG_8841" src="https://github.com/user-attachments/assets/2dad5306-f2a8-4c3a-86dd-2161e8aacbe1" />


## About

This project is intentionally written in **Objective-C** to demonstrate hands-on knowledge of the language, its idioms, and its integration with UIKit. It covers core concepts that are still relevant in large-scale iOS codebases maintained by companies like Meta, Google, Uber, and many others.

## Features

- Search GitHub repositories by keyword
- View repository details (name, description, stars, forks, language)
- Fully programmatic UI — no Storyboards or XIBs
- Custom loading view with animations
- Empty state handling (initial prompt and "not found" states)

## Tech Stack

| Area | Details |
|------|---------|
| **Language** | Objective-C |
| **UI Framework** | UIKit (100% programmatic) |
| **Architecture** | MVC |
| **Layout** | Masonry (Auto Layout DSL) |
| **Networking** | NSURLSession with completion block callbacks |
| **Dependency Manager** | CocoaPods |
| **Minimum Target** | iOS 15.0 |

## Architecture

The project follows **MVC (Model-View-Controller)** — the idiomatic pattern for UIKit and Objective-C development.

```
GitHubBrowser/
├── Models/
│   └── GHRepository              # Repository data model with JSON parsing
├── Views/
│   ├── RepositoryCell             # Custom self-sizing collection view cell
│   ├── NotFoundCell               # Empty state cell (search prompt / not found)
│   └── GHLoadingView              # Animated full-screen loading overlay
├── Controllers/
│   └── MainViewController         # Search + collection view controller
├── Networking/
│   └── GHApiClient                # Singleton API client wrapping NSURLSession
├── Categories/
│   └── UICollectionViewCell+Ext   # Reusable cell identifier helper
├── Constants/
│   └── CONSTANTS                  # Centralized app constants (images, colors)
└── Supporting/
    ├── AppDelegate
    ├── SceneDelegate              # Programmatic window setup
    └── main.m                     # App entry point
```

## Objective-C Concepts Demonstrated

**Language fundamentals**
- Header (`.h`) / Implementation (`.m`) separation with clean public interfaces
- Properties with appropriate attributes (`nonatomic`, `strong`, `weak`, `copy`, `assign`)
- Lazy property initialization via getter overrides
- Class prefixing (`GH`) for namespacing
- `NS_ASSUME_NONNULL_BEGIN` / `END` for nullability annotations
- Lightweight generics (`NSArray<GHRepository *> *`)

**Design patterns**
- Delegate pattern (`UISearchBarDelegate`, `UICollectionViewDataSource`)
- Singleton pattern (`GHApiClient.shared`)
- Block-based callbacks for async networking
- Categories for extending existing classes

**UIKit & Layout**
- Programmatic UI with no Storyboards or XIBs
- `UICollectionViewCompositionalLayout` with estimated sizing
- Self-sizing cells with proper Auto Layout constraint chains
- Programmatic `UIWindow` and `UINavigationController` setup in `SceneDelegate`
- `UIView` animations with `CGAffineTransform`

**Networking**
- `NSURLSession` data tasks with completion handlers
- JSON parsing with `NSJSONSerialization`
- `dispatch_async` to main queue for UI updates
- Error handling with `NSError`

**Memory management**
- ARC with correct use of `strong` / `weak` references
- Proper `prepareForReuse` in collection view cells

## Getting Started

### Prerequisites

- Xcode 15.0+
- CocoaPods (`gem install cocoapods`)

### Installation

```bash
git clone https://github.com/yourusername/GitHubBrowser.git
cd GitHubBrowser
pod install
open GitHubBrowser.xcworkspace
```

> **Note:** Always open the `.xcworkspace` file, not `.xcodeproj`, after running `pod install`.

### Build & Run

1. Open `GitHubBrowser.xcworkspace` in Xcode
2. Select a simulator (iPhone 15 Pro recommended)
3. Press `Cmd + R` to build and run
4. Type a search query and tap Search

## API

This app uses the [GitHub REST API](https://docs.github.com/en/rest) — no authentication required for basic repository search.

**Endpoint used:**
```
GET https://api.github.com/search/repositories?q={query}
```

## License

This project is available under the MIT License.
