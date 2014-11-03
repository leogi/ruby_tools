class Obito::ImportJson
  class << self
  	# file: instance of File class or filename
  	def import file
  		file = File.open(file) if file.is_a? String
  		if file.is_a?(File) 
         stories = JSON.parse(file.read)
         stories.each do |story|
         	 Story.create_from_json(story)
         end
  		end
  	end	
  end
end