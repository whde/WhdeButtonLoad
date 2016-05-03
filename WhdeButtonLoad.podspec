Pod::Spec.new do |s|
s.name          = "WhdeButtonLoad"
s.version       = "1.0.0"
s.summary       = "iOS UIButton with Loadding State."
s.homepage      = "https://github.com/whde/WhdeButtonLoad"
s.license       = 'MIT'
s.author        = { "Whde" => "460290973@qq.com" }
s.platform      = :ios, "7.0"
s.source        = { :git => "https://github.com/whde/WhdeButtonLoad.git", :tag => s.version.to_s }
s.source_files  = 'WhdeButtonLoad/Class/*'
s.frameworks    = 'Foundation'
s.requires_arc  = true
s.description   = <<-DESC
iOS UIButton with Loadding State. When you Click UIButton, than POST/GET some Data From Internet. UIButton can show Loading State at this SPACE TIME.
DESC
end

