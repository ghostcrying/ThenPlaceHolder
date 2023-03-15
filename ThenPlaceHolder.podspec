Pod::Spec.new do |s|
  s.name         = "ThenPlaceHolder"
  s.version      = "1.0.0"
  s.summary      = "Placeholder written in Swift"
  s.description  = <<-EOS
  Scroll Extension Package
  For UITableView，UICollectionView, if data is empty, set a custom placeholder view.
  Instructions for installation are in [the README](https://github.com/ghostcrying/ThenPlaceHolder).
  EOS
  s.homepage     = "https://github.com/ghostcrying/ThenPlaceHolder"
  s.author       = { "ghost" => "czios1501@gmail.com" }
  s.ios.deployment_target = '11.0'
  s.source       = { :git => "https://github.com/ghostcrying/ThenPlaceHolder.git", :tag => s.version }
  s.source_files = "Sources/**/*"
  s.swift_version = '5.3'
  s.cocoapods_version = '>= 1.4.0'

end
