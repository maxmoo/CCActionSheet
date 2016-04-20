Pod::Spec.new do |s|
s.name			= 'CCActionSheet'
s.version		= '1.0.1'
s.summary		= 'An easy way to show your actionsheet like weixin'
s.homepage		= 'https://github.com/maxmoo/CCActionSheet'
s.license		= 'MIT'
s.platform		= :ios
s.author		= {'maxmoo' => 'maxmoo@163.com'}
s.ios.deployment_target = '8.0'
s.source		= {:git => 'https://github.com/maxmoo/CCActionSheet.git',:tag => s.version}
s.requires_arc 		= true
end
