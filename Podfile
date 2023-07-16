# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'
 workspace 'TvShows.xcworkspace'


target 'Domain' do
  project './Domain/Domain.project'
  use_frameworks!
end

def data_pods
  # Alamofire
  pod 'Alamofire', '~> 5.4'
  pod 'AlamofireImage', '~> 4.1'
  pod 'AlamofireNetworkActivityLogger', '~> 3.4'
end

target 'Data' do
  project './Data/Data.project'
  use_frameworks!
  # Alamofire
  data_pods
end

target 'TvShows' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TvShows
  # Rx pods
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'RxDataSources', '~> 5.0'
  pod 'BonMot'
  data_pods
end
