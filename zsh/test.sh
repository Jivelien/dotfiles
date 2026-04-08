echo 'pwd :' $(pwd)
echo '$0:' $(dirname $(realpath $0))
echo '$0:' $(dirname $0)
echo '$0:' $(basename $0)

echo $(pwd)/$(dirname $0)
