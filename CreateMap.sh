#!/bin/bash
SPLITTERJAR=$PWD"/tools/splitter-r653/splitter.jar"
SEA=$PWD"/sea/sea"
MKGMAPJAR=$PWD"/tools/mkgmap-r4905/mkgmap.jar"
BOUNDS=$PWD"/bounds"
OPTIONS=$PWD"/opentopomap_options"
STYLEFILE=$PWD"/style/opentopomap"
TYPFILETXT=$PWD"/style/typ/opentopomap.txt"
TYPFILE=$PWD"/style/typ/opentopomap.typ"
DATA=$PWD"/images/6324*.pbf"
SOURCE=$PWD"/sweden-latest.osm.pbf"

rm -rf "images"
mkdir images
cd images
java -jar $SPLITTERJAR --precomp-sea=$SEA $SOURCE
java -cp $MKGMAPJAR uk.me.parabola.mkgmap.main.TypCompiler $TYPFILETXT $TYPFILE
cd ..
echo 'Compiled TYPFILE'
rm -rf "output"  || true
mkdir output
java -jar $MKGMAPJAR -c $OPTIONS --style-file=$STYLEFILE --family-name="Reedyn OSM Map ($(date +"%Y-%m-%d %H:%I"))" --precomp-sea=$SEA --output-dir=output --bounds=$BOUNDS $DATA $TYPFILE
echo "Copying file to root"
sleep 1
cp "output/gmapsupp.img" "OSM_Sweden_Reedyn.img"
rm -rf "output"  || true
echo "Done"