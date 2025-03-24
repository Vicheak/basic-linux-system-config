#!/usr/bin/ruby
print "Content-type: text/html\n\n";
print "<html>\n<body>\n";
print "<div style=\"width: 100%; font-size: 40px; font-weight: bold; text-align: center;\">\n";
print Time.now.strftime('%Y/%m/%d');
print "\n</div>\n";
print "</body>\n</html>\n";