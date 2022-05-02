require_relative "solution"
require "test/unit"

class TestSolution < Test::Unit::TestCase

	#### Test Solution.main ####
	# 4 total visits, 1 unique
	def test_A
		test_arr = Array.new(4, "/bloop 123.456")
		testSolutionA = Solution.new
		testSolutionA.instance_variable_set(:@file_arr, test_arr)

		expected_result = [[["/bloop", 4]],[["/bloop", 1]]]
		assert_equal(expected_result, testSolutionA.main)
	end

	# 4 total visits, 4 unique
	def test_B
		test_arr = ["/bloop 123.456", "/bloop 213.321", "/bloop 276.321", "/bloop 213.891"]
		testSolutionB = Solution.new
		testSolutionB.instance_variable_set(:@file_arr, test_arr)

		expected_result = [[["/bloop", 4]],[["/bloop", 4]]]
		assert_equal(expected_result, testSolutionB.main)
	end



	### Test Solution.read_file ###

	# file doesn't exist
	def test_C
		testSolutionC = Solution.new
		assert_raise("File not found!") {testSolutionC.read_file("bloop.log")}
	end

	# file read
	def test_D
		testSolutionD = Solution.new
		File.open("testfile.log", "w") {|f| f.write("/bloop 061.945.150.735")}
		expected_result = ["/bloop 061.945.150.735"]

		assert_equal(expected_result, testSolutionD.read_file("testfile.log"))

		File.delete("testfile.log")
	end


	### Test Solution.strip_IPs ###

	# strip ips from array
	def test_E
		testSolutionE = Solution.new
		test_arr = ["/bloop 123.456", "/bloop/2 213.321", "/bloop 276.321", "/bloop 213.891"]
		expected_result = ["/bloop", "/bloop/2", "/bloop", "/bloop"]

		assert_equal(expected_result, testSolutionE.strip_IPs(test_arr))
	end

end