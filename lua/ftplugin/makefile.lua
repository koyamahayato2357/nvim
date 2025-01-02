return {
	quickeval_cmd = 'make -n -C ',
	snippet = {
		{ abbr = 'target', snip = '$1: $2\n\t$0' },
		{ abbr = 'p', snip = '.PHONY: $1' },
	}
}
