#!/usr/bin/env ruby
#
a = $stdin.readlines.map{|e| e.gsub(/:.+$/, "") }
puts a.uniq

