#!/bin/bash
MKGMAPJAR=$PWD"/tools/mkgmap/mkgmap.jar"
BOUNDS=$PWD"/bounds"
SEA=$PWD"/sea"
OPTIONS=$PWD"/opentopomap_options"
STYLEFILE=$PWD"/style/opentopomap"
TYPFILETXT=$PWD"/style/typ/opentopomap.txt"
TYPFILE=$PWD"/style/typ/opentopomap.typ"
DATA=$PWD"/images/6324*.pbf"

java -cp $MKGMAPJAR uk.me.parabola.mkgmap.main.TypCompiler $TYPFILETXT $TYPFILE
echo 'Compiled TYPFILE'
rm -rf "output/*"  || true
java -jar $MKGMAPJAR -c $OPTIONS --style-file=$STYLEFILE --family-name="Reedyn OSM Map ($(date +"%Y-%m-%d %H:%I"))" --precomp-sea=$SEA --output-dir=output --bounds=$BOUNDS $DATA $TYPFILE
echo "Copying file to root"
sleep 1
cp "output/gmapsupp.img" "OSM_Sweden_Reedyn.img"
echo "Done"
sleep 10
