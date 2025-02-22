return {
	quickeval_cmd = 'make -n -f ',
	snippet = {
		{ abbr = 'target', snip = '$1: $2\n\t$0' },
		{ abbr = 'p', snip = '.PHONY: $1' },
	}
}
