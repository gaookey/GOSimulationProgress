Pod::Spec.new do |spec|
 
  spec.name                   = 'SPSimulationProgress'
  spec.version                = '0.0.2'
  spec.summary                = 'A simple virtual progress tool.'
  spec.homepage               = 'https://mouos.com'
  spec.license                = { :type => 'MIT', :file => 'LICENSE' }
  spec.author                 = { '高文立' => 'swiftprimer@gmail.com' }
  spec.platform               = :ios, "11.0"
  spec.source                 = { :git => "https://github.com/mouos/SPSimulationProgress.git", :tag => spec.version }
  spec.source_files           = "Classes/**/*"
  spec.swift_version          = '5.0'
 
 end