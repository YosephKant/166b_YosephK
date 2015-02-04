def load_data(movie_id, user_id, movie_data)
	File.foreach(movie_data).with_index { |line, line_num|
	puts line
	new_line=line.split("\t")
	puts new_line
	puts new_line[0]
	if (movie_id[new_line[0]]==nil)
		movie_id[new_line[0]]=[]
	end
	movie_id[new_line[0]]=[new_line[0]].push(new_line[2])
	if (user_id[new_line[1]]==nil)
		user_id[new_line[1]]=[]
	end
	user_id[new_line[1]]=[new_line[1]].push(new_line[0])
	}
end
movie_id=Hash.new
user_id=Hash.new
movie_data=open("hello.txt")
load_data(movie_id,user_id,movie_data)
movie_id.each do|name,grade|
  puts "#{name}: #{grade}"
end 
