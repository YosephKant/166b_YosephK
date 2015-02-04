require "./load.rb"
class Entries	
	attr_accessor :movie_id, :user_id ,:user_id_with_ratings, :triplet, :movie_id_with_user
	def initialize(file, k=nil)
		@movie_id, @movie_id_with_user, @user_id, @user_id_with_ratings, @triplet=Load.load_data(file,k)
	end
	def getMovieId
		return @movie_id
	end
end
movies=Entries.new("u.data")