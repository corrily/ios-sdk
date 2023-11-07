Pod::Spec.new do |s|
  s.name             = 'CorrilySDK'
  s.version          = '0.1.0'
  s.summary          = 'Swift SDK to fetch Corrily prices for in-app Paywall.'

  s.description      = <<-DESC
Swift SDK to fetch Corrily prices for in-app Paywall.
                       DESC

  s.homepage         = 'https://github.com/corrily/ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = {
    'Andrey Filipenkov' => 'kambaladecapitator@gmail.com',
    'Kirill Gugaev' => 'kirill@corrily.com'
  }
  s.source           = {
    :git => 'https://github.com/corrily/ios-sdk.git',
    :tag => s.version.to_s
  }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/CorrilySDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CorrilySDK' => ['CorrilySDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
