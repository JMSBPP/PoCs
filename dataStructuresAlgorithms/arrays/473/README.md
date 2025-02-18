# Matchsticks to Square

You are given an integer array matchsticks where `matchsticks[i]` is the length of the ith `matchstick`. You want to use all the matchsticks to make one square. You should not break any stick, but you can link them up, and each matchstick must be used exactly one time.

Return `true` if you can make this square and `false` otherwise.


## Analysis

### Base Case
Notice the base case is given when `matchstick.lenght==4` and to form a square all matchsticks must have the same lenght.

Symbollicaly this is.

$$n=4 \implies (\forall_{i,j}\mid i,j \in [1:n] : n_i=n_j)$$

### Inductive Methods
We now need to analyze the case wher $n> 4$. Notice that for $n=5$, to form a sqaure with all matchsticks wee must find one pair and only one pair such that it's sum equals the rest of numbers in the array. 

This is:

$$n=5 \implies (\exists_{(i,j)}\mid i,j \in [1:n]: (\forall_{k}\mid  k \in [1:n]-\{i,j\}: n_i+n_j=n_k))$$

We can induce there is a mapping:

$$f: n\geq 4 \longrightarrow (n-4)$$
 Doing this for $n=6$ we characterize the properties that this sums msut comply with, which are:

 1. All $n-4$ sums need to be equal.
 2. The four remaining values in the set need to be equal with each other and the value of the sum.

Let:
$$+:\mathbb{N}\times \mathbb{N}\longrightarrow n+m$$

Then the set of `matchstick` of size $n$, $M_n$ make one square if and only if:

1. $n\geq4$
2. $(\exists_{A_{n-4}}\mid A_{n-4} \in \mathbb{P}(M_n): (\forall_{(i,j)} \mid i,j \in [0:n-4] \, \wedge i \neq j: \mid A_i\mid =2 \, \wedge +(A_i)=+(A_j)=\max(M_n) ))$.

3. $(\forall_m \mid m \in (M_n -A_{n-4}): m=\max(M_n))$

Symbollically:

$$\text{square}(M_n) \iff (1) \wedge (2) \wedge (3)$$

### How to find $A_{n-4}$ when possible ??

The answer is simple, notice that the least matchsticks a square side can have is one, which is the matchstick with the largest lenght.

1. Given there are more than $4$ numbers equal to the maxium of the array is guaranteed we do not have the square property, this is negating the $(3)$ predicate.
2. In case $(3)$ and $(1)$ holds we iterate over the array and for each number we map it with the rest and return the pair of that number and the corresponding paired numbers that sums to the maximum. Since each number can have more than a pair that sums to the maximum these are stored in a key-value mapping.
   
    2.1 This is making keys for all the numbers in the array and if there is one iwth no value. Then $(2)$ does not hold. 

$$\Lambda_{(n-4) \times (n-4)}(A_{n-4})=
\left(
\begin{matrix}
. & . & . & . & \cdots \\
. & . & . & . & \cdots \\
. & . & \Lambda_{ij}=+(A_i)=+(A_j)=\max(M_n) & \cdots \\
. & . & . & . & \cdots \\
. & . & . & . & \cdots \\
\end{matrix}
\right)$$

If there is one row in $\Lambda$ with no `true` value, we reject $(2)$, thus rejecting $\text{square}(M_n)$. outputting `false`, otherwise we outputn `true`.
