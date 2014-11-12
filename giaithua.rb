def giaithua n
  tich = 1
  (2..n).each {|i| tich *= i}
  tich
end

def tohop n, k
  giaithua(n) / giaithua(k) / giaithua(n - k)
end
