class MovieTest
	attr_accessor :movieTestData
	def initialize
		@movieTestData=[]
	end
	def addToArray(u,m,r,p)
		@movieTestData.push([u,m,r,p])
	end
	def to_a
	 	@movieTestData.each do |i|
	 		puts "[#{i}]"
	 	end
	end
	def  mean
		count=0
		@movieTestData.each do |row|
			count+=((row[3]-row[2]).abs)
		end
		return count/@movieTestData.length
	end
	def stddev
		count = 0.0
		x = mean
		@movieTestData.each do |row|
			count += (((((row[3]-row[2])/row[2]).abs)-x)**2)
		end
		return (Math.sqrt(count/@movieTestData.length))
	end
	def rms
		count = 0.0
		@movieTestData.each do |row|
			err = ((row[2]-row[3])/row[2]).abs
			count += (err**2)
		end
		return Math.sqrt(count/@movieTestData.length)
	end
end
