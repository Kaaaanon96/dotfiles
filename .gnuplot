###
### Default line colors and repeat cycle
###

set terminal aqua dashed

set linetype 1 lc rgb "dark-violet" lw 2
set linetype 2 lc rgb "#009e73" lw 2
set linetype 3 lc rgb "#56b4e9" lw 2
set linetype 4 lc rgb "#e69f00" lw 2
set linetype 5 lc rgb "#f0e442" lw 2
set linetype 6 lc rgb "#0072b2" lw 2
set linetype 7 lc rgb "#e51e10" lw 2
set linetype 8 lc rgb "black"   lw 2
set linetype 9 lc rgb "gray50"  lw 2
set linetype cycle 9


set dashtype 1 (1,4)
set dashtype 2 (5,5)
set dashtype 3 (10,10)
set dashtype 4 (20,10)
set dashtype 5 (30,10,5,10)
set dashtype 6 (30,10,5,10,5,10)
set dashtype 7 '.'
set dashtype 8 '-'
set dashtype 9 '_'
set dashtype 10 '-.'
set dashtype 11 '_-'
set dashtype 12 '_.-.'
