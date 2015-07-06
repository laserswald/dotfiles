#!/bin/sh

inbox(){
    folder=$1
    newmailc=$(ls $folder/new | wc -l)
    echo $newmailc
}
inbox $1
