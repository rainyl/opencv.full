#
# Be sure to run `pod lib lint OpenCvIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'OpenCvIOS'
    s.version          = '4.10.0'
    s.summary          = 'A short description of OpenCvIOS.'
    s.description      = <<-DESC
  TODO: Add long description of the pod here.
                         DESC

    s.homepage         = 'https://github.com/rainyl/opencv.full'
    s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
    s.author           = { 'rainyl' => 'rainyliusy3@gmail.com' }
    s.authors          = 'https://github.com/opencv/opencv/graphs/contributors'
    s.documentation_url = 'https://docs.opencv.org/master/'

    s.source           = { :http => "https://github.com/rainyl/opencv.full/releases/download/#{s.version.to_s}/libopencv-ios.zip" }

    s.frameworks       = 'Accelerate', 'AssetsLibrary', 'AVFoundation', 'CoreGraphics', 'CoreImage', 'CoreMedia', 'CoreVideo', 'Foundation', 'QuartzCore', 'UIKit'
    s.ios.deployment_target = '12.0'
    s.swift_version = '5.3'

    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

    # CocoaPods not to remove framework
    s.preserve_paths = 'opencv2.xcframework'
    # link opencv2 framework
    s.xcconfig = { 'OTHER_LDFLAGS' => '-framework opencv2' }

    s.source_files = 'opencv2.framework/Versions/A/Headers/**/*{.h,.hpp}'
    s.public_header_files = 'opencv2.framework/Versions/A/Headers/**/*{.h,.hpp}'
    s.requires_arc = false
    s.static_framework = true
    #s.header_dir       = 'opencv2'
    #s.header_mappings_dir = 'opencv2.framework/Versions/A/Headers/'
    s.libraries        = 'stdc++'

    # Published binaries
    s.vendored_frameworks = "opencv2.xcframework"
  end
  