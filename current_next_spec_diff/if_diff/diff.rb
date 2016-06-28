#! /usr/bin/env ruby

def dff(ptn)
  puts "=================================================="
  puts ptn
  motas5= Dir.glob('redun/'+ ptn + '*.txt')
  current = Dir.glob('redundant/' + ptn +'*.txt')
  puts `diff #{current[0]} #{motas5[0]} 2>&1`
  puts
end

crnt = Dir::entries('redunt').select{|e| e.match(/^TL.+\.txt/)}.map{|e| e.gsub(/_.+$/,'')}
mts= Dir::entries('non_redundant').select{|e| e.match(/^.+\.txt/)}.map{|e| e.gsub(/_.+$/,'')}

(mts + crnt).uniq.each{|s| dff(s)}
