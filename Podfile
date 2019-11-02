platform :ios, '12.0'
swift_version = '5.1'

inhibit_all_warnings!

def pod_FirebaseSDK
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
end

target 'Test4' do
  use_frameworks!
  pod 'Ballcap'
  pod 'R.swift', '~> 5.0.0'
  pod 'Alamofire'
  pod_FirebaseSDK
end
