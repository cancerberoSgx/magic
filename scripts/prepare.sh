sh scripts/test.sh && \
sh scripts/doc.sh && \
npx markdown-toc README.md -i && \
cd browser-project && \
sh build.sh && \
echo "Done"

CODE="$?"
echo "

Process exit: $CODE
"

exit $CODE