#!/bin/bash
COMMANDNAME=$1
LISTOFNUMBERS=$2
echo '*** build started***'
echo 'something will be built here'

if [ $COMMANDNAME=="high" ]; then
    echo "highfi command"
else
    echo "low standard command"
fi

echo 'Display list of numbers'
for name in ${LISTOFNUMBERS[@]}; do
    echo ${name}
done
echo '*** build ends ****'
