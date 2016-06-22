#! /usr/bin/env ruby

lib=`ls lib`.split(/\r?\n/).reject{|e| e.match(/.+(javadoc|sources)\.jar$/)}
elems = lib.map{|item|  "<zipfileset excludes=\"META-INF/*.SF,META-INF/*.DSA,META-INF/*.RSA\" src=\"${lib.dir}/#{item}\"/>"  }

elems.each{|e| puts e}
