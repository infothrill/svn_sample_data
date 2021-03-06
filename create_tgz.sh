#!/bin/bash

THEREPO=therepo
INITIAL=initial-wc
THECHECKOUT=thecheckout

rm -rf ${THEREPO}
rm -rf ${INITIAL}
rm -rf ${THECHECKOUT}
rm -rf ${THECHECKOUT}.tgz

# create empty repo
svnadmin create ${THEREPO}

# create an initial working dir to be imported in therepo
mkdir ${INITIAL}
mkdir ${INITIAL}/trunk
mkdir ${INITIAL}/branches
mkdir ${INITIAL}/tags

echo "I am just a boring file" > ${INITIAL}/trunk/afile
echo "I am another boring file" > ${INITIAL}/trunk/anotherfile 

svn import -m "initial" ${INITIAL} file:///${PWD}/${THEREPO}

rm -rf ${INITIAL}

# create a branch
svn copy file:///${PWD}/${THEREPO}/trunk file:///${PWD}/${THEREPO}/branches/abranch -m "branch created"

# checkout trunk
svn co file:///${PWD}/${THEREPO}/trunk ${THECHECKOUT}

# modified file
echo "I am a hot file that wants to be modded" > ${THECHECKOUT}/hotfile 
svn add ${THECHECKOUT}/hotfile
svn commit -m "a file that is tracked that we will now modify" ${THECHECKOUT}/hotfile
echo "A modification" >> ${THECHECKOUT}/hotfile

# added file
echo "I am an added file" > ${THECHECKOUT}/anewfile 
svn add ${THECHECKOUT}/anewfile

# untracked file
echo "I am untracked" > ${THECHECKOUT}/untracked_file 

# ignored file
echo "ignore me" > ${THECHECKOUT}/ignoreThis.txt
cd ${THECHECKOUT} && svn propset svn:ignore ignoreThis.txt . && cd ..

echo "############ Status:"
svn status --no-ignore ${THECHECKOUT}

tar cvzf ${THECHECKOUT}.tgz ${THECHECKOUT}
tar cvzf ${THEREPO}.tgz ${THEREPO}
