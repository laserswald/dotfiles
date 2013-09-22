#!/bin/sh

volpercent=$( amixer sget Master | grep "%" | sed "s/.*\[\([0-9].*\)%\].*/\1/" )

echo $volpercent
