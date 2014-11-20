Math.class_eval do
	class << self
		def fact n, k = 1
			return 1 if n == 0
			raise "Some thing wrong !!!" if n < 0 || k < 0 || n < k
			(k..n).inject(1){|r, i| r *= i}
		end

		def comb n, k
			raise "Some thing wrong !!!" if n < 0 || k < 0 || n < k
			fact(n, n - k + 1) / fact(k)
		end

		def arrange n, k
			raise "Some thing wrong !!!" if n < 0 || k < 0 || n < k
			puts n - k
			fact(n) / fact(n - k)
		end	

		def permutation n, k
			raise "Some thing wrong !!!" if n < 0 || k < 0 || n < k
			n ** k
		end
	end
end