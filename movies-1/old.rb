
# $ gets intersection of two lists
def load_data(movie_id, user_id, user_id_with_ratings, movie_data)
	File.foreach(movie_data) { |line|
		new_line=line.split("\t")
		for i in 0..3
  			new_line[i]=new_line[i].to_i
		end
		if (movie_id[new_line[0]]==nil)
			movie_id[new_line[0]]=[]
		end
		movie_id[new_line[0]]=movie_id[new_line[0]].push(new_line[2])
		if (user_id[new_line[1]]==nil)
			user_id[new_line[1]]=[]
		end
		user_id[new_line[1]]=user_id[new_line[1]].push(new_line[0])
		if (user_id_with_ratings[new_line[1]]==nil)
			user_id_with_ratings[new_line[1]]={}
		end
		user_id_with_ratings[new_line[1]].store(new_line[0],new_line[2])
	}
end
def popularity(hash,key)
	if (hash[key]==nil)
		puts "no such key"
		return 0
	end
	return hash[key].length
end
def popularity_list(hash)
	list={}
	hash.keys.sort.each do |key|
		value=popularity(hash,key)
		list[value]=key
	end
	return list
end
def orderedHash(hash)
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

def similarity(user1, user2, hash, hash_with_ratings)
	similarity_rating=0
	array1 = hash[user1]
	array2 = hash[user2]
	array3 = array1 & array2
	array3.each do |index|
	 	similarity_rating+=5-(hash_with_ratings[user1][index]-hash_with_ratings[user2][index]).abs
	end
	return similarity_rating
end
def most_similar(u,hash1, hash2)
	similar_user=0
	max_value=0
	hash1.keys.sort.each do |key|
		value=similarity(u, key, hash1, hash2)
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
movie_data=open("u.data")
#Hash of keys of Users with values as arrays of movies they have rated
user_id=Hash.new
#Hash of keys of Movies with values as arrays of ratings they have been rated
movie_id=Hash.new
#Hash of keys of Users with values as hashes of keys of movies they have rated and values as the ratings they rated
user_id_with_ratings=Hash.new 
load_data(movie_id,user_id, user_id_with_ratings, movie_data)
movie_list=popularity_list(movie_id)
orderedHash(movie_list)



	
#movie_list.keys.sort_by { |key| movie_list[key] }.reverse.each do
#		|key|
#    	puts "#{key} : #{movie_list[key]} popularity rating"
#end

puts "Most similar to user 1 is :#{most_similar(1,user_id, user_id_with_ratings)}"



