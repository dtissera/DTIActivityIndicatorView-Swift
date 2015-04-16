Pod::Spec.new do |s|
  s.name = 'DTIActivityIndicator'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'A Swift animated custom ActivityIndicator'
  s.homepage = 'https://github.com/dtissera/DTIActivityIndicatorView-Swift'
  s.social_media_url = 'http://twitter.com/dtissera'
  s.authors = { 'David Tisserand' => 'david.tisserand.mobile@gmail.com' }
  s.source = { :git => 'https://github.com/dtissera/DTIActivityIndicatorView-Swift.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  
  s.source_files = 'Source/*.swift'

  s.requires_arc = true
end