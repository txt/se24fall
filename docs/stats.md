% stats



## Tl;DR

Place the numbers seen in different samples in a file, separated by the treatment name. e.g [stats.txt](stats.txt)

Change the last line of stats.py to `egSlurp()`.

Run `python3 stats.py`.

Collect your Nobel prize.

## Does 42==44?

If we watched 100 women and men walk past us and their mean walking tipped was 42 and 44 cm/second (for men and women respectively), it is true that men walk faster than women?

This is an example of the problem of comparing samples. Which can get tricky.

![image](https://github.com/txt/aa24/assets/29195/5b1331fc-3bba-470e-a6d1-407bac9b7fb6)


These problem as two parts:

- Are the samples distinguishable?
  - If we picked a number from one sample, can we tell of it can be found on the other?
  - This is the (badly named) singificance test.
- Is the difference between them non-trivial:
  - This is the effect size test
  - And we want to ignore small effects.


SE example:

<img src="bugs.png" width=400 align=right>

- Consider software built by teams who are either (a) located in the same site or (b) distributed around the globe.
i- Distributed development is infamous for lower quality due to geographical
dispersion  which raises issues of communication,
and problems building mutual confidence among distributed
teams.
- However, in 2009, Bird et al. [^bird] checked for those
effects in distributed Microsoft projects.
  - They found that
    management can successful mitigate for these detrimental
    effects (team members need to be organized along product
    lines and not on their geographical location).
- But in 2013, Kocaguneli et al. [^ekrem] reported a statistically significant effect (a decrease) in the quality of software generated by Microsoft's distributed development team (compared to developers who worked locally together).
  - However, they could that the difference in quality was a "small effect"; i.e. neglicable
  - i.e. it was not irresponsible for Microsoft to continue on with distributed development.

Note that the above needed precise definitions for _statistically significant effect_ and _small effect size_. How to find those?


[^bird]: C. Bird, N. Nagappan, P. T. Devanbu, H. Gall, and B. Murphy. Does
distributed development affect software quality? an empirical case study
of windows vista. In ICSE, pages 518–528, 2009.

[^ekrem]: Kocaguneli, E., Zimmermann, T., Bird, C., Nagappan, N., & Menzies, T. (2013, May). Distributed development considered harmful?. In 2013 35th International Conference on Software Engineering (ICSE) (pp. 882-890). IEEE.

## East Case: means far away and the curves do not overlap

- So the curves are significantly different
- with large effect

![image](https://github.com/txt/aa24/assets/29195/3a0eaad2-4986-463b-a1f0-e26d8500efae)


Now we increase the standard deviation.

- So much overalp. Curves may not be significantly different
- And now that mean seperation seems less different

![image](https://github.com/txt/aa24/assets/29195/ee3e7184-4f78-4c88-bd66-34c2d61c98e5)

## Terminology

We _sample_ under different _treatments_ (e.g. we put weights on our people, then ask them to walk around)

- and the _sample size_ is the number of measurements made per _treatment_.

Sometimes we assume _samples_ come from different _distributions_ (e.g. normal, binomial, etc).

We want to know how to separate _samples_ that are _significty distinguisable_, by more than a _small effect size_.

## Parametric Statistical Tests

If we assume that our data comes from a certain distrubtion then we could write a formula to compute the overlap or, if we throw darts at both diistributions, waht are the odds
that we will hit numbers from one distribution, not aother.

This is called parametric statisitics. You assume a formula (e.g. Gaussian) then look to filling in the parameters of that distribution (for Gaussian, the mean $\mu$ and the standard deviation $\sigma$ ).

But there are so many distributions so it is not clear what formula we should use.

![image](https://github.com/txt/aa24/assets/29195/0d871993-9ddd-4535-aad3-b1d567310e08)

Also, reall world data may be conform to a simple single distribution. For exam,e here are the query times for 50 SQL statements in one program.

<img src="https://github.com/txt/aa24/assets/29195/3ad878b4-4f47-4db2-9a2c-c3e74ac97c29)" width=400>


## Non-parametric stats

### Scott-Knott:

Many statistical methods (e.g.  t-test, Tukey, Duncan, Newman-Keuls procedures) suffer from  have overlapping
problems.
- By overlapping we mean the possibility of one or more sample to be classified in
more than one group.
- In fact, as the number of samples increase, so to does the the number of overlaps, which makes it hard  to
    distinguish the real groups to which the means should belong.
- The Scott-Knott method [^sk] does not have this problem, what is often cited as a very good quality of this
procedure.

Scott-Kott is a recursive clustering procedure that
- sorts the samples
- divided them on the largest expected difference in the mean before and after division
- then recuses on each half, but only if the two halfs are statistically different

The halves are picked to maximize:

$$    E(\Delta) = \frac{|l_1|}{|l|}abs(E({l_1}) - E({l}))^2 + \frac{|l_2|}{|l|}abs(E({l_2}) - E({l}))^2$$

(here   $|l_1|$ means the size of list $l_1$)


[^sk]: Scott R.J., Knott M. 1974. A cluster analysis method for grouping mans in the analysis of variance.
Biometrics, 30, 507-512.

For example, support I had four samples labelled _x1,x2..._ etc

```python
def eg2():
  eg0([ NUM([0.34, 0.49 ,0.51, 0.6] ,   "x1"),
        NUM([0.6  ,0.7 , 0.8 , 0.89] ,  "x2"),
        NUM([0.13 ,0.23, 0.38 , 0.38] , "x3"),
        NUM([0.6  ,0.7,  0.8 , 0.9] ,   "x4"),
        NUM([0.1  ,0.2,  0.3 , 0.4] ,   "x5")])

def eg0(nums):
  all = NUM([x for num in nums for x in num.has])
  [print(all.bar(num,width=40,word="%4s", fmt="%5.2f")) for num in sk(nums)]
```
I would sort them by their median value the draw a little box plot of their 10-to-30th values, their median, and their 70-to-90th value:

```
sk
rank  rx   median IQR                                              10th   30th   50th   70th   90th
====  ==   ====== ====                                             =====  ====   =====  ====   ====
 0,   x5,  0.30,  0.10, -----    *-----     |                   ,  0.10,  0.20,  0.30,  0.30,  0.40
 0,   x3,  0.38,  0.15,  -----        *     |                   ,  0.13,  0.23,  0.38,  0.38,  0.38
 1,   x1,  0.51,  0.02,             ------- *----               ,  0.34,  0.49,  0.51,  0.51,  0.60
 2,   x2,  0.80,  0.10,                     |    -----     *--- ,  0.60,  0.70,  0.80,  0.80,  0.89
 2,   x4,  0.80,  0.10,                     |    -----     *----,  0.60,  0.70,  0.80,  0.80,  0.90
```
Note the left-handside `sk rank` column. This reports what happens after SK sorts the samples and decides which ones are different
- A treatment has the same ranked the one before it,
  - it is not statistically distinguishable
  - by more than small effect.

But how does it do it? The Scott & Knott method make use of a top-down clustering algorithm, where, starting from
the the whole group of observed mean effects, it divides, and keep dividing the sub-groups in such
a way that the intersection of any two groups formed in that manner is empty.

This means that $N$ samples might  get ranked using    only $\log_2(N)$ statistical comparisons
- and even less, if ever sub-trees high up int the process are found to be not statistically different
- Also, Scott-Knott converts the  problem of ranking samples to clustering probkem (which I do understand) rather than a stats problem (which, in all fairness, I understand only weakly).


```python
def sk(nums):
  "sort nums on median. give adjacent nums the same rank if they are statistically the same"
  def sk1(nums, rank,lvl=1):
    all = lambda lst:  [x for num in lst for x in num.has]
    b4, cut = NUM(all(nums)) ,None
    max =  -1
    for i in range(1,len(nums)):
      lhs = NUM(all(nums[:i]));   #every sample before "i"
      rhs = NUM(all(nums[i:]));   #every sample from "i" and upwards
      tmp = (lhs.n*abs(lhs.mid() - b4.mid()) + rhs.n*abs(rhs.mid() - b4.mid()))/b4.n
      if tmp > max:
         max,cut = tmp,i
    #-----------------------------------------------------
    if cut and different( all(nums[:cut]), all(nums[cut:])):
      # we have found a difference that matters, se we recurse
      rank = sk1(nums[:cut], rank, lvl+1) + 1   # the samples after the cut have rank one more than before
      rank = sk1(nums[cut:], rank, lvl+1)
    else:
      # we have not found a different,
      for num in nums: num.rank = rank # all treatments get the same rank
    return rank
  #------------
  nums = sorted(nums, key=lambda num:num.mid())   # before we start, make sure we sort things
  sk1(nums,0)
  return nums # return the treatements, sorted and ranked.
```

## different()
But how to code up `different`?. Recall that this needs two functions

- Are the sample distinguishable?
  - If we picked a number from one sample, can we tell of it can be found on the other?
- Is the difference more than a small effect?
  - This is the effect size test

```python
def different(x,y):
  "non-parametric effect size and significance test"
  return _cliffsDelta(x,y) and _bootstrap(x,y)
```
Note that that this is a conjuction; i.e. to prove "different" I have to prove both things.

### CliffsDelta (non-parametric effect size)

This code is simple. For everything $x$ in one sample, look in the other sample
- Count how often there are bigger and larger numbers in the other sample.
- If $x$ has many numbers less and greater than me, then I tend to be the same as the other sample
  - Since I tend to fall to the middle of the other sample

```python
def _cliffsDelta(x, y, effectSize=0.2):
  """non-parametric effect size. threshold is border between small=.11 and medium=.28
     from Table1 of  https://doi.org/10.3102/10769986025002101"""
  n,lt,gt = 0,0,0
  for x1 in x:
    for y1 in y:
      n += 1
      if x1 > y1: gt += 1
      if x1 < y1: lt += 1
  return abs(lt - gt)/n  > effectSize # true if different
```

### Bootstrap (non-parametric test for "distinguish-ablity")

- Summarize the difference in   two samples with some `obs` (observartion)
- Hundreds of times
  - Sample with replacement from both samples
  - Count how often the observation is larger than the baseline `obs`.
- The higher that count, the harder it is to seperate you
  - so the lower that count, the more we are sure you are different.

Here's the code for that. `yhat` and `zhat` are transforms recommended by
 Efron and Tibshirani to level the playing field (ensures that both distribution s
 are scored on mean value that is common to both distributions).

```python
def _bootstrap(y0,z0,confidence=.05,Experiments=512,):
  """non-parametric significance test From Introduction to Bootstrap,
     Efron and Tibshirani, 1993, chapter 20. https://doi.org/10.1201/9780429246593"""
  obs = lambda x,y: abs(x.mu-y.mu) / ((x.sd**2/x.n + y.sd**2/y.n)**.5 + 1E-30)
  x, y, z = NUM(y0+z0), NUM(y0), NUM(z0)
  d = obs(y,z)
  yhat = [y1 - y.mu + x.mu for y1 in y0]
  zhat = [z1 - z.mu + x.mu for z1 in z0]
  n      = 0
  for _ in range(Experiments):
    ynum = NUM(random.choices(yhat,k=len(yhat)))
    znum = NUM(random.choices(zhat,k=len(zhat)))
    if obs(ynum, znum) > d:
      n += 1
  return n / Experiments < confidence # true if different
```

## Things to Note

### Blurring


“The point was that you have to look at the world as it is, not as some elegant theory says it ought to be.”
— M. Mitchell Waldrop

<img src="blurring.png" align=right width=500>

When dealing with many treatments with larte variance,

- results may "_blur_"
- i.e. many of them are statistically indistinguishable.

For example, at left,  51 of the 55
treatments all receive the same rank.

When such blurring occurs,

- we can conclude is that some of the distinctions made during sampling were unimportant
  (in the sense that it does not distinguish the individual treatments).
- Which can lead to some startling results....


For another example, consider [knn results](https://github.com/timm/lean/blob/master/src/knn.lua) that scores nearest-neighbor regression
using $100*(predicted-actual)/predicted$

- Using $k \in \{1,2,4,8}$ nearest neighbors
- Via  training set that contains $N \in \{512,256,128,32\}$  rows selected at random from auto.csv
- Using a distance function $p \in \{1,2,4,8\}$  for $(\sum_i (x_i-y_i)^p)^{1/p}$ (and recall that $p=2$ is Euclidean)
- Where the conclusions of those near neighbors are combined via a  median or  triangular kernel function
  - median means "pick the middle value"
  - triangular means "closer values are weighted more"

$$ \mathit{prediction}= \frac{\sum_i n_i/d_i}{\sum_i 1/d_i} $$

Please consider $(k=4,p=4, N=32, f=\mathit{triangle})$. Notice anything interesting?
###  Runtimes and Storage

Parametric stats are very fast and consume little memory (jsut the memory required for the params).

Non-parametric stats are slower (see all that sampling inside `_bootstrap` and that $O(N^2)$ traversal inside `cliffsDelta`).
So don't run non-parametric tests inside the inner-most loop of your reasonong.

If you need a quick and dirty check for differences, just check if the mean difference is larger than a third of the standard deviation of the sample. No, this test is not well-founded. But it is useful
as a heuristic.

Then,  once you have  collected results from (say) 20 repeated runs, run these non-parametric tests as part of your final report generation.

### Statistical Wars

So much discussion of "what stats is best". Very little experimentation on data.

here,s we asking cfliffsDelta (cd), boostrapping (boot), conjuction of both, and sd/3 if two sample are different wjere

- sample1 is 20  numbers from a gaussian (mean=10, sd=3)
- sample2 is just $x_i * \mathit{inc}$

Note the large areas of agreement, with a small dispute zone in the middle.

|inc  |cd  |boot  |c+b  |sd/3|dispute?|
|---|---|---|--|--|:--:|
|1 |False |False |False |False||
|1.02 |False |False |False |False||
|1.04 |False |False |False |False||
|1.061 |False |False |False |False||
|1.082 |False |False |False |False||
|1.104 |True |False |False |False|n|
|1.126 |False |False |False |True|n|
|1.149 |True |False |False |True|n|
|1.172 |True |False |False |True|n|
|1.195 |True |False |False |True|n|
|1.219 |True |True |True |True||
|1.243 |True |False |False |True|n|
|1.268 |True |True |True |True||
|1.294 |True |True |True |True||
|1.319 |True |True |True |True||
|1.346 |True |True |True |True||
|1.373 |True |True |True |True||
|1.4 |True |True |True |True||
|1.428 |True |True |True |True||
|1.457 |True |True |True |True||
|1.486 |True |True |True |True||
