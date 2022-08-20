# MPInjector

### An tiny Dependency Injection framework for Swift on iOS.

# Install use cocoapods
```
pod 'MPInjector'
```

# Register intance

```swift
extension MPInjector: Registering {
    public func registerService() {
        // use singleton life time
        MPInjector.registerSingleton { UserDefaults.standard as UserDefaults }
        MPInjector.registerSingleton { UserDefaultsStorage() as Storage }
        
        // use factory life time
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
