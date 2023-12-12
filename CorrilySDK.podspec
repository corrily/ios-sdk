Pod::Spec.new do |s|
  s.name             = 'CorrilySDK'
  s.version          = '1.0.0'
  s.summary          = 'Swift SDK to fetch Corrily prices for in-app Paywall.'

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

  s.ios.deployment_target = '14.0'
  s.swift_version = '5.1'

  s.source_files = 'Sources/**/*.{swift}'
end
