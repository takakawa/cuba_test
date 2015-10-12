require "cuba"
require_relative "macro_parser/main.rb"



Cuba.define do 
	on get do 
		on root do
			res.write "<html>HELLO</html>"
		end
		
		on "macro" do
			res.write(get_page)
		end
	

	end
	on post do 
		on param("firstname"),param("lastname"),param("comment")do |f,l,txt|
			res.write f
			res.write l
			res.write txt
		end
		on param("upload") do |upload|
			file = File.open(upload[:tempfile])
			res.write file.gets
		end
		on param("macro") ,param("call") do |defs,calls|
			
			p defs
			p calls
			res.write get_result(defs,calls)

		end
		
		

	end
	
	
end
