Pod::Spec.new do |s|
  s.name         = "YokoAPI"
  s.version      = "0.0.1"
  s.summary      = "YokoAPI is an iOS library for the foodie.com API"
  s.homepage     = "http://www.foodie.com"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "Yoko Mobile" => "yoko-mobile@glam.com" }
  s.platform     = :ios, '5.0'
  s.source_files = 'YokoAPI/src/*.{h,m}'
  s.frameworks = 'Accounts', 'Twitter'
  s.requires_arc = true
  s.dependency 'AFNetworking','1.3.4'
  s.dependency 'Facebook-iOS-SDK'
  s.dependency 'ARAnalytics/Flurry'
  s.library = 'sqlite3.0'
end
