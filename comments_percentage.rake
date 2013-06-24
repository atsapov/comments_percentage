task :commented do
  dirs = %w(controllers helpers models)
  stat = build_stat(dirs)

  dirs.each do |dir|
    puts "\n#{dir}:"
    puts "-- code = #{stat[dir.to_sym][:code]}"
    puts "-- comments = #{stat[dir.to_sym][:comments]}"
    puts "-- commented = #{percentage(stat[dir.to_sym][:code], stat[dir.to_sym][:comments])}%"
  end

  code = stat.map { |dir| dir.last[:code] }.sum
  comments = stat.map { |dir| dir.last[:comments] }.sum

  puts "\ntotal:"
  puts "-- code = #{code}"
  puts "-- comments = #{comments}"
  puts "-- commented = #{percentage(code, comments)}%"
end

def build_stat(dirs)
  result = {}

  dirs.each do |dir|
    result[dir.to_sym] = dir_stat("app/#{dir}")
  end

  result
end

def dir_stat(path)
  dir = Dir.open(path)

    code = 0
    comments = 0

    dir.each do |name|

      if !name.include?('.')
        hash = dir_stat([dir.path, name].join('/'))

        code += hash[:code]
        comments += hash[:comments]
      elsif name.end_with?('.rb')
        hash = file_stat([dir.path, name].join('/'))

        code += hash[:code]
        comments += hash[:comments]
      end
    end

  { code: code, comments: comments }
end

def file_stat(path)
  code = 0
  comments = 0

  File.open(path, 'r') do |file|
    file.each_line do |line|
      next if line.blank?
      if line.lstrip.start_with?('#')
        comments += 1
      else
        code += 1
      end
    end
  end

  { code: code, comments: comments }
end

def percentage(code, comments)
  comments * 100 / code
end
