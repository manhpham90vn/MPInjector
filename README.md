# MPInjector

### An tiny Dependency Injection framework for Swift on iOS.

# Install use cocoapods
```
pod 'MPInjector'
```

# Register intance

use singleton life time

```swift
extension MPInjector: Registering {
    public func registerService() {
        MPInjector.registerSingleton { UserDefaults.standard as UserDefaults }
        MPInjector.registerSingleton { UserDefaultsStorage() as Storage }
    }
}
```

use factory life time

```swift
extension MPInjector: Registering {
    public func registerService() {
        MPInjector.registerFactory { LoginUseCase() }
        MPInjector.registerFactory { GETEventUseCase() }
    }
}

```

# Resolve intance

```swift
@Inject var connectivityService: ConnectivityService
@LazyInject var log: Logger
```

# Sample App
[iOS-VIPER-Architecture](https://github.com/manhpham90vn/iOS-VIPER-Architecture)
