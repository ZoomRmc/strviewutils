# strviewutils
Experimental testing with views to reduce multiple allocations

Below is a comparison to the `std/strutils`, the file can be found in `/tests/benchmark`, compiled with `--gc:arc -d:danger`

```
name ............................... min time      avg time    std dv   runs
Views Single Char Split ............ 4.779 ms      5.006 ms    ±0.130  x1000
Stdlib Single Char Split ........... 8.606 ms      8.902 ms    ±0.166  x1000
Views Multi Char Split ............. 8.495 ms      8.791 ms    ±0.163  x1000
Stdlib Multi Char Split ........... 12.772 ms     13.124 ms    ±0.227  x1000
Views Int Parse .................... 4.743 ms      4.991 ms    ±0.258  x1000
Stdlib Int Parse ................... 8.879 ms      9.174 ms    ±0.179  x1000
View String Split .................. 6.220 ms      6.476 ms    ±0.153  x1000
Stdlib String Split ................ 7.261 ms      7.559 ms    ±0.191  x1000
```