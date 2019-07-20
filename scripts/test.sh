# sh scripts/pack.sh && \
sh scripts/test-local.sh && \
# sh scripts/test-sample-project.sh
echo "Done"

CODE="$?"
echo "

Process exit: $CODE
"

exit $CODE