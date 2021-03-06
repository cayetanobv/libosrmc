rm -rf test_monaco
mkdir test_monaco
cd test_monaco

echo '--Downloading OSM file...'
wget http://download.geofabrik.de/europe/monaco-latest.osm.pbf

echo '--Processing - osm-extract...'
osrm-extract --profile=/usr/local/share/osrm/profiles/car.lua monaco-latest.osm.pbf

if [ "$1" = 'MLD' ]; then
  echo '--Processing - osm-partition...'
  osrm-partition monaco-latest.osrm

  echo '--Processing - osm-customize...'
  osrm-customize monaco-latest.osrm

  echo '--Finished MLD pipeline...'
else
  echo '--Processing - osrm-contract...'
  osrm-contract monaco-latest.osrm

  echo '--Finished CH pipeline...'
fi

# echo '--Starting http server - osm-routed...'
# osrm-routed --algorithm=MLD monaco-latest.osrm
