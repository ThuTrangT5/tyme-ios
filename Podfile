# Uncomment the next line to define a global platform for your project
platform :ios, '17.0'
  project 'tymex.xcodeproj'

def shared_pods
  pod 'SwiftyJSON'
  pod 'Alamofire'
end

target 'tymex' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  shared_pods

  target 'tymexTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'tymexUITests' do
    # Pods for testing
  end
end
