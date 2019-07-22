sh scripts/test-local.sh && \
echo "Done"

CODE="$?"
echo "

Process exit: $CODE
"

exit $CODE