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
		
		begin
			on param("call"),param("macro") do |calls,defs|
				p calls
				p defs
				parse_defs(defs)
				res.write  exe_calls(calls)

			end
			on param("macro") do |defs|
				p defs
				parse_defs(defs)
				res.write(get_page)
				end

		       on param("call") do |calls|
				p calls
				res.write  exe_calls(calls)

			end
			
			on true do
				res.write  "INPUT ERR"
			end
		
		 rescue => info
			res.write "ERROR!!#{info}"
		end

	end
	
	
end
