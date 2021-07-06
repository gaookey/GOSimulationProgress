Pod::Spec.new do |spec|
 
  spec.name                   = 'GOSimulationProgress'
  spec.version                = '1.0.0'
  spec.summary                = 'A simple virtual progress tool.'
  spec.homepage               = 'https://github.com/gaookey/GOSimulationProgress'
  spec.license                = { :type => 'MIT', :file => 'LICENSE' }
  spec.author                 = { '高文立' => 'gaookey@gmail.com' }
  spec.platform               = :ios, "11.0"
  spec.source                 = { :git => "https://github.com/gaookey/GOSimulationProgress.git", :tag => spec.version }
  spec.source_files           = "Classes/**/*"
  spec.swift_version          = '5.0'
 
 end