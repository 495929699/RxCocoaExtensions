#
# Be sure to run `pod lib lint RxCocoaExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxCocoaExtensions.swift'
  s.version          = '0.2.0'
  s.summary          = 'RxCocoa+Extensions'
  
  s.description      = <<-DESC
  RxCocoa扩展
  DESC
  
  s.homepage         = 'https://github.com/495929699/RxCocoaExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rongheng' => '495929699g@gmail.com' }
  s.source           = { :git => 'https://github.com/495929699/RxCocoaExtensions.git', :tag => s.version.to_s }
  
  s.module_name      = 'RxCocoaExtensions'
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.cocoapods_version = '>=1.6.0'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '5.0'
  }
  
  s.source_files = 'RxCocoaExtensions/Classes/**/*.swift'
  
  s.dependency 'RxCocoa', '~>5.0'
  
end
