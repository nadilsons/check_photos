unless ((old_path = ARGV[0]) and (new_path = ARGV[1]))
  abort "usage: #{__FILE__} OLD_PATH NEW_PATH"
end

old_photos = Hash[Dir.entries(old_path).map{|f| [f, File.mtime("#{old_path}/#{f}")]}]
new_photos = Hash[Dir.entries(new_path).map{|f| [f, File.mtime("#{new_path}/#{f}")]}]

diff = new_photos.reject {|k,v| [".", ".."].include? k or old_photos[k].nil? or old_photos[k] == v }

diff.keys.each { |f|  puts "cp #{old_path}/#{f} diff/#{f.gsub(/\.(\w{3})/, ".1.\\1")}" }
