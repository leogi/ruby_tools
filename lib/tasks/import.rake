namespace :import do
	task :story => :environment do
	  puts "Import from #{ENV["FILE_NAME"]}"
    Obito::ImportJson.import(ENV["FILE_NAME"])
	end
end