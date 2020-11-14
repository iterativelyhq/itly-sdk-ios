Pod::Spec.new do |spec|
  spec.name         = "ItlyAmplitudePlugin"
  spec.version      = "1.0.0"
  spec.summary      = "Iteratively Analytics SDK for iOS — Swift & Objective-C"
  spec.description  = <<-DESC
                       Amplitude plugin for Iteratively SDK
                       DESC

  spec.homepage     = "https://iterative.ly"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Iteratively" => "support@iterative.ly",
                        "Justin Fiedler" => "justin@iterative.ly",
                        "Konstantin Dorogan" => "sayd3x@users.noreply.github.com" }
  spec.source       = { :git => "https://github.com/iterativelyhq/itly-sdk-ios.git", :tag => "v#{spec.version}" }

  spec.ios.deployment_target = "11.0"
  spec.tvos.deployment_target = "11.0"
  spec.osx.deployment_target = "10.10"

  spec.source_files   = 'AmplitudePlugin/AmplitudePlugin/**/*.{h,swift}'
  spec.framework  = "Foundation"
  spec.dependency "Amplitude", "~> 6.0.0"
  spec.dependency "ItlySdk"

  spec.swift_version = '5.3'

end
