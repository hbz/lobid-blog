#!/bin/bash

for DIR in $(find ./snapshots ./releases -type d); do
  (
    STRIPPED=`echo $DIR | cut -c 2-`
    echo "<html>\n<body>\n<h1>Index of lobid.github.com"$STRIPPED "</h1>\n<hr/>\n<pre>"
    ls -1pa "${DIR}" | grep -v "^\./$" | grep -v "^index\.html$" | awk '{ printf "<a href=\"%s\">%s</a>\n",$1,$1 }'
    echo "</pre>\n</body>\n</html>"
  ) > "${DIR}/index.html"
done
