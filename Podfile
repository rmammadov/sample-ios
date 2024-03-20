platform :ios, '15.0'

inhibit_all_warnings!

target 'Versal' do
  use_frameworks!

  pod 'Bugsnag'
  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'FirebasePerformance'
  pod 'GRDB.swift'
  pod 'IQKeyboardManager'
  pod 'Moya', '~> 15.0'
  pod 'SQLCipher', '~>4.0'
  pod 'SwiftFormat/CLI', '~> 0.49'
  pod 'SwiftLint'

  target 'VersalTests' do
    inherit! :search_paths
  end

  target 'VersalUITests' do
  end

  post_install do |pi|
    pi.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end

end