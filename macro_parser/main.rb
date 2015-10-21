require_relative "calc.tab.rb"
require "mote"

$p = File.open(File.dirname(__FILE__) +"/pattern.mote").read
$parser = MacroParser.new
macro_pri_def = File.open(File.dirname(__FILE__) +"/macros.txt").read().gsub("\\\n","").gsub("\n",";").delete("#")
$parser.split_parse( macro_pri_def)
$page = Mote.parse($p,self,[:output,:defined_macro,:call])
def get_page
	$page.call(output:"",defined_macro:"",call:"")
end	

def parse_defs(defs)
	$defs_bak = defs
	str = defs.gsub("\\\r\n","").gsub("\r\n",";").gsub(/\/\*.*\*\//,"").delete("#")
	p str
	begin
		$parser.split_parse(str)
	rescue =>info
		p info.to_s
	end
end

def exe_calls(calls)
	result = []
	
	calls.split("\r\n").each do |call|
		unless call =~ /\A[\s\n]*\Z/
			begin
				macro_number = $parser.exe(call)
				result << "#{call} = #{macro_number} = 0x#{macro_number.to_s(16)}"
			rescue => info
				result << info.to_s
			end
		end
	end

	$page.call(output: result.join("\n"),defined_macro: $defs_bak,call: calls)
end