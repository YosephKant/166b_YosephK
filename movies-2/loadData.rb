module load
	def load.load_data(file)
		@movie_id=Hash.new
		@user_id=Hash.new
		@user_id_with_ratings=Hash.new
		File.foreach(file) { |line|
			new_line=line.split("\t")
			for i in 0..3
				new_line[i]=new_line[i].to_i
			end
			if (@movie_id[new_line[1]]==nil)
				@movie_id[new_line[1]]=[]
			end
			@movie_id[new_line[1]]=@movie_id[new_line[1]].push(new_line[0])
			if (@user_id[new_line[0]]==nil)
				@user_id[new_line[0]]=[]
			end
			@user_id[new_line[0]]=@user_id[new_line[0]].push(new_line[1])
			if (@user_id_with_ratings[new_line[0]]==nil)
				@user_id_with_ratings[new_line[0]]={}
			end
				@user_id_with_ratings[new_linse[0]].store(new_line[1],new_line[2])
		}
		return @movie_id, @user_id, @user_id_with_ratings
	end
end