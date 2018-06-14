require "minitest/autorun"

def require_recursive path
  if path.length == 0
    return
  end

  Dir.glob("#{path}/**").each do |filename|
    if File.directory? filename
      require_recursive path
    elsif File.extname(filename) == ".rb"
      require_relative filename
    end
  end
end

require_recursive "../lib"
