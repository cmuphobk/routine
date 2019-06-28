# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def all_pods

  # Pods for Routine
  # ignore all warnings from all pods
  inhibit_all_warnings!
  
  # RestAPI
  pod 'Alamofire', '~> 4.7'
  
  #CoreData
  pod 'MagicalRecord'
  
  #Firebase
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'

  #HockeySDK
  pod "HockeySDK"
  
  #R.swift
  pod "R.swift"
  
  #Reachability
  pod 'Reachability'

  #SwiftLint
  pod 'SwiftLint'
  
  #SnapKit
  pod 'SnapKit'
  
end

target 'Routine' do

  use_frameworks!
  all_pods

end

target 'RoutineTests' do
  
  use_frameworks!
  all_pods

end


