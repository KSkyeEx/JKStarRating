Pod::Spec.new do |s|
s.name = 'KnightStarRating'
s.version = '0.0.1'
s.summary = 'An easy way to use frame'
s.homepage = 'https://github.com/JokerKin/KnightStarRating'
s.license = 'MIT'
s.authors = {"JokerKin" => "weijoker_king@163.com"}
s.platform = :ios, '8.0'
s.source = {:git => 'https://github.com/JokerKin/KnightStarRating.git', :tag => s.version}
s.source_files = "KnightStarRating", "KnightStarRating/**/*.{h,m}"
s.requires_arc = true
end

