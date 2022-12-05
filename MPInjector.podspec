Pod::Spec.new do |s|
  s.name             = 'MPInjector'
  s.version          = '1.0.4'
  s.summary          = 'An tiny Dependency Injection framework for Swift on iOS.'
  s.homepage         = 'https://github.com/manhpham90vn/MPInjector'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'manhpham90vn' => 'manhpham90vn@icloud.com' }
  s.source           = { :git => 'https://github.com/manhpham90vn/MPInjector.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'MPInjector/*.{h,swift}'
  s.swift_version = '5.0'   
end