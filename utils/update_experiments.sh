# Pull and push latest experiment results
# Alfredo Canziani, Mar 17

# Run it as
# ./update_experiments.sh
# ./update_experiments.sh -q  # quiet

if [ "$1" != "-q" ]; then verbose="--verbose"; fi

local=$(hostname)
case $local in
    "GPU0") remote=$GPU8;;
    "GPU8") remote=$GPU0;;
    *)      echo "Something's wrong"; exit -1;;
esac

# Get experimental data
if [ -n "$verbose" ]; then
    echo; printf "%.s#" {1..80}; echo
    echo -n "Getting experiments from $remote to $local"
    echo; printf "%.s#" {1..80}; echo; echo
fi
rsync \
    --update \
    --archive \
    $verbose \
    --human-readable \
    $remote:MatchNet/results/ \
    ../results

# Send experimental data
if [ -n "$verbose" ]; then
    echo; printf "%.s#" {1..80}; echo
    echo -n "Sending experiments to $remote from $local"
    echo; printf "%.s#" {1..80}; echo; echo
fi
rsync \
    --update \
    --archive \
    $verbose \
    --human-readable \
    ../results/ \
    $remote:MatchNet/results
