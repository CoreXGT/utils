#!/bin/bash

# $1=Method 1=Method_Titik_X,Y_1_dan_X,Y_2 2=Method_Top_Bottom_Left_Right
# $2=NamaFileInput
# $3=Titik1 X / Top
# $4=Titik1 Y / Bottom
# $5=Titik2 X / Left
# $6=Titik2 Y / Right
# $7=NamaFileOutput

    wh=$(identify $2 | cut -d " " -f 3)
    w_char=$(identify $2 | cut -d " " -f 3 | cut -d "x" -f 1 | wc -c)
    width_asli=$(identify $2 | cut -d " " -f 3 | cut -d "x" -f 1)
    height_asli=$(echo ${wh:${w_char}})

    case "$1" in
    1)
        echo "Method X1,Y1 and X2,Y2"
        x1=$3
        y1=$4
        x2=$5
        y2=$6
        top=${y1}
        bottom=$((${height_asli} - ${y2}))
        left=${x1}
        right=$((${width_asli} - ${x2}))
        width_crop=$((${width_asli} - $((${x1} + ${right}))))
        height_crop=$((${height_asli} - $((${bottom} + ${y1}))))
        ;;
    2)
        echo "Method_Top_Bottom_Left_Right"
        top=$3
        bottom=$4
        left=$5
        right=$6
        width_crop=$((${width_asli} - $((${left} + ${right}))))
        height_crop=$((${height_asli} - $((${bottom} + ${top}))))
        ;;
    *)
        echo "crop_image metode ($1) salah"
        ;;
    esac

    convert $2 -crop ${width_crop}x${height_crop}+${left}+${top} $7
    
#  ./crop.sh 1 6.png 905 16 1344 175 output1.png
#  ./crop.sh 2 6.png 16 489 905 22 output2.png
