return {
	lsp = {
		name = 'texlab',
		cmd = { 'texlab' }
	},
	snippet = {
		{
			abbr = '!',
			snip = [[\documentclass[uplatex, dvipdfmx, a4paper]{ltjsarticle}
\usepackage{}
\title{$1}
\author{$2}
\date{}

\begin{document}
\maketitle
\newpage
$0
\end{document}]]
		},
		{ abbr = 'b', snip = '\\begin{${1:env}}\n$2\n\\end{${1:env}\n$0}' },
		{ abbr = 's', snip = '\\section{$1}\n$0' },
		{ abbr = 'sb', snip = '\\subsection{$1}\n$0' },
	}
}
