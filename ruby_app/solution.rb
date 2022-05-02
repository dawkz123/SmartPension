class Solution
	Array @file_arr

	def initialize
		if (ARGV.length > 0 && ARGV[0] != "")
			@file_arr = read_file(ARGV[0])
		end
	end

	def main
		total_occurances = self.count_occurances(@file_arr)
		total_unique_occurances = count_occurances(@file_arr.uniq)

		pretty_print("total", total_occurances)
		pretty_print("unique", total_unique_occurances)
		return total_occurances, total_unique_occurances
	end

	def read_file(filename)
		dat = Array.new
		raise "File not found!" if (!File.file?(filename))

		File.foreach(filename) {|line| dat.push(line)}
		return dat
	end

	def strip_IPs(site_arr)
		# Clone so we don't modify the map
		site_arr = site_arr.clone
		return site_arr.map! {|x| x[/^(\/[a-zA-Z_]*)+\d{0,1}/]}
	end

	def count_occurances(site_arr)
		return strip_IPs(site_arr).tally.sort_by{|site,occurances| -occurances}
	end

	def pretty_print(title, occurances_map)
		print "##########################\n"
		occurances_map.each do |site,occurances|
			print "#{site} : #{occurances} #{title} vists\n"
		end
		print "##########################\n"
		return
	end
end

if (ARGV.length > 0)
	Solution.new.main
end