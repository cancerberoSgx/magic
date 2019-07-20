cd .. && \
sh scripts/pack.sh && \
cd browser-project && \
haxelib install ../magic.zip && \
rm -rf bin && \
haxe project.hxml && \
cp static/* bin && \
rm -rf ../docs/playground && \
mkdir -p ../docs/playground && \
cp -r bin/* ../docs/playground && \
echo "Done"

CODE="$?"
echo "

Process exit: $CODE
"

exit $CODE