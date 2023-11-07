Pod::Spec.new do |s|
  s.name             = 'CorrilySDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CorrilySDK.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/corrily/ios-sdk'
  # s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrey Filipenkov' => 'kambaladecapitator@gmail.com' }
  s.source           = { :git => 'https://github.com/corrily/ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/CorrilySDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CorrilySDK' => ['CorrilySDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
