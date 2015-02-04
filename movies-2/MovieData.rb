require "./Data.rb"
require "./MovieTest.rb"

class MovieData
	attr_accessor :u_data, :base_data, :test_data ,:movie_data, :folder, :set, :base, :test, :a
	def initialize(folder=nil,set=nil)
		@movie_data=open("u.data")
		@folder=folder
		@set=set
		@a=MovieTest.new
  	end
	def ratings(u,m)
		return @base_data.user_id_with_ratings[u][m]==nil ? 0 : @base_data.user_id_with_ratings[u][m]
	end
	def movies(u,data)
		data.user_id[u]
	end
	def viewers(m,data)
		data.movie_id[m]
	end
	def predict(u,m)
		rating=0
		counter=0
		if(@base_data.movie_id[m]!=nil)
			(0..@base_data.movie_id[m].length-1).each do |i|
				if (similarity(@base_data.movie_id[m][i], u, @base_data) > 200)		
					rating += (@base_data.movie_id_with_user[m][@base_data.movie_id[m][i]])
					counter+=1
				end
			end
		end
		rating.to_f
		counter.to_f
		if(counter!=0)
			return (rating/counter).round
		end
		return 1
	end
	def popularity(key,data)
		if (data.movie_id[key]==nil)
			puts "no such key"
			return 0
		end
		return data.movie_id[key].length
	end
	def popularity_list(data)
		list={}
		data.movie_id.keys.sort.each do |key|
			value=popularity(key, data)
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
	def reverseOrderedSimilarityHash(hash)
		list=Array.new(hash.size)
		count=1
		hash.keys.sort.each do |key|
			list[list.size-count]={key => hash[key]}
			count+=1
		end
		return list
	end
	def similarity(user1, user2, data)
		similarity_rating=0
		array1 = data.user_id[user1]
		array2 = data.user_id[user2]
		array3 = array1 & array2
		array3.each do |index|
		 	similarity_rating+=5-(data.user_id_with_ratings[user1][index]-data.user_id_with_ratings[user2][index]).abs
		end
		return similarity_rating
	end
	def similarity_list(u,data)
		list={}
		data.user_id.keys.sort.each do |key|
			if(u==key)
				value=0
			end
			value=similarity(u, key, data)
			list[value]=key
		end
		return list
	end
	def most_similar(u,data)
		similar_array=[]
		similar_user=0
		max_value=0
		data.user_id.keys.sort.each do |key|
			value=similarity(u, key, data)
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
	def run_test(k=nil)
		if(@set==nil)
			@base=nil
			@test=nil
			@u_data=Entries.new(@movie_data)
			return @a
		else
			@base=open([@set, "base"].join("."))
			@test=open([@set, "test"].join("."))
		 	@base_data=Entries.new(@base)
		 	@test_data=Entries.new(@test, k)
  			@u_data=nil
  		end
		(0..@test_data.triplet.length-1).each do |j|
			puts "#{100*j/@test_data.triplet.length}%"
			 p = predict(@test_data.triplet[j][0], @test_data.triplet[j][1])
			@a.addToArray(@test_data.triplet[j][0], @test_data.triplet[j][1], @test_data.triplet[j][2], p)
		end
	return @a
	end
end

	movies=MovieData.new('ml-100k',:u1)
	example=Entries.new("u1.test",20)
	movies.run_test(100)
	movies.a.to_a
	puts movies.a.mean
	puts movies.a.stddev
	puts movies.a.rms

	
	#movies.popularity_list
	# movies.similarity_list(1)
	# puts "Most similar to user 1 is :#{movies.most_similar(1)}"


