class MovieData
	attr_accessor :movie_id
	attr_accessor :user_id
	attr_accessor :user_id_with_ratings
	attr_accessor :movie_data
	def initialize(file_name)
		@movie_id=Hash.new
		@user_id=Hash.new
		@user_id_with_ratings=Hash.new
		@movie_data=open(file_name)
	end
	def load_data
		File.foreach(@movie_data) { |line|
			new_line=line.split("\t")
			for i in 0..3
	  			new_line[i]=new_line[i].to_i
			end
			if (@movie_id[new_line[1]]==nil)
				@movie_id[new_line[1]]=[]
			end
			@movie_id[new_line[1]]=@movie_id[new_line[1]].push(new_line[2])
			if (@user_id[new_line[0]]==nil)
				@user_id[new_line[0]]=[]
			end
			@user_id[new_line[0]]=@user_id[new_line[0]].push(new_line[1])
			if (@user_id_with_ratings[new_line[0]]==nil)
				@user_id_with_ratings[new_line[0]]={}
			end
			@user_id_with_ratings[new_line[0]].store(new_line[1],new_line[2])
		}
	end
	def popularity(key)
		if (@movie_id[key]==nil)
			puts "no such key"
			return 0
		end
		return @movie_id[key].length
	end
	def popularity_list
		list={}
		@movie_id.keys.sort.each do |key|
			value=popularity(key)
			list[value]=key
		end
		printOrderedHash(list)
	end
	def printOrderedHash(hash)
		list=Array.new(hash.size)
		count=1
		hash.keys.sort.each do |key|
			list[list.size-count]={key => hash[key]}
			count+=1
		end
		(0..9).each do |i|
			list[i].keys.each do |key|
				puts "Popularity rating: #{key} of movie: #{hash[key]}"
			end
		end
		(list.length-10..list.length-1).each do |i|
			list[i].keys.each do |key|
				puts "Popularity rating: #{key} of movie: #{hash[key]}"
			end
		end
	end
	def printOrderedSimilarityHash(hash)
		list=Array.new(hash.size)
		count=1
		hash.keys.sort.each do |key|
			list[list.size-count]={key => hash[key]}
			count+=1
		end
		(1..9).each do |i|
			list[i].keys.each do |key|
				puts "Similarity: #{key} of user: #{hash[key]}"
			end
		end
		(list.length-10..list.length-1).each do |i|
			list[i].keys.each do |key|
				puts "Similarity rating: #{key} of user: #{hash[key]}"
			end
		end
	end
	def similarity(user1, user2)
		similarity_rating=0
		array1 = @user_id[user1]
		array2 = @user_id[user2]
		array3 = array1 & array2
		array3.each do |index|
		 	similarity_rating+=5-(@user_id_with_ratings[user1][index]-@user_id_with_ratings[user2][index]).abs
		end
		return similarity_rating
	end
	def similarity_list(u)
		list={}
		@user_id.keys.sort.each do |key|
			if(u==key)
				value=0
			end
			value=similarity(u, key)
			list[value]=key
		end
		printOrderedSimilarityHash(list)
	end
	def most_similar(u)
		similar_array=[]
		similar_user=0
		max_value=0
		@user_id.keys.sort.each do |key|
			value=similarity(u, key)
			if(u==key)
				value=0
			end
			if(value>max_value)
				similar_user=key
				max_value=value
			end
		end
		return similar_user
	end
end
	movies=MovieData.new("u.data")
	movies.load_data
	movies.popularity_list
	movies.similarity_list(1)
	puts "Most similar to user 1 is :#{movies.most_similar(1)}"



