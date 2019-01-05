#!/bin/sh

# Stage 1, generate 4:3 backgrounds and optimize .pngs.

for background in `find . -type f -iname "background*.jpg"`; do
    path=$(dirname "$background")
    og_name=$(basename "$background")
    og_name="${og_name%.*}"
    resized_name="4x3-$og_name"

    if [ ! -f "$path/$resized_name.jpg" ]; then
    	echo "Generating $path/$resized_name.jpg"
    	convert "$path/$og_name.jpg" -resize 1280x1024^ -gravity center -crop 1280x1024+0+0 "$path/$resized_name.jpg"
    fi

    if [ ! -f "$path/$resized_name.png" ]; then
    	echo "Generating $path/$resized_name.png"
	    convert "$path/$og_name.jpg" -resize 1280x1024^ -gravity center -crop 1280x1024+0+0 "$path/$resized_name.png"
	    
	    echo "Optimizing $path/$resized_name.png"
	    /Applications/ImageOptim.app/Contents/MacOS/ImageOptim "$path/$resized_name.png" &>/dev/null
	fi
done

# Stage 2, update XML files.

for theme in `find . -type f -iname "theme.xml"`; do
    echo "$theme"
done