
def print_m(m)
  m.each do |row|
    row.each { |a| print "%s " % a }
    print "\n"
  end
end

def do_reform_a(m, i, j)
  #~ для строки i, по всем j разделить a[i][j] на a[i-1][j]
  for k in (j).upto(m[i].length-1) do
    d = m[i][j] if not d
    puts "> %s" % d
    m[i][k] = (m[i][k].to_f)/(d.to_f)*(m[i-1][j].to_f)
  end
  
  m
end

def subt(m, i, j)
  m[i].each_with_index {|a,k| m[i][k] = m[i][k] - m[j][k] }
m
end

m = [[3,4,5,20], [1,2,3,10], [5,1,2,14]]

print_m(m)

m = do_reform_a(m, 1, 0)
m = do_reform_a(m, 2, 0)
m = subt(m, 1, 0)

print_m(m)
