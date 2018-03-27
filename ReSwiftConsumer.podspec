#
# Be sure to run `pod lib lint ReSwiftConsumer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReSwiftConsumer'
  s.version          = '0.1.6'
  s.summary          = 'With ReSwiftConsumer you can consume segmented property changes of state.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ReSwiftConsumer는 ReSwift에 속성 선택함수(Property Selector)를 연결하여 사용한 것입니다.
ReSwiftConsumer를 사용해서 ReSwift의 State 중에서 자신이 원하는 속성값의 변경만 알아챌 수 있습니다.
ViewController 단에서 사용할 수 있는 콤포넌트를 포함하고 있습니다.
                       DESC

  s.homepage         = 'https://github.com/brownsoo/ReSwift-Consumer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'brownsoo' => 'hansune@me.com' }
  s.source           = { :git => 'https://github.com/brownsoo/ReSwift-Consumer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hansoolabs'

  s.ios.deployment_target = '10.3'

  s.source_files = 'ReSwiftConsumer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ReSwiftConsumer' => ['ReSwiftConsumer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'ReSwift'
end
