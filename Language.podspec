Pod::Spec.new do |s|
s.name          = "WhdeUIButtonLoad"
s.version       = "1.0.4"
s.summary       = "iOS UIButton with Loadding State."
s.homepage      = "https://github.com/whde/WhdeLocalized"
s.license       = 'MIT'
s.author        = { "Whde" => "460290973@qq.com" }
s.platform      = :ios, "7.0"
s.source        = { :git => "https://github.com/whde/WhdeLocalized.git", :tag => s.version.to_s }
s.source_files  = 'WhdeUIButtonLoad/Calss/*'
s.frameworks    = 'Foundation'
s.requires_arc  = true
s.description   = <<-DESC
iOS UIButton with Loadding State. When you Click UIButton, than POST/GET some Data From Internet. UIButton can show Loading State at this SPACE TIME.
DESC
end

