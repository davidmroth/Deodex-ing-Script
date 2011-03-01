#!/bin/bash

smalibaksmali_dir=/home/mistadman/bin/android_dev_tools

clear; for x in `find -iname "*.odex"|sort`; do 
    odexFile=${x/\.\//}
    [ -e ${file1/odex/jar} ] && JarFile=${odexFile/odex/jar} || Jarfile=${odexFile/odex/apk}

    echo "Uncompiling $odexFile"
    java -Xmx512m -jar $smalibaksmali_dir/baksmali.jar -x $odexFile -o /tmp/$odexFile.out 
    java -Xmx512m -jar $smalibaksmali_dir/smali.jar /tmp/$odexFile.out -o /tmp/$odexFile-classes.dex

    echo "Adding classes.dex to $JarFile"
    mv /tmp/$odexFile-classes.dex /tmp/classes.dex
    zip -q $JarFile /tmp/classes.dex
    rm -rf $odexFile /tmp/$odexFile.out /tmp/$odexFile-classes.dex /tmp/classes.dex
    echo
done
