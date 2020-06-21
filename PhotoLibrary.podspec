Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "PhotoLibrary"
s.summary = "PhotoLibrary creates iOS native looking screen for viewing images."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Nikita Benin" => "nickinade@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/nickinade/PhotoLibrary"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/nickinade/PhotoLibrary.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'Kingfisher', '~> 5.13.3'

# 8
s.source_files = "PhotoLibrary/**/*.{swift}"

# 9
# s.resources = "PhotoLibrary/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end
