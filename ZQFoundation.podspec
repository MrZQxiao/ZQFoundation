#
# Be sure to run `pod lib lint ZQFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZQFoundation'
  s.version          = '1.0.1'
  s.summary          = '组件基础库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '组件化demo中的基础组件'

  s.homepage         = 'https://www.jianshu.com/u/33e45e444e13'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaozq' => '285061422@qq.com' }
  s.source           = { :git => 'https://github.com/MrZQxiao/ZQFoundation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.module_name   = 'ZQFoundation'
  s.ios.deployment_target = '11.0'
  s.static_framework = true

  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.source_files = 'ZQFoundation/**/*'
  s.default_subspec = 'Base'

  s.subspec 'Base' do |ss|
      ss.source_files = 'ZQFoundation/Base/ZQFoundation.h'
      ss.dependency 'ZQFoundation/Categories'
  end

  s.subspec 'Categories' do |cate|
      cate.public_header_files = 'ZQFoundation/Categories/*.h'
      cate.dependency 'SDWebImage'
      cate.dependency 'MJExtension'
      cate.source_files = 'ZQFoundation/Categories/**/*.{h,m}'
  end

end
