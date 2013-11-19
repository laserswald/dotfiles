#!/bin/sh
folder=$1
newmailc=$(ls $folder/new | wc -l)
echo $newmailc
