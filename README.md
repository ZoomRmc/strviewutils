# strviewutils
Experimental testing with views to reduce multiple allocations

Below is a comparison to the `std/strutils`, the file can be found in `/tests/benchmark`, compiled with `--gc:arc -d:danger`

```
name ............................... min time      avg time    std dv   runs
Views Single Char Split ............ 4.424 ms      4.718 ms    ±0.177  x1000
Stdlib Single Char Split ........... 8.639 ms      9.459 ms    ±0.595  x1000
Views Multi Char Split ............. 8.404 ms      9.130 ms    ±0.402  x1000
Stdlib Multi Char Split ........... 12.251 ms     12.660 ms    ±0.283  x1000
Views Int Parse .................... 9.897 ms     10.426 ms    ±0.344  x1000
Stdlib Int Parse .................. 14.421 ms     14.939 ms    ±0.371  x1000
View String Split .................. 6.245 ms      6.550 ms    ±0.158  x1000
Stdlib String Split ................ 7.630 ms      8.140 ms    ±0.350  x1000
```