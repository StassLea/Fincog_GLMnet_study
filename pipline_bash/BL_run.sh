#!/bin/bash

pipedir=~/Desktop/DTI-Analysis
mkdir -p $pipedir/batch

while read line
do

	subj=$(basename $line)
	cp $pipedir/pipeline-BL.sh ${pipedir}/batch/pipeline-BL_${subj}.sh
	sed -i -e "s/@@@@/$subj/" ${pipedir}/batch/pipeline-BL_${subj}.sh
	sed -i -e "s!????!$subjDIRECTORY!" ${pipedir}/batch/pipeline-BL_${subj}.sh

done < ${pipedir}/subs.txt
