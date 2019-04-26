#
# Be sure to run `pod lib lint DDBaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDBaseKit'
  s.version          = '0.1.0'
  s.summary          = 'base classes and tools for app'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ZHONGNANKEJI/DDBaseKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ZHONGNANKEJI' => 'szzhongyu2018@163.com' }
  s.source           = { :git => 'https://github.com/ZHONGNANKEJI/DDBaseKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DDBaseKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DDBaseKit' => ['DDBaseKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YYModel', '~> 1.0.4'
  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'SDWebImage', '~> 4.4.1'
  s.dependency 'ReactiveObjC', '~> 3.1.0'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'MJRefresh', '~> 3.1.15.3'
  s.dependency 'YYCache'
  s.dependency 'RTRootNavigationController', '~> 0.6.7'
  s.dependency 'AFNetworking', '~> 3.2.1'
end
