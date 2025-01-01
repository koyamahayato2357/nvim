return {
	quickeval_cmd = 'scheme',
	snippet = {
		{ abbr = 'i', snip = '(if ${1:cond}\n  ${2:true}\n  ${3:false})' },
		{ abbr = 'fn', snip = '(define $1 (lambda ($2)\n  $3))' },
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end
}
