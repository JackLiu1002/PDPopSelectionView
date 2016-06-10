Pod::Spec.new do |spec|
  spec.name         = 'PDPopSelectionView'
  spec.version      = '1.0.3'
  spec.license      = 'MIT'
  spec.summary      = 'PDPopSelectionView'
  spec.homepage     = 'https://github.com/JackLiu1002/PDPopSelectionView'
  spec.author       = 'Jack Liu'
  spec.platform     = :ios, "5.0.0"
  spec.source       = { :git => 'https://github.com/JackLiu1002/PDPopSelectionView.git', :tag => '1.0.1'}
  spec.source_files = 'PDPopSelectionView/PDPopSelectionView/*'
  spec.resources = 'PDPopSelectionView/PDPopSelectionView/Resources/*'

  spec.frameworks = 'UIKit'
  spec.requires_arc = true
end