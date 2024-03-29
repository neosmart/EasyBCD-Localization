#!/bin/sh

set exit_code=0
xmlvalidate() {
	schema=$1
	file=$2

	result=$(xmllint --schema $schema --encode utf-8 --noout "$file" 2>&1)
	status=$?
	if test $status -ne 0; then
		echo $result 1>&2
		exit_code=$status
	else
		echo $result
	fi
}

for file in $(find . -iname "*.xml" ! -iname "properties.xml"); do
	xmlvalidate ./schema/translation.xsd  $file
done

for file in $(find -iname "properties.xml"); do
	xmlvalidate ./schema/properties.xsd $file
done

exit $exit_code
