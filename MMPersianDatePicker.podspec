#
# Be sure to run `pod lib lint MMPersianDatePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MMPersianDatePicker'
  s.version          = '0.1.0'
  s.summary          = 'A short summury of MMPersianDatePicker.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A short description of MMPersianDatePicker.'

  s.homepage         = 'https://github.com/moosamir68/MMPersianDatePicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Moosa Mir' => 'moosamir68@gmail.com' }
  s.source           = { :git => 'https://github.com/moosamir68/MMPersianDatePicker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MMPersianDatePicker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MMPersianDatePicker' => ['MMPersianDatePicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.0" }

end
