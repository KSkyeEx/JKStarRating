Pod::Spec.new do |s|
s.name = 'JKStarRating'
s.version = '0.0.2'
s.summary = 'An easy way to use frame'
s.homepage = 'https://github.com/JokerKin/JKStarRating'
s.license = 'MIT'
s.authors = {"JokerKin" => "weijoker_king@163.com"}
s.platform = :ios, '8.0'
s.source = {:git => 'https://github.com/JokerKin/JKStarRating.git', :tag => s.version}
s.source_files = "JKStarRating", "JKStarRating/**/*.{h,m}"
s.requires_arc = true
end

