module Load
	def Load.load_data(file, k=nil)
		@movie_id=Hash.new
		@movie_id_with_user=Hash.new
		@user_id=Hash.new
		@user_id_with_ratings=Hash.new
		@triplet=[]
		if k != nil
			counter=k
		end
		File.foreach(file) { |line|
			if k!=nil
				counter == 0 ? break : counter -= 1
			end
			new_line=line.split("\t")
			for i in 0..3
				new_line[i]=new_line[i].to_i
			end
			if (@movie_id[new_line[1]]==nil)
				@movie_id[new_line[1]]=[]
			end
			@movie_id[new_line[1]]=@movie_id[new_line[1]].push(new_line[0])
			if (@movie_id_with_user[new_line[1]]==nil)
				@movie_id_with_user[new_line[1]]={}
			end
			@movie_id_with_user[new_line[1]].store(new_line[0],new_line[2])
			if (@user_id[new_line[0]]==nil)
				@user_id[new_line[0]]=[]
			end
			@user_id[new_line[0]]=@user_id[new_line[0]].push(new_line[1])
			if (@user_id_with_ratings[new_line[0]]==nil)
				@user_id_with_ratings[new_line[0]]={}
			end
			@user_id_with_ratings[new_line[0]].store(new_line[1],new_line[2])
			temporary_array=[]
			temporary_array.push(new_line[0],new_line[1],new_line[2])
			@triplet.push(temporary_array)
		}
		return @movie_id, @movie_id_with_user, @user_id, @user_id_with_ratings, @triplet
	end
end