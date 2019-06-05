Pod::Spec.new do |s|
  s.name             = 'ReSwiftConsumer'
  s.version          = '0.8.0'
  s.summary          = 'With ReSwiftConsumer you can consume segmented property changes of state.'
  s.description      = <<-DESC
With ReSwift Consumer, we can observe the property changes interested using Property selector.
It include some components that can be used in ViewController level.
                       DESC

  s.homepage         = 'https://github.com/brownsoo/ReSwift-Consumer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'brownsoo' => 'hansune@me.com' }
  s.source           = { :git => 'https://github.com/brownsoo/ReSwift-Consumer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hansoolabs'

  s.ios.deployment_target     = '10.3'
  #s.osx.deployment_target     = '10.10'
  #s.tvos.deployment_target    = '9.0'
  #s.watchos.deployment_target = '2.0'

  s.source_files = 'ReSwiftConsumer/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'ReSwiftConsumer' => ['ReSwiftConsumer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'ReSwift'
end
