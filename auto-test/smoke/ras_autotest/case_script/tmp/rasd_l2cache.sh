#!/bin/bash

# L3 cache Error reading and reporting
# IN :N/A
# OUT:N/A

function mmount_rasd()
{
    mount > mount.txt
    mtmp=$(cat mount.txt | grep "debugfs" | wc -l)
    echo $mtmp
    if [ $mtmp -ne 1 ];then
        mount -t debugfs none /sys/kernel/debug/
        echo mount
    fi
    cd /home/mytest
    ./rasdaemon -f &
}

function l2cache_error_reading_and_reporting()
{
    Test_Case_Title="l3cache error injection"
    Test_Case_ID="ST.RAS.F003.A"
    cd /home/mytest
    insmod  test.ko |& tee file2
    cat file2
    flag=`cat file2 |grep -e 'event severity: recoverable' -e 'section_type: memory error.' -e '0x000000001234500' | wc -l`
    echo $flag
    if [ $flag -ne 3 ]; then
        echo fail
    else
        echo pass
    fi 
}

function main()
{
    JIRA_ID="PV-271"
    Test_Item="The driver must support reading and reporting l3cache error"
    Designed_Requirement_ID="R.RAS.F003.A.1620"
    l2cache_error_reading_and_reporting
}

main 