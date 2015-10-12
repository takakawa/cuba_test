require_relative "calc.tab.rb"
require "mote"

$p = File.open(File.dirname(__FILE__) +"/pattern.mote").read
def get_page
	page = Mote.parse($p,self,[:output,:defined_macro])
	page.call(output:"he",defined_macro:"")
end	

def get_result(defs,calls)
	parser = MacroParser.new
	parser.split_parse(defs)
	result = []
	calls.split(";").each do |call|
	result << "#{call} =  #{parser.exe(call)}"
	end
	
	p result
	page = Mote.parse($p,self,[:output,:defined_macro])
	
	page.call(output: result.join("\n"),defined_macro: defs)
end