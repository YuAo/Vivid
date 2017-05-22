Pod::Spec.new do |s|
  s.name         = 'Vivid'
  s.version      = '0.9'
  s.author       = { 'YuAo' => 'me@imyuao.com' }
  s.homepage     = 'https://github.com/YuAo/Vivid'
  s.summary      = 'Filters and utilities for Core Image'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.source       = {:git => 'https://github.com/YuAo/Vivid.git', :tag => '0.9'}
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.source_files = 'Sources/**/*.{h,m}'
  s.resources    = 'Sources/**/*.{png,cikernel}'
end
