Pod::Spec.new do |spec|
  spec.name             = 'RealmSugar'
  spec.version          = '1.1.0'
  spec.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  spec.homepage         = 'https://github.com/bynelus/RealmSugar'
  spec.authors          = { 'Niels Koole' => 'nielskoole@icloud.com' }
  spec.summary          = 'RealmSugar is a syntactic sugar to remove unnecessary code for retrieving notifications on realm instances.'
  spec.source           = { :git => 'https://github.com/bynelus/RealmSugar.git', :tag => spec.version.to_s }
  spec.ios.source_files = 'RealmSugar/Source/*.*'
  spec.ios.requires_arc = true
  spec.ios.deployment_target = '9.0'

  spec.dependency 'RealmSwift'
end