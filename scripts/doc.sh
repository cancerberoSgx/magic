rm -rf types.xml docs
haxe scripts/doc.hxml
haxelib run dox -i types.xml --title "Magic" -D version 0.0.3 --include "(magic)" -o docs
rm -rf types.xml