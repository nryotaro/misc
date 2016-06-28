#! /usr/bin/env ruby

def dff(ptn)
  puts ptn
  old= Dir.glob('old/'+ ptn + '*.txt')
  current = Dir.glob('current/' + ptn +'*.txt')
  system("diff #{current[0]} #{old[0]}")
  puts
end
current=[]
old=[]

(current + old).uniq.each{|s| dff(s)}
