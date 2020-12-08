# maxima-playground
Personal configuration of the Maxima CAS

### belln.lisp
Binary splitting method for computing bell number using Dobinski's formula:  
![formula](https://wikimedia.org/api/rest_v1/media/math/render/svg/3510fe21654a45f1fa5ddef0b1ee09f5a02c60df)

### catalan.lisp
Binary splitting method for computing Catalan's constant: 0.915965594177219...  
```
(%i1) bfloat(%g),fpprec:1000;
```

### exprat.lisp
Binary splitting method for computing exp(small rational number).  
```
(%i1) bfloat(exp(1/3)),fpprec:10^6;
```

### getpi.lisp
Get %pi's 1 million digits without using bigfloat in 1 sec (with sb-gmp).

### log2.lisp
Alternative ways to compute log(2).

### misc.lisp
Redefine fpround and number-of-digits to get more efficient bigfloat formatting.  
Redefine $bfloat to handle extra constants like Catalan's constant, zeta funtion in positive integer.  
Redefine displa to let maxima display bignum in one line and properly display bigfloat like 0.5772156649015329  
instead of 5.772156649015329b-1 .

### part.lisp
Calculate partition function p(n) using [python-flint](https://github.com/fredrik-johansson/python-flint) [arb] and parse it into a lisp bignum.  
Fredrik Johansson's arb implementation is super efficient and nearly optimial. See [his blog](http://fredrikj.net/blog/2014/03/new-partition-function-record/).  
```
(%i1) numpart(10^9);
```

### primepi.lisp
Compute primecount function, nth-prime function and primesum function using Kim Walisch's [primecount](https://github.com/kimwalisch/primecount)  
and my cffi bindings lib [cl-primecount](https://github.com/AaronChen0/cl-primecount).  
```
(%i1) primepi(10^14);  
(%o1) 3204941750802
(%i2) prime(10^14);  
(%o2) 3475385758524527  
(%i3) primesum(10^10);
(%o3) 2220822432581729238
```

### zeta.lisp
Borwein's method to compute zeta function in positive integer (translated from [PARI/GP](https://pari.math.u-bordeaux.fr/), faster than maxima's general implementation.  
```
(%i1) bfloat(zeta(5)),fpprec:10^4;
```

### zeta3.lisp
Binary splitting method for computing Apery's constant aka zeta(3). (Amdeberhan-Zeilberger formula)  
```
(%i1) bfloat(zeta(3)),fpprec:10^5;
```
