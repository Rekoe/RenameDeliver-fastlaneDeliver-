#!/bin/sh

#创建使用deliver上传appstore方式的文件夹

dist="/Users/tianww/.jenkins/jobs/ASO/workspace/fastlane/screenshots"#需要fastlane上传的目录，外部修改

curDir=`pwd`
screentDir="$curDir/screenshots"
zh_hanDir="$screentDir/zh-Hans"

if [ -d $screentDir ];then
rm -rf $screentDir
mkdir $screentDir
mkdir $zh_hanDir
else
mkdir $screentDir
mkdir $zh_hanDir
fi

function renamePngName(){
echo "dir is:$1"
fileName="$curDir/$1"
deviceName="iphone35"
for pngName in $(ls $fileName)
    do
        if [ $1 == "640x960" ]
        then
        deviceName="iphone35"
        elif [ $1 == "640x1136" ]
        then
        deviceName="iphone4"
        elif [ $1 == "750x1334" ]
        then
        deviceName="iphone6"
        elif [ $dir == "1242x2208" ]
        then
        deviceName="iphone6Plus"
        else
        echo "good 5"
        fi

        if [[ $pngName =~ ".jpg" ]]
        then
        echo "deviceName is:$deviceName"
        number=`echo $pngName | cut -d '.' -f 1`
        renameJpg="$number"_"$deviceName"_"$number"."$number"_"$number"."$number".jpg
        echo "renameJpg is:$renameJpg"
        cp $fileName/$pngName $zh_hanDir
        mv $zh_hanDir/$pngName $zh_hanDir/$renameJpg
        fi
    done
}

function deliverScreenshots(){
    if [ -d $dist ];then
    rm -rf "$dist"
    mkdir $dist
    else
    mkdir $dist
    fi

    cp  -rp $screentDir/* $dist #复制文件到文件到目标文件只是截图
    cd "$dist"
    cd ..
    echo "进入___"`pwd`
    deliver screenshots #将替换的截图上传到appstore
}

#遍历当前一级目录符合640x960，640x1136，750x1334，1242x2208文件夹
basicFiles="640x960 640x1136 750x1334 1242x2208"
for dir in $(ls $curDir)
    do
      for file in $basicFiles
      do
        if [ $dir == $file ]
        then
            renamePngName $dir
            deliverScreenshots
        fi
      done
    done


