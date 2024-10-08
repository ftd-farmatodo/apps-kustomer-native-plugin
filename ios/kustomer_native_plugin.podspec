#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint kustomer_native_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'kustomer_native_plugin'
  s.version          = '0.0.3'
  s.summary          = 'SDK De flutter para integrar Kustomer'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://farmatodo.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Farmatodo' => 'diegof.cuesta@farmatodo.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'KustomerChat'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
