# LRA
## Abstract
Our codes are relative to the parper 'Single Pass Entrywise-Transformed Low Rank Approximation'.    

Our contribution is we could have a more fast rate than former algorithm with approximate low error. Finally, We realize the algorithms and check it.
However, our algorithm is just a basic realization and if you want to use the codes, you could download it and modify it according your comprehension to adapt different situation.


Tips: we use the same data set as former paper and you could download it from Wikipedia.(enwiki_cooccurrence_10k_10k.mat)
## Content
**Our codes mainly include two different parts.**
* The first is algorithm implementation.
* The second is algorithm check. 


### 1. Algorithm implementation
**We have one main function and five computing functions**
* Main.m ：completely realize the entire procedure
* init_A_function.m : initialize matrix A
* logsum.m
* Hsketch.m : sample every piece of A
* level_function.m : divide level in every piece of A
* sample_function.m : sample final matrix F from A we want to get

### 2. Algorithm check
**We check the accuracy and rate for verifying the effect of our algorithm improvement**
* check.m : completely realize the entire procedure
* SVD.m : compute svd value of A
* SVD_s.m : compute svd value of F
