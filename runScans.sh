#!/bin/bash
###########################################################
## Example script to run OpenSCAP scans one remote hosts ##
##                                                       ##
## Author: Chris Jenkins, Red Hat                        ##
## Note: This script is not officially supported by      ##
## Red Hat                                               ##
##                                                       ##
## Usage:                                                ##
## runScans.sh -i <inventory file>\                      ##
##             -t <tailoring file>                       ##
##                                                       ##
## The inventory should be a list of FQDNs, one per line ##
## The tailoring file should be the xml output from      ##
## the OpenSCAP Workbench used to create the file        ##
###########################################################

scanDir=/openscap/scan
vulnDir=/openscap/vulnerabilities

while getopts i:t: flag
do
  case "${flag}" in
    i) inventory=${OPTARG};;
    t) tailoringFile=${OPTARG};;
  esac
done

if [[ -z $inventory || -z $tailoringFile ]]
then
    echo " - Missing mandatory arguments: inventory and tailoring file. "
    echo " - Usage: ./runScans.sh -i <inventory file> -t <tailoring file>."
    exit 1
fi

if [[ ! -f $inventory ]] || [[ ! -f $tailoringFile ]]
then
  echo " - check both $inventory and $tailoringFile files exist"
  exit 2
fi
