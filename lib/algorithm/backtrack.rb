module Algorithm
	class Backtrack
		def initialize max_level
			@max_level = max_level
		end

		def run level = 0
			return true if level >= @max_level
			if missing_value? level
				samples = samples_in level
			else
				return run(level + 1)
			end
			
			samples.each do |sample|
				valid = try_sample level, sample
				if valid
					if level == @max_level
						return true
					else
						valid = run level + 1
						if valid
							return true
						else
							rollback level
						end	
					end
				end
			end
			false
		end

		def samples_in level
		end

		def missing_value? level
		end

		def try_sample level, sample
		end

		def rollback level
		end
	end
end