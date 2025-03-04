# obsession
startup time

# startup time
Example of running vim-startuptime
```sh
vim-startuptime -vimpath ~/.local/bin/nvim -count 1000 -- makefile
```
```
Extra options: [makefile]
Measured: 1000 times

Total Average: 7.989744 msec
Total Max:     9.438000 msec
Total Min:     7.166000 msec

...
```
```sh
# subject of comparison
vim-startuptime -vimpath ~/.local/bin/nvim -count 1000 -- makefile --clean
```
```
Extra options: [makefile --clean]
Measured: 1000 times

Total Average: 5.033853 msec
Total Max:     6.676000 msec
Total Min:     4.550000 msec

...
```
