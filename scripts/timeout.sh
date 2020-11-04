# Set a timeout on the given commands
# Example: timeout 5 sleep 3 => no timeout / timeout 1 sleep 3 => timeout
#
# perl is prefered to timeout(1) because not available natively on MacOS.
# Taken from here: https://gist.github.com/jaytaylor/6527607

function my_timeout() {
	alert=$(perl -e 'alarm shift; exec @ARGV' "$@")
	return $?
}
