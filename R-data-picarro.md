MORE reproducible data analysis using R
========================================================
author: Ben Bond-Lamberty
date: August 2016
font-family: 'Helvetica'

A workshop covering reproducibility and repository design; data cleaning and reshaping; and using the `dplyr` package for computation.

JGCRI


The plan
========================================================

* Introduction: reproducible research and repository design (45 minutes; hands-on: installing the packages we'll need)
* Examining and cleaning data (45 minutes; hands-on: the `iris` and `Pew` datasets, CMIP5 example)
* Summarizing and manipulating data (45 minutes; hands-on: the `babynames` dataset)

**This workshop assumes you understand the basics of R.**

Feedback: <a href="mailto:bondlamberty@pnnl">bondlamberty@pnnl.gov</a> or  [@BenBondLamberty](https://twitter.com/BenBondLamberty).


Is R the right tool for the job?
========================================================

R is great, but it might not be the right (or at least only) thing you want. There are other tools that might be better for your specific need!
- Python, C++, Hadoop, CDO/NCL, bash, ...


Reproducibility and repositories
========================================================
type: section


Reproducibility
========================================================

We are in the era of collaborative 'big data', but even if you work by yourself with 'little data' you have to have some skills to deal with those data, now and in the future.

>Your most important collaborator is your future self. It’s important to make a workflow that you can use time and time again, and even pass on to others in such a way that you don’t have to be there to walk them through it. [Source](http://berkeleysciencereview.com/reproducible-collaborative-data-science/)

Reproducibility generally means *scripts* or *programs* tied to *open source software*.


Reproducibility
========================================================

...is not all or nothing. A great, succinct resource here is Karl Broman's "initial steps toward reproducible research" webpage:

http://kbroman.org/steps2rr/

>Organizing analyses so that they are reproducible is not easy. It requires diligence and a considerable investment of time: to learn new computational tools, and to organize and document analyses as you go.

>But partially reproducible is better than not at all reproducible. Just try to make your next paper or project better organized than the last.


You can't reproduce
========================================================
...what doesn't exist.

**Gozilla ate my computer!**
* *automated* backup
* ideally *continuous*

**Godzilla destroyed my office!!!!!!**
* offsite (cloud)

***

<img src="images/godzilla.jpg" width="400" />


You can't reproduce
========================================================

...what you've lost. What if you need access to a file as it existed 1, 10, or 100, or 1000 days ago?
- Incremental backups (minimum)
- Version control (better). A *repository* holds files and tracks changes: what, by whom, why

***

<img src="images/tardis.jpg" width="400" />


Version control
========================================================

**Git** (and website **GitHub**) are the most popular version control tools for use with R, and many other languages:
- version control
- sharing code with collaborators in a *repository*
- issue tracking
- public or private

***

<img src="images/github.png" width="400" />


Reproducible research example
========================================================

A typical project/paper directory for me:
```
1-download.R
2-process_data.R
3-analyze_data.R
4-make_graphs.R
logfiles/
processed_data/
rawdata/
outputs/
```

This directory contains (and perhaps other) *scripts* that are backed up both *locally* and *remotely*. It is under *version control*, so it's easy to track changes, by multiple people and over time.


Reproducible research example
========================================================

A typical project/paper directory for me:
```
1-download.R
2-process_data.R
3-analyze_data.R
4-make_graphs.R
logfiles/
processed_data/
rawdata/
outputs/
```

For me almost any project starts from my [default script](https://github.com/bpbond/R_analysis_script).


Reproducible research example
========================================================

<img src="images/repository.png" />

From [this paper of mine](http://iopscience.iop.org/article/10.1088/1748-9326/11/8/084004/meta).

Hands-on: setting up R and RStudio
========================================================
type: prompt
incremental: false

If you're doing the exercises and problems, you'll need these
packages:
- `dplyr` - fast, flexible tool for working with data frames
- `tidyr` - reshaping and cleaning data
- `ggplot2` - popular package for visualizing data

We'll also use this data package:
- `babynames` - names provided to the SSA 1880-2013

Finally, we'll download a [repository](https://github.com/bpbond/R-data-picarro) (collection of code and data) for this workshop.

Let's do that now.


R basics
========================================================
type: section


Things you should know: basics
========================================================

This workshop assumes you understand a few basics of R:

- What R is
- How to start and quit it
- How to get help


```r
# This is a comment
# Get help for the `summary` function
?summary

# Get help for an entire package
help(package = 'ggplot2')
```


Things you should know: vectors
========================================================

- The *vector* data type


```r
myvector <- 1:5
myvector <- c(1, 2, 3, 4, 5)
myvector <- seq(1, 5)
myvector
```

```
[1] 1 2 3 4 5
```

```r
myvector[2:3]
```

```
[1] 2 3
```

***


```r
sum(myvector)
```

```
[1] 15
```

*Vectorised operations* operate on a vector all at once:


```r
myvector * 2
```

```
[1]  2  4  6  8 10
```


Things you should know: scripts
========================================================

The difference between a *script* (stored program) and *command line* (immediate response).

In general, you want to use scripts, which provide *reproducibility*.



```r
source("myscript.R")
```

***

<img src="images/mayan_script.gif" />


Things you should know: packages
========================================================

- *Packages* are pieces of software that can be loaded into R. There are thousands, for all kinds of tasks and needs.


```r
# The single most popular R package is `ggplot2`
library(ggplot2)

# qplot:
# a "quick plot" function in ggplot2
qplot(speed, 
      dist, 
      data = cars)
```

***

![plot of chunk unnamed-chunk-7](R-data-picarro-figure/unnamed-chunk-7-1.png)


Hands-on: examining the `iris` dataset
========================================================
type: prompt
incremental: false

Hands-on work in RStudio.
* Built-in datasets
* Using `summary`, `names`, `head`, `tail`
* Looking at particular rows and columns
* Subsetting the data
* Basic plots of the data


Computing on columns
========================================================

This can be simple...


```r
d <- data.frame(x = 1:3)
d$y <- d$x * 2
d$z <- cumsum(d$y) # cumulative sum
d$four <- ifelse(d$y == 4, "four", "not 4") 
d
```

```
  x y  z  four
1 1 2  2 not 4
2 2 4  6  four
3 3 6 12 not 4
```



Understanding and dealing with NA
========================================================

One of R's strengths is that missing values are a first-class data type: `NA`.


```r
x <- c(1, 2, 3, NA)
# Which are NA?
is.na(x)
```

```
[1] FALSE FALSE FALSE  TRUE
```

```r
any(is.na(x))
```

```
[1] TRUE
```

***


```r
which(is.na(x))
```

```
[1] 4
```

```r
x[!is.na(x)]
```

```
[1] 1 2 3
```


Understanding and dealing with NA
========================================================

Like `NaN` and `Inf`, generally `NA` 'poisons' operations, so NA values must be explicitly ignored and/or removed.


```r
x <- c(1, 2, 3, NA)
sum(x) # NA
```

```
[1] NA
```

```r
sum(x, na.rm = TRUE)
```

```
[1] 6
```


Dealing with dates
========================================================

R has a `Date` class representing calendar dates, and an `as.Date` function for converting to Dates. The `lubridate` package is often useful (and easier) for these cases:


```r
library(lubridate)
x <- c("09-01-01", "09-01-02") # character!
ymd(x)   # there's also dmy, ymd_hms, etc.
```

```
[1] "2009-01-01" "2009-01-02"
```

Once data are in `Date` format, the time interval between them can be computed simply by subtraction. See `?difftime`


Merging datasets
========================================================

Often, as we clean and reshape data, we want to merge different datasets together. The built-in `merge` command does this well.

Let's say we have a data frame containing information on how pretty each of the `iris` species is:


```
     Species pretty
1     setosa   ugly
2 versicolor     ok
3  virginica lovely
```


Merging datasets
========================================================

`merge` looks for names in common between two data frames, and uses these to merge.


```r
merge(iris, howpretty)
```


```
  Species Sepal.Length pretty
1  setosa          5.1   ugly
2  setosa          4.9   ugly
3  setosa          4.7   ugly
4  setosa          4.6   ugly
5  setosa          5.0   ugly
6  setosa          5.4   ugly
```

(Viewing only a few columns and rows.) The `dplyr` package has more varied, faster database-style join operations.


Summarizing and manipulating data
========================================================
type: section


History lesson
========================================================

<img src="images/history.png" width="850" />


Operation pipelines in R
========================================================

`dplyr` and `tidyr` both *import* the [magrittr](https://github.com/smbache/magrittr) package, which introduces a **pipeline** operator `%>%` to R.

Not everyone is a fan of piping, and there are situations where it's not appropriate; but we'll use it frequently.


`magrittr` pipelines in R
========================================================

Standard R notation:


```r
x <- read_my_data(f)
y <- merge_data(clean_data(x), otherdata)
z <- summarize_data(y)
```

Pipeline notation:


```r
read_my_data(f) %>%
  clean_data %>%
  merge_data(otherdata) %>%
  summarize_data ->
  z
```


Reshaping datasets
========================================================

This is a **CRITICALLY** important skill, because often data aren't in the form you want. Let's look at the `head()` of the `iris` dataset:

```
  Sepal.Length Sepal.Width Petal.Length
1          5.1         3.5          1.4
2          4.9         3.0          1.4
3          4.7         3.2          1.3
4          4.6         3.1          1.5
5          5.0         3.6          1.4
6          5.4         3.9          1.7
```

Discuss: why is this not a great form for the data?

Reshaping datasets
========================================================

The `tidyr::gather` function 'gathers' the data, taking multiple columns and collapsing them into key-value pairs.


Reshaping datasets
========================================================

Remember the form of `iris`:


```
  Sepal.Length Sepal.Width Petal.Length
1          5.1         3.5          1.4
2          4.9         3.0          1.4
3          4.7         3.2          1.3
4          4.6         3.1          1.5
5          5.0         3.6          1.4
6          5.4         3.9          1.7
```


Reshaping datasets
========================================================

We call `gather`, telling it that we want to 'gather' everything *except* for `species`, and we want the resulting columns to be named `variable` and `value`:


```r
library(tidyr)
iris %>% 
  gather(variable, value, -Species)
```

```
       Species     variable value
1       setosa Sepal.Length   5.1
2       setosa Sepal.Length   4.9
3       setosa Sepal.Length   4.7
4       setosa Sepal.Length   4.6
5       setosa Sepal.Length   5.0
6       setosa Sepal.Length   5.4
7       setosa Sepal.Length   4.6
8       setosa Sepal.Length   5.0
9       setosa Sepal.Length   4.4
10      setosa Sepal.Length   4.9
11      setosa Sepal.Length   5.4
12      setosa Sepal.Length   4.8
13      setosa Sepal.Length   4.8
14      setosa Sepal.Length   4.3
15      setosa Sepal.Length   5.8
16      setosa Sepal.Length   5.7
17      setosa Sepal.Length   5.4
18      setosa Sepal.Length   5.1
19      setosa Sepal.Length   5.7
20      setosa Sepal.Length   5.1
21      setosa Sepal.Length   5.4
22      setosa Sepal.Length   5.1
23      setosa Sepal.Length   4.6
24      setosa Sepal.Length   5.1
25      setosa Sepal.Length   4.8
26      setosa Sepal.Length   5.0
27      setosa Sepal.Length   5.0
28      setosa Sepal.Length   5.2
29      setosa Sepal.Length   5.2
30      setosa Sepal.Length   4.7
31      setosa Sepal.Length   4.8
32      setosa Sepal.Length   5.4
33      setosa Sepal.Length   5.2
34      setosa Sepal.Length   5.5
35      setosa Sepal.Length   4.9
36      setosa Sepal.Length   5.0
37      setosa Sepal.Length   5.5
38      setosa Sepal.Length   4.9
39      setosa Sepal.Length   4.4
40      setosa Sepal.Length   5.1
41      setosa Sepal.Length   5.0
42      setosa Sepal.Length   4.5
43      setosa Sepal.Length   4.4
44      setosa Sepal.Length   5.0
45      setosa Sepal.Length   5.1
46      setosa Sepal.Length   4.8
47      setosa Sepal.Length   5.1
48      setosa Sepal.Length   4.6
49      setosa Sepal.Length   5.3
50      setosa Sepal.Length   5.0
51  versicolor Sepal.Length   7.0
52  versicolor Sepal.Length   6.4
53  versicolor Sepal.Length   6.9
54  versicolor Sepal.Length   5.5
55  versicolor Sepal.Length   6.5
56  versicolor Sepal.Length   5.7
57  versicolor Sepal.Length   6.3
58  versicolor Sepal.Length   4.9
59  versicolor Sepal.Length   6.6
60  versicolor Sepal.Length   5.2
61  versicolor Sepal.Length   5.0
62  versicolor Sepal.Length   5.9
63  versicolor Sepal.Length   6.0
64  versicolor Sepal.Length   6.1
65  versicolor Sepal.Length   5.6
66  versicolor Sepal.Length   6.7
67  versicolor Sepal.Length   5.6
68  versicolor Sepal.Length   5.8
69  versicolor Sepal.Length   6.2
70  versicolor Sepal.Length   5.6
71  versicolor Sepal.Length   5.9
72  versicolor Sepal.Length   6.1
73  versicolor Sepal.Length   6.3
74  versicolor Sepal.Length   6.1
75  versicolor Sepal.Length   6.4
76  versicolor Sepal.Length   6.6
77  versicolor Sepal.Length   6.8
78  versicolor Sepal.Length   6.7
79  versicolor Sepal.Length   6.0
80  versicolor Sepal.Length   5.7
81  versicolor Sepal.Length   5.5
82  versicolor Sepal.Length   5.5
83  versicolor Sepal.Length   5.8
84  versicolor Sepal.Length   6.0
85  versicolor Sepal.Length   5.4
86  versicolor Sepal.Length   6.0
87  versicolor Sepal.Length   6.7
88  versicolor Sepal.Length   6.3
89  versicolor Sepal.Length   5.6
90  versicolor Sepal.Length   5.5
91  versicolor Sepal.Length   5.5
92  versicolor Sepal.Length   6.1
93  versicolor Sepal.Length   5.8
94  versicolor Sepal.Length   5.0
95  versicolor Sepal.Length   5.6
96  versicolor Sepal.Length   5.7
97  versicolor Sepal.Length   5.7
98  versicolor Sepal.Length   6.2
99  versicolor Sepal.Length   5.1
100 versicolor Sepal.Length   5.7
101  virginica Sepal.Length   6.3
102  virginica Sepal.Length   5.8
103  virginica Sepal.Length   7.1
104  virginica Sepal.Length   6.3
105  virginica Sepal.Length   6.5
106  virginica Sepal.Length   7.6
107  virginica Sepal.Length   4.9
108  virginica Sepal.Length   7.3
109  virginica Sepal.Length   6.7
110  virginica Sepal.Length   7.2
111  virginica Sepal.Length   6.5
112  virginica Sepal.Length   6.4
113  virginica Sepal.Length   6.8
114  virginica Sepal.Length   5.7
115  virginica Sepal.Length   5.8
116  virginica Sepal.Length   6.4
117  virginica Sepal.Length   6.5
118  virginica Sepal.Length   7.7
119  virginica Sepal.Length   7.7
120  virginica Sepal.Length   6.0
121  virginica Sepal.Length   6.9
122  virginica Sepal.Length   5.6
123  virginica Sepal.Length   7.7
124  virginica Sepal.Length   6.3
125  virginica Sepal.Length   6.7
126  virginica Sepal.Length   7.2
127  virginica Sepal.Length   6.2
128  virginica Sepal.Length   6.1
129  virginica Sepal.Length   6.4
130  virginica Sepal.Length   7.2
131  virginica Sepal.Length   7.4
132  virginica Sepal.Length   7.9
133  virginica Sepal.Length   6.4
134  virginica Sepal.Length   6.3
135  virginica Sepal.Length   6.1
136  virginica Sepal.Length   7.7
137  virginica Sepal.Length   6.3
138  virginica Sepal.Length   6.4
139  virginica Sepal.Length   6.0
140  virginica Sepal.Length   6.9
141  virginica Sepal.Length   6.7
142  virginica Sepal.Length   6.9
143  virginica Sepal.Length   5.8
144  virginica Sepal.Length   6.8
145  virginica Sepal.Length   6.7
146  virginica Sepal.Length   6.7
147  virginica Sepal.Length   6.3
148  virginica Sepal.Length   6.5
149  virginica Sepal.Length   6.2
150  virginica Sepal.Length   5.9
151     setosa  Sepal.Width   3.5
152     setosa  Sepal.Width   3.0
153     setosa  Sepal.Width   3.2
154     setosa  Sepal.Width   3.1
155     setosa  Sepal.Width   3.6
156     setosa  Sepal.Width   3.9
157     setosa  Sepal.Width   3.4
158     setosa  Sepal.Width   3.4
159     setosa  Sepal.Width   2.9
160     setosa  Sepal.Width   3.1
161     setosa  Sepal.Width   3.7
162     setosa  Sepal.Width   3.4
163     setosa  Sepal.Width   3.0
164     setosa  Sepal.Width   3.0
165     setosa  Sepal.Width   4.0
166     setosa  Sepal.Width   4.4
167     setosa  Sepal.Width   3.9
168     setosa  Sepal.Width   3.5
169     setosa  Sepal.Width   3.8
170     setosa  Sepal.Width   3.8
171     setosa  Sepal.Width   3.4
172     setosa  Sepal.Width   3.7
173     setosa  Sepal.Width   3.6
174     setosa  Sepal.Width   3.3
175     setosa  Sepal.Width   3.4
176     setosa  Sepal.Width   3.0
177     setosa  Sepal.Width   3.4
178     setosa  Sepal.Width   3.5
179     setosa  Sepal.Width   3.4
180     setosa  Sepal.Width   3.2
181     setosa  Sepal.Width   3.1
182     setosa  Sepal.Width   3.4
183     setosa  Sepal.Width   4.1
184     setosa  Sepal.Width   4.2
185     setosa  Sepal.Width   3.1
186     setosa  Sepal.Width   3.2
187     setosa  Sepal.Width   3.5
188     setosa  Sepal.Width   3.6
189     setosa  Sepal.Width   3.0
190     setosa  Sepal.Width   3.4
191     setosa  Sepal.Width   3.5
192     setosa  Sepal.Width   2.3
193     setosa  Sepal.Width   3.2
194     setosa  Sepal.Width   3.5
195     setosa  Sepal.Width   3.8
196     setosa  Sepal.Width   3.0
197     setosa  Sepal.Width   3.8
198     setosa  Sepal.Width   3.2
199     setosa  Sepal.Width   3.7
200     setosa  Sepal.Width   3.3
201 versicolor  Sepal.Width   3.2
202 versicolor  Sepal.Width   3.2
203 versicolor  Sepal.Width   3.1
204 versicolor  Sepal.Width   2.3
205 versicolor  Sepal.Width   2.8
206 versicolor  Sepal.Width   2.8
207 versicolor  Sepal.Width   3.3
208 versicolor  Sepal.Width   2.4
209 versicolor  Sepal.Width   2.9
210 versicolor  Sepal.Width   2.7
211 versicolor  Sepal.Width   2.0
212 versicolor  Sepal.Width   3.0
213 versicolor  Sepal.Width   2.2
214 versicolor  Sepal.Width   2.9
215 versicolor  Sepal.Width   2.9
216 versicolor  Sepal.Width   3.1
217 versicolor  Sepal.Width   3.0
218 versicolor  Sepal.Width   2.7
219 versicolor  Sepal.Width   2.2
220 versicolor  Sepal.Width   2.5
221 versicolor  Sepal.Width   3.2
222 versicolor  Sepal.Width   2.8
223 versicolor  Sepal.Width   2.5
224 versicolor  Sepal.Width   2.8
225 versicolor  Sepal.Width   2.9
226 versicolor  Sepal.Width   3.0
227 versicolor  Sepal.Width   2.8
228 versicolor  Sepal.Width   3.0
229 versicolor  Sepal.Width   2.9
230 versicolor  Sepal.Width   2.6
231 versicolor  Sepal.Width   2.4
232 versicolor  Sepal.Width   2.4
233 versicolor  Sepal.Width   2.7
234 versicolor  Sepal.Width   2.7
235 versicolor  Sepal.Width   3.0
236 versicolor  Sepal.Width   3.4
237 versicolor  Sepal.Width   3.1
238 versicolor  Sepal.Width   2.3
239 versicolor  Sepal.Width   3.0
240 versicolor  Sepal.Width   2.5
241 versicolor  Sepal.Width   2.6
242 versicolor  Sepal.Width   3.0
243 versicolor  Sepal.Width   2.6
244 versicolor  Sepal.Width   2.3
245 versicolor  Sepal.Width   2.7
246 versicolor  Sepal.Width   3.0
247 versicolor  Sepal.Width   2.9
248 versicolor  Sepal.Width   2.9
249 versicolor  Sepal.Width   2.5
250 versicolor  Sepal.Width   2.8
251  virginica  Sepal.Width   3.3
252  virginica  Sepal.Width   2.7
253  virginica  Sepal.Width   3.0
254  virginica  Sepal.Width   2.9
255  virginica  Sepal.Width   3.0
256  virginica  Sepal.Width   3.0
257  virginica  Sepal.Width   2.5
258  virginica  Sepal.Width   2.9
259  virginica  Sepal.Width   2.5
260  virginica  Sepal.Width   3.6
261  virginica  Sepal.Width   3.2
262  virginica  Sepal.Width   2.7
263  virginica  Sepal.Width   3.0
264  virginica  Sepal.Width   2.5
265  virginica  Sepal.Width   2.8
266  virginica  Sepal.Width   3.2
267  virginica  Sepal.Width   3.0
268  virginica  Sepal.Width   3.8
269  virginica  Sepal.Width   2.6
270  virginica  Sepal.Width   2.2
271  virginica  Sepal.Width   3.2
272  virginica  Sepal.Width   2.8
273  virginica  Sepal.Width   2.8
274  virginica  Sepal.Width   2.7
275  virginica  Sepal.Width   3.3
276  virginica  Sepal.Width   3.2
277  virginica  Sepal.Width   2.8
278  virginica  Sepal.Width   3.0
279  virginica  Sepal.Width   2.8
280  virginica  Sepal.Width   3.0
281  virginica  Sepal.Width   2.8
282  virginica  Sepal.Width   3.8
283  virginica  Sepal.Width   2.8
284  virginica  Sepal.Width   2.8
285  virginica  Sepal.Width   2.6
286  virginica  Sepal.Width   3.0
287  virginica  Sepal.Width   3.4
288  virginica  Sepal.Width   3.1
289  virginica  Sepal.Width   3.0
290  virginica  Sepal.Width   3.1
291  virginica  Sepal.Width   3.1
292  virginica  Sepal.Width   3.1
293  virginica  Sepal.Width   2.7
294  virginica  Sepal.Width   3.2
295  virginica  Sepal.Width   3.3
296  virginica  Sepal.Width   3.0
297  virginica  Sepal.Width   2.5
298  virginica  Sepal.Width   3.0
299  virginica  Sepal.Width   3.4
300  virginica  Sepal.Width   3.0
301     setosa Petal.Length   1.4
302     setosa Petal.Length   1.4
303     setosa Petal.Length   1.3
304     setosa Petal.Length   1.5
305     setosa Petal.Length   1.4
306     setosa Petal.Length   1.7
307     setosa Petal.Length   1.4
308     setosa Petal.Length   1.5
309     setosa Petal.Length   1.4
310     setosa Petal.Length   1.5
311     setosa Petal.Length   1.5
312     setosa Petal.Length   1.6
313     setosa Petal.Length   1.4
314     setosa Petal.Length   1.1
315     setosa Petal.Length   1.2
316     setosa Petal.Length   1.5
317     setosa Petal.Length   1.3
318     setosa Petal.Length   1.4
319     setosa Petal.Length   1.7
320     setosa Petal.Length   1.5
321     setosa Petal.Length   1.7
322     setosa Petal.Length   1.5
323     setosa Petal.Length   1.0
324     setosa Petal.Length   1.7
325     setosa Petal.Length   1.9
326     setosa Petal.Length   1.6
327     setosa Petal.Length   1.6
328     setosa Petal.Length   1.5
329     setosa Petal.Length   1.4
330     setosa Petal.Length   1.6
331     setosa Petal.Length   1.6
332     setosa Petal.Length   1.5
333     setosa Petal.Length   1.5
334     setosa Petal.Length   1.4
335     setosa Petal.Length   1.5
336     setosa Petal.Length   1.2
337     setosa Petal.Length   1.3
338     setosa Petal.Length   1.4
339     setosa Petal.Length   1.3
340     setosa Petal.Length   1.5
341     setosa Petal.Length   1.3
342     setosa Petal.Length   1.3
343     setosa Petal.Length   1.3
344     setosa Petal.Length   1.6
345     setosa Petal.Length   1.9
346     setosa Petal.Length   1.4
347     setosa Petal.Length   1.6
348     setosa Petal.Length   1.4
349     setosa Petal.Length   1.5
350     setosa Petal.Length   1.4
351 versicolor Petal.Length   4.7
352 versicolor Petal.Length   4.5
353 versicolor Petal.Length   4.9
354 versicolor Petal.Length   4.0
355 versicolor Petal.Length   4.6
356 versicolor Petal.Length   4.5
357 versicolor Petal.Length   4.7
358 versicolor Petal.Length   3.3
359 versicolor Petal.Length   4.6
360 versicolor Petal.Length   3.9
361 versicolor Petal.Length   3.5
362 versicolor Petal.Length   4.2
363 versicolor Petal.Length   4.0
364 versicolor Petal.Length   4.7
365 versicolor Petal.Length   3.6
366 versicolor Petal.Length   4.4
367 versicolor Petal.Length   4.5
368 versicolor Petal.Length   4.1
369 versicolor Petal.Length   4.5
370 versicolor Petal.Length   3.9
371 versicolor Petal.Length   4.8
372 versicolor Petal.Length   4.0
373 versicolor Petal.Length   4.9
374 versicolor Petal.Length   4.7
375 versicolor Petal.Length   4.3
376 versicolor Petal.Length   4.4
377 versicolor Petal.Length   4.8
378 versicolor Petal.Length   5.0
379 versicolor Petal.Length   4.5
380 versicolor Petal.Length   3.5
381 versicolor Petal.Length   3.8
382 versicolor Petal.Length   3.7
383 versicolor Petal.Length   3.9
384 versicolor Petal.Length   5.1
385 versicolor Petal.Length   4.5
386 versicolor Petal.Length   4.5
387 versicolor Petal.Length   4.7
388 versicolor Petal.Length   4.4
389 versicolor Petal.Length   4.1
390 versicolor Petal.Length   4.0
391 versicolor Petal.Length   4.4
392 versicolor Petal.Length   4.6
393 versicolor Petal.Length   4.0
394 versicolor Petal.Length   3.3
395 versicolor Petal.Length   4.2
396 versicolor Petal.Length   4.2
397 versicolor Petal.Length   4.2
398 versicolor Petal.Length   4.3
399 versicolor Petal.Length   3.0
400 versicolor Petal.Length   4.1
401  virginica Petal.Length   6.0
402  virginica Petal.Length   5.1
403  virginica Petal.Length   5.9
404  virginica Petal.Length   5.6
405  virginica Petal.Length   5.8
406  virginica Petal.Length   6.6
407  virginica Petal.Length   4.5
408  virginica Petal.Length   6.3
409  virginica Petal.Length   5.8
410  virginica Petal.Length   6.1
411  virginica Petal.Length   5.1
412  virginica Petal.Length   5.3
413  virginica Petal.Length   5.5
414  virginica Petal.Length   5.0
415  virginica Petal.Length   5.1
416  virginica Petal.Length   5.3
417  virginica Petal.Length   5.5
418  virginica Petal.Length   6.7
419  virginica Petal.Length   6.9
420  virginica Petal.Length   5.0
421  virginica Petal.Length   5.7
422  virginica Petal.Length   4.9
423  virginica Petal.Length   6.7
424  virginica Petal.Length   4.9
425  virginica Petal.Length   5.7
426  virginica Petal.Length   6.0
427  virginica Petal.Length   4.8
428  virginica Petal.Length   4.9
429  virginica Petal.Length   5.6
430  virginica Petal.Length   5.8
431  virginica Petal.Length   6.1
432  virginica Petal.Length   6.4
433  virginica Petal.Length   5.6
434  virginica Petal.Length   5.1
435  virginica Petal.Length   5.6
436  virginica Petal.Length   6.1
437  virginica Petal.Length   5.6
438  virginica Petal.Length   5.5
439  virginica Petal.Length   4.8
440  virginica Petal.Length   5.4
441  virginica Petal.Length   5.6
442  virginica Petal.Length   5.1
443  virginica Petal.Length   5.1
444  virginica Petal.Length   5.9
445  virginica Petal.Length   5.7
446  virginica Petal.Length   5.2
447  virginica Petal.Length   5.0
448  virginica Petal.Length   5.2
449  virginica Petal.Length   5.4
450  virginica Petal.Length   5.1
451     setosa  Petal.Width   0.2
452     setosa  Petal.Width   0.2
453     setosa  Petal.Width   0.2
454     setosa  Petal.Width   0.2
455     setosa  Petal.Width   0.2
456     setosa  Petal.Width   0.4
457     setosa  Petal.Width   0.3
458     setosa  Petal.Width   0.2
459     setosa  Petal.Width   0.2
460     setosa  Petal.Width   0.1
461     setosa  Petal.Width   0.2
462     setosa  Petal.Width   0.2
463     setosa  Petal.Width   0.1
464     setosa  Petal.Width   0.1
465     setosa  Petal.Width   0.2
466     setosa  Petal.Width   0.4
467     setosa  Petal.Width   0.4
468     setosa  Petal.Width   0.3
469     setosa  Petal.Width   0.3
470     setosa  Petal.Width   0.3
471     setosa  Petal.Width   0.2
472     setosa  Petal.Width   0.4
473     setosa  Petal.Width   0.2
474     setosa  Petal.Width   0.5
475     setosa  Petal.Width   0.2
476     setosa  Petal.Width   0.2
477     setosa  Petal.Width   0.4
478     setosa  Petal.Width   0.2
479     setosa  Petal.Width   0.2
480     setosa  Petal.Width   0.2
481     setosa  Petal.Width   0.2
482     setosa  Petal.Width   0.4
483     setosa  Petal.Width   0.1
484     setosa  Petal.Width   0.2
485     setosa  Petal.Width   0.2
486     setosa  Petal.Width   0.2
487     setosa  Petal.Width   0.2
488     setosa  Petal.Width   0.1
489     setosa  Petal.Width   0.2
490     setosa  Petal.Width   0.2
491     setosa  Petal.Width   0.3
492     setosa  Petal.Width   0.3
493     setosa  Petal.Width   0.2
494     setosa  Petal.Width   0.6
495     setosa  Petal.Width   0.4
496     setosa  Petal.Width   0.3
497     setosa  Petal.Width   0.2
498     setosa  Petal.Width   0.2
499     setosa  Petal.Width   0.2
500     setosa  Petal.Width   0.2
501 versicolor  Petal.Width   1.4
502 versicolor  Petal.Width   1.5
503 versicolor  Petal.Width   1.5
504 versicolor  Petal.Width   1.3
505 versicolor  Petal.Width   1.5
506 versicolor  Petal.Width   1.3
507 versicolor  Petal.Width   1.6
508 versicolor  Petal.Width   1.0
509 versicolor  Petal.Width   1.3
510 versicolor  Petal.Width   1.4
511 versicolor  Petal.Width   1.0
512 versicolor  Petal.Width   1.5
513 versicolor  Petal.Width   1.0
514 versicolor  Petal.Width   1.4
515 versicolor  Petal.Width   1.3
516 versicolor  Petal.Width   1.4
517 versicolor  Petal.Width   1.5
518 versicolor  Petal.Width   1.0
519 versicolor  Petal.Width   1.5
520 versicolor  Petal.Width   1.1
521 versicolor  Petal.Width   1.8
522 versicolor  Petal.Width   1.3
523 versicolor  Petal.Width   1.5
524 versicolor  Petal.Width   1.2
525 versicolor  Petal.Width   1.3
526 versicolor  Petal.Width   1.4
527 versicolor  Petal.Width   1.4
528 versicolor  Petal.Width   1.7
529 versicolor  Petal.Width   1.5
530 versicolor  Petal.Width   1.0
531 versicolor  Petal.Width   1.1
532 versicolor  Petal.Width   1.0
533 versicolor  Petal.Width   1.2
534 versicolor  Petal.Width   1.6
535 versicolor  Petal.Width   1.5
536 versicolor  Petal.Width   1.6
537 versicolor  Petal.Width   1.5
538 versicolor  Petal.Width   1.3
539 versicolor  Petal.Width   1.3
540 versicolor  Petal.Width   1.3
541 versicolor  Petal.Width   1.2
542 versicolor  Petal.Width   1.4
543 versicolor  Petal.Width   1.2
544 versicolor  Petal.Width   1.0
545 versicolor  Petal.Width   1.3
546 versicolor  Petal.Width   1.2
547 versicolor  Petal.Width   1.3
548 versicolor  Petal.Width   1.3
549 versicolor  Petal.Width   1.1
550 versicolor  Petal.Width   1.3
551  virginica  Petal.Width   2.5
552  virginica  Petal.Width   1.9
553  virginica  Petal.Width   2.1
554  virginica  Petal.Width   1.8
555  virginica  Petal.Width   2.2
556  virginica  Petal.Width   2.1
557  virginica  Petal.Width   1.7
558  virginica  Petal.Width   1.8
559  virginica  Petal.Width   1.8
560  virginica  Petal.Width   2.5
561  virginica  Petal.Width   2.0
562  virginica  Petal.Width   1.9
563  virginica  Petal.Width   2.1
564  virginica  Petal.Width   2.0
565  virginica  Petal.Width   2.4
566  virginica  Petal.Width   2.3
567  virginica  Petal.Width   1.8
568  virginica  Petal.Width   2.2
569  virginica  Petal.Width   2.3
570  virginica  Petal.Width   1.5
571  virginica  Petal.Width   2.3
572  virginica  Petal.Width   2.0
573  virginica  Petal.Width   2.0
574  virginica  Petal.Width   1.8
575  virginica  Petal.Width   2.1
576  virginica  Petal.Width   1.8
577  virginica  Petal.Width   1.8
578  virginica  Petal.Width   1.8
579  virginica  Petal.Width   2.1
580  virginica  Petal.Width   1.6
581  virginica  Petal.Width   1.9
582  virginica  Petal.Width   2.0
583  virginica  Petal.Width   2.2
584  virginica  Petal.Width   1.5
585  virginica  Petal.Width   1.4
586  virginica  Petal.Width   2.3
587  virginica  Petal.Width   2.4
588  virginica  Petal.Width   1.8
589  virginica  Petal.Width   1.8
590  virginica  Petal.Width   2.1
591  virginica  Petal.Width   2.4
592  virginica  Petal.Width   2.3
593  virginica  Petal.Width   1.9
594  virginica  Petal.Width   2.3
595  virginica  Petal.Width   2.5
596  virginica  Petal.Width   2.3
597  virginica  Petal.Width   1.9
598  virginica  Petal.Width   2.0
599  virginica  Petal.Width   2.3
600  virginica  Petal.Width   1.8
```


Reshaping datasets
========================================================

We call `gather`, telling it that we want to 'gather' everything *except* for `species`, and we want the resulting columns to be named `variable` and `value`:


```
  Species     variable value
1  setosa Sepal.Length   5.1
2  setosa Sepal.Length   4.9
3  setosa Sepal.Length   4.7
4  setosa Sepal.Length   4.6
5  setosa Sepal.Length   5.0
6  setosa Sepal.Length   5.4
```

What's the problem here, though?


Reshaping datasets
========================================================


```r
iris %>% 
  gather(variable, value, -Species) %>% 
  separate(variable, 
           into = c("part", "dimension"))
```

```
       Species  part dimension value
1       setosa Sepal    Length   5.1
2       setosa Sepal    Length   4.9
3       setosa Sepal    Length   4.7
4       setosa Sepal    Length   4.6
5       setosa Sepal    Length   5.0
6       setosa Sepal    Length   5.4
7       setosa Sepal    Length   4.6
8       setosa Sepal    Length   5.0
9       setosa Sepal    Length   4.4
10      setosa Sepal    Length   4.9
11      setosa Sepal    Length   5.4
12      setosa Sepal    Length   4.8
13      setosa Sepal    Length   4.8
14      setosa Sepal    Length   4.3
15      setosa Sepal    Length   5.8
16      setosa Sepal    Length   5.7
17      setosa Sepal    Length   5.4
18      setosa Sepal    Length   5.1
19      setosa Sepal    Length   5.7
20      setosa Sepal    Length   5.1
21      setosa Sepal    Length   5.4
22      setosa Sepal    Length   5.1
23      setosa Sepal    Length   4.6
24      setosa Sepal    Length   5.1
25      setosa Sepal    Length   4.8
26      setosa Sepal    Length   5.0
27      setosa Sepal    Length   5.0
28      setosa Sepal    Length   5.2
29      setosa Sepal    Length   5.2
30      setosa Sepal    Length   4.7
31      setosa Sepal    Length   4.8
32      setosa Sepal    Length   5.4
33      setosa Sepal    Length   5.2
34      setosa Sepal    Length   5.5
35      setosa Sepal    Length   4.9
36      setosa Sepal    Length   5.0
37      setosa Sepal    Length   5.5
38      setosa Sepal    Length   4.9
39      setosa Sepal    Length   4.4
40      setosa Sepal    Length   5.1
41      setosa Sepal    Length   5.0
42      setosa Sepal    Length   4.5
43      setosa Sepal    Length   4.4
44      setosa Sepal    Length   5.0
45      setosa Sepal    Length   5.1
46      setosa Sepal    Length   4.8
47      setosa Sepal    Length   5.1
48      setosa Sepal    Length   4.6
49      setosa Sepal    Length   5.3
50      setosa Sepal    Length   5.0
51  versicolor Sepal    Length   7.0
52  versicolor Sepal    Length   6.4
53  versicolor Sepal    Length   6.9
54  versicolor Sepal    Length   5.5
55  versicolor Sepal    Length   6.5
56  versicolor Sepal    Length   5.7
57  versicolor Sepal    Length   6.3
58  versicolor Sepal    Length   4.9
59  versicolor Sepal    Length   6.6
60  versicolor Sepal    Length   5.2
61  versicolor Sepal    Length   5.0
62  versicolor Sepal    Length   5.9
63  versicolor Sepal    Length   6.0
64  versicolor Sepal    Length   6.1
65  versicolor Sepal    Length   5.6
66  versicolor Sepal    Length   6.7
67  versicolor Sepal    Length   5.6
68  versicolor Sepal    Length   5.8
69  versicolor Sepal    Length   6.2
70  versicolor Sepal    Length   5.6
71  versicolor Sepal    Length   5.9
72  versicolor Sepal    Length   6.1
73  versicolor Sepal    Length   6.3
74  versicolor Sepal    Length   6.1
75  versicolor Sepal    Length   6.4
76  versicolor Sepal    Length   6.6
77  versicolor Sepal    Length   6.8
78  versicolor Sepal    Length   6.7
79  versicolor Sepal    Length   6.0
80  versicolor Sepal    Length   5.7
81  versicolor Sepal    Length   5.5
82  versicolor Sepal    Length   5.5
83  versicolor Sepal    Length   5.8
84  versicolor Sepal    Length   6.0
85  versicolor Sepal    Length   5.4
86  versicolor Sepal    Length   6.0
87  versicolor Sepal    Length   6.7
88  versicolor Sepal    Length   6.3
89  versicolor Sepal    Length   5.6
90  versicolor Sepal    Length   5.5
91  versicolor Sepal    Length   5.5
92  versicolor Sepal    Length   6.1
93  versicolor Sepal    Length   5.8
94  versicolor Sepal    Length   5.0
95  versicolor Sepal    Length   5.6
96  versicolor Sepal    Length   5.7
97  versicolor Sepal    Length   5.7
98  versicolor Sepal    Length   6.2
99  versicolor Sepal    Length   5.1
100 versicolor Sepal    Length   5.7
101  virginica Sepal    Length   6.3
102  virginica Sepal    Length   5.8
103  virginica Sepal    Length   7.1
104  virginica Sepal    Length   6.3
105  virginica Sepal    Length   6.5
106  virginica Sepal    Length   7.6
107  virginica Sepal    Length   4.9
108  virginica Sepal    Length   7.3
109  virginica Sepal    Length   6.7
110  virginica Sepal    Length   7.2
111  virginica Sepal    Length   6.5
112  virginica Sepal    Length   6.4
113  virginica Sepal    Length   6.8
114  virginica Sepal    Length   5.7
115  virginica Sepal    Length   5.8
116  virginica Sepal    Length   6.4
117  virginica Sepal    Length   6.5
118  virginica Sepal    Length   7.7
119  virginica Sepal    Length   7.7
120  virginica Sepal    Length   6.0
121  virginica Sepal    Length   6.9
122  virginica Sepal    Length   5.6
123  virginica Sepal    Length   7.7
124  virginica Sepal    Length   6.3
125  virginica Sepal    Length   6.7
126  virginica Sepal    Length   7.2
127  virginica Sepal    Length   6.2
128  virginica Sepal    Length   6.1
129  virginica Sepal    Length   6.4
130  virginica Sepal    Length   7.2
131  virginica Sepal    Length   7.4
132  virginica Sepal    Length   7.9
133  virginica Sepal    Length   6.4
134  virginica Sepal    Length   6.3
135  virginica Sepal    Length   6.1
136  virginica Sepal    Length   7.7
137  virginica Sepal    Length   6.3
138  virginica Sepal    Length   6.4
139  virginica Sepal    Length   6.0
140  virginica Sepal    Length   6.9
141  virginica Sepal    Length   6.7
142  virginica Sepal    Length   6.9
143  virginica Sepal    Length   5.8
144  virginica Sepal    Length   6.8
145  virginica Sepal    Length   6.7
146  virginica Sepal    Length   6.7
147  virginica Sepal    Length   6.3
148  virginica Sepal    Length   6.5
149  virginica Sepal    Length   6.2
150  virginica Sepal    Length   5.9
151     setosa Sepal     Width   3.5
152     setosa Sepal     Width   3.0
153     setosa Sepal     Width   3.2
154     setosa Sepal     Width   3.1
155     setosa Sepal     Width   3.6
156     setosa Sepal     Width   3.9
157     setosa Sepal     Width   3.4
158     setosa Sepal     Width   3.4
159     setosa Sepal     Width   2.9
160     setosa Sepal     Width   3.1
161     setosa Sepal     Width   3.7
162     setosa Sepal     Width   3.4
163     setosa Sepal     Width   3.0
164     setosa Sepal     Width   3.0
165     setosa Sepal     Width   4.0
166     setosa Sepal     Width   4.4
167     setosa Sepal     Width   3.9
168     setosa Sepal     Width   3.5
169     setosa Sepal     Width   3.8
170     setosa Sepal     Width   3.8
171     setosa Sepal     Width   3.4
172     setosa Sepal     Width   3.7
173     setosa Sepal     Width   3.6
174     setosa Sepal     Width   3.3
175     setosa Sepal     Width   3.4
176     setosa Sepal     Width   3.0
177     setosa Sepal     Width   3.4
178     setosa Sepal     Width   3.5
179     setosa Sepal     Width   3.4
180     setosa Sepal     Width   3.2
181     setosa Sepal     Width   3.1
182     setosa Sepal     Width   3.4
183     setosa Sepal     Width   4.1
184     setosa Sepal     Width   4.2
185     setosa Sepal     Width   3.1
186     setosa Sepal     Width   3.2
187     setosa Sepal     Width   3.5
188     setosa Sepal     Width   3.6
189     setosa Sepal     Width   3.0
190     setosa Sepal     Width   3.4
191     setosa Sepal     Width   3.5
192     setosa Sepal     Width   2.3
193     setosa Sepal     Width   3.2
194     setosa Sepal     Width   3.5
195     setosa Sepal     Width   3.8
196     setosa Sepal     Width   3.0
197     setosa Sepal     Width   3.8
198     setosa Sepal     Width   3.2
199     setosa Sepal     Width   3.7
200     setosa Sepal     Width   3.3
201 versicolor Sepal     Width   3.2
202 versicolor Sepal     Width   3.2
203 versicolor Sepal     Width   3.1
204 versicolor Sepal     Width   2.3
205 versicolor Sepal     Width   2.8
206 versicolor Sepal     Width   2.8
207 versicolor Sepal     Width   3.3
208 versicolor Sepal     Width   2.4
209 versicolor Sepal     Width   2.9
210 versicolor Sepal     Width   2.7
211 versicolor Sepal     Width   2.0
212 versicolor Sepal     Width   3.0
213 versicolor Sepal     Width   2.2
214 versicolor Sepal     Width   2.9
215 versicolor Sepal     Width   2.9
216 versicolor Sepal     Width   3.1
217 versicolor Sepal     Width   3.0
218 versicolor Sepal     Width   2.7
219 versicolor Sepal     Width   2.2
220 versicolor Sepal     Width   2.5
221 versicolor Sepal     Width   3.2
222 versicolor Sepal     Width   2.8
223 versicolor Sepal     Width   2.5
224 versicolor Sepal     Width   2.8
225 versicolor Sepal     Width   2.9
226 versicolor Sepal     Width   3.0
227 versicolor Sepal     Width   2.8
228 versicolor Sepal     Width   3.0
229 versicolor Sepal     Width   2.9
230 versicolor Sepal     Width   2.6
231 versicolor Sepal     Width   2.4
232 versicolor Sepal     Width   2.4
233 versicolor Sepal     Width   2.7
234 versicolor Sepal     Width   2.7
235 versicolor Sepal     Width   3.0
236 versicolor Sepal     Width   3.4
237 versicolor Sepal     Width   3.1
238 versicolor Sepal     Width   2.3
239 versicolor Sepal     Width   3.0
240 versicolor Sepal     Width   2.5
241 versicolor Sepal     Width   2.6
242 versicolor Sepal     Width   3.0
243 versicolor Sepal     Width   2.6
244 versicolor Sepal     Width   2.3
245 versicolor Sepal     Width   2.7
246 versicolor Sepal     Width   3.0
247 versicolor Sepal     Width   2.9
248 versicolor Sepal     Width   2.9
249 versicolor Sepal     Width   2.5
250 versicolor Sepal     Width   2.8
251  virginica Sepal     Width   3.3
252  virginica Sepal     Width   2.7
253  virginica Sepal     Width   3.0
254  virginica Sepal     Width   2.9
255  virginica Sepal     Width   3.0
256  virginica Sepal     Width   3.0
257  virginica Sepal     Width   2.5
258  virginica Sepal     Width   2.9
259  virginica Sepal     Width   2.5
260  virginica Sepal     Width   3.6
261  virginica Sepal     Width   3.2
262  virginica Sepal     Width   2.7
263  virginica Sepal     Width   3.0
264  virginica Sepal     Width   2.5
265  virginica Sepal     Width   2.8
266  virginica Sepal     Width   3.2
267  virginica Sepal     Width   3.0
268  virginica Sepal     Width   3.8
269  virginica Sepal     Width   2.6
270  virginica Sepal     Width   2.2
271  virginica Sepal     Width   3.2
272  virginica Sepal     Width   2.8
273  virginica Sepal     Width   2.8
274  virginica Sepal     Width   2.7
275  virginica Sepal     Width   3.3
276  virginica Sepal     Width   3.2
277  virginica Sepal     Width   2.8
278  virginica Sepal     Width   3.0
279  virginica Sepal     Width   2.8
280  virginica Sepal     Width   3.0
281  virginica Sepal     Width   2.8
282  virginica Sepal     Width   3.8
283  virginica Sepal     Width   2.8
284  virginica Sepal     Width   2.8
285  virginica Sepal     Width   2.6
286  virginica Sepal     Width   3.0
287  virginica Sepal     Width   3.4
288  virginica Sepal     Width   3.1
289  virginica Sepal     Width   3.0
290  virginica Sepal     Width   3.1
291  virginica Sepal     Width   3.1
292  virginica Sepal     Width   3.1
293  virginica Sepal     Width   2.7
294  virginica Sepal     Width   3.2
295  virginica Sepal     Width   3.3
296  virginica Sepal     Width   3.0
297  virginica Sepal     Width   2.5
298  virginica Sepal     Width   3.0
299  virginica Sepal     Width   3.4
300  virginica Sepal     Width   3.0
301     setosa Petal    Length   1.4
302     setosa Petal    Length   1.4
303     setosa Petal    Length   1.3
304     setosa Petal    Length   1.5
305     setosa Petal    Length   1.4
306     setosa Petal    Length   1.7
307     setosa Petal    Length   1.4
308     setosa Petal    Length   1.5
309     setosa Petal    Length   1.4
310     setosa Petal    Length   1.5
311     setosa Petal    Length   1.5
312     setosa Petal    Length   1.6
313     setosa Petal    Length   1.4
314     setosa Petal    Length   1.1
315     setosa Petal    Length   1.2
316     setosa Petal    Length   1.5
317     setosa Petal    Length   1.3
318     setosa Petal    Length   1.4
319     setosa Petal    Length   1.7
320     setosa Petal    Length   1.5
321     setosa Petal    Length   1.7
322     setosa Petal    Length   1.5
323     setosa Petal    Length   1.0
324     setosa Petal    Length   1.7
325     setosa Petal    Length   1.9
326     setosa Petal    Length   1.6
327     setosa Petal    Length   1.6
328     setosa Petal    Length   1.5
329     setosa Petal    Length   1.4
330     setosa Petal    Length   1.6
331     setosa Petal    Length   1.6
332     setosa Petal    Length   1.5
333     setosa Petal    Length   1.5
334     setosa Petal    Length   1.4
335     setosa Petal    Length   1.5
336     setosa Petal    Length   1.2
337     setosa Petal    Length   1.3
338     setosa Petal    Length   1.4
339     setosa Petal    Length   1.3
340     setosa Petal    Length   1.5
341     setosa Petal    Length   1.3
342     setosa Petal    Length   1.3
343     setosa Petal    Length   1.3
344     setosa Petal    Length   1.6
345     setosa Petal    Length   1.9
346     setosa Petal    Length   1.4
347     setosa Petal    Length   1.6
348     setosa Petal    Length   1.4
349     setosa Petal    Length   1.5
350     setosa Petal    Length   1.4
351 versicolor Petal    Length   4.7
352 versicolor Petal    Length   4.5
353 versicolor Petal    Length   4.9
354 versicolor Petal    Length   4.0
355 versicolor Petal    Length   4.6
356 versicolor Petal    Length   4.5
357 versicolor Petal    Length   4.7
358 versicolor Petal    Length   3.3
359 versicolor Petal    Length   4.6
360 versicolor Petal    Length   3.9
361 versicolor Petal    Length   3.5
362 versicolor Petal    Length   4.2
363 versicolor Petal    Length   4.0
364 versicolor Petal    Length   4.7
365 versicolor Petal    Length   3.6
366 versicolor Petal    Length   4.4
367 versicolor Petal    Length   4.5
368 versicolor Petal    Length   4.1
369 versicolor Petal    Length   4.5
370 versicolor Petal    Length   3.9
371 versicolor Petal    Length   4.8
372 versicolor Petal    Length   4.0
373 versicolor Petal    Length   4.9
374 versicolor Petal    Length   4.7
375 versicolor Petal    Length   4.3
376 versicolor Petal    Length   4.4
377 versicolor Petal    Length   4.8
378 versicolor Petal    Length   5.0
379 versicolor Petal    Length   4.5
380 versicolor Petal    Length   3.5
381 versicolor Petal    Length   3.8
382 versicolor Petal    Length   3.7
383 versicolor Petal    Length   3.9
384 versicolor Petal    Length   5.1
385 versicolor Petal    Length   4.5
386 versicolor Petal    Length   4.5
387 versicolor Petal    Length   4.7
388 versicolor Petal    Length   4.4
389 versicolor Petal    Length   4.1
390 versicolor Petal    Length   4.0
391 versicolor Petal    Length   4.4
392 versicolor Petal    Length   4.6
393 versicolor Petal    Length   4.0
394 versicolor Petal    Length   3.3
395 versicolor Petal    Length   4.2
396 versicolor Petal    Length   4.2
397 versicolor Petal    Length   4.2
398 versicolor Petal    Length   4.3
399 versicolor Petal    Length   3.0
400 versicolor Petal    Length   4.1
401  virginica Petal    Length   6.0
402  virginica Petal    Length   5.1
403  virginica Petal    Length   5.9
404  virginica Petal    Length   5.6
405  virginica Petal    Length   5.8
406  virginica Petal    Length   6.6
407  virginica Petal    Length   4.5
408  virginica Petal    Length   6.3
409  virginica Petal    Length   5.8
410  virginica Petal    Length   6.1
411  virginica Petal    Length   5.1
412  virginica Petal    Length   5.3
413  virginica Petal    Length   5.5
414  virginica Petal    Length   5.0
415  virginica Petal    Length   5.1
416  virginica Petal    Length   5.3
417  virginica Petal    Length   5.5
418  virginica Petal    Length   6.7
419  virginica Petal    Length   6.9
420  virginica Petal    Length   5.0
421  virginica Petal    Length   5.7
422  virginica Petal    Length   4.9
423  virginica Petal    Length   6.7
424  virginica Petal    Length   4.9
425  virginica Petal    Length   5.7
426  virginica Petal    Length   6.0
427  virginica Petal    Length   4.8
428  virginica Petal    Length   4.9
429  virginica Petal    Length   5.6
430  virginica Petal    Length   5.8
431  virginica Petal    Length   6.1
432  virginica Petal    Length   6.4
433  virginica Petal    Length   5.6
434  virginica Petal    Length   5.1
435  virginica Petal    Length   5.6
436  virginica Petal    Length   6.1
437  virginica Petal    Length   5.6
438  virginica Petal    Length   5.5
439  virginica Petal    Length   4.8
440  virginica Petal    Length   5.4
441  virginica Petal    Length   5.6
442  virginica Petal    Length   5.1
443  virginica Petal    Length   5.1
444  virginica Petal    Length   5.9
445  virginica Petal    Length   5.7
446  virginica Petal    Length   5.2
447  virginica Petal    Length   5.0
448  virginica Petal    Length   5.2
449  virginica Petal    Length   5.4
450  virginica Petal    Length   5.1
451     setosa Petal     Width   0.2
452     setosa Petal     Width   0.2
453     setosa Petal     Width   0.2
454     setosa Petal     Width   0.2
455     setosa Petal     Width   0.2
456     setosa Petal     Width   0.4
457     setosa Petal     Width   0.3
458     setosa Petal     Width   0.2
459     setosa Petal     Width   0.2
460     setosa Petal     Width   0.1
461     setosa Petal     Width   0.2
462     setosa Petal     Width   0.2
463     setosa Petal     Width   0.1
464     setosa Petal     Width   0.1
465     setosa Petal     Width   0.2
466     setosa Petal     Width   0.4
467     setosa Petal     Width   0.4
468     setosa Petal     Width   0.3
469     setosa Petal     Width   0.3
470     setosa Petal     Width   0.3
471     setosa Petal     Width   0.2
472     setosa Petal     Width   0.4
473     setosa Petal     Width   0.2
474     setosa Petal     Width   0.5
475     setosa Petal     Width   0.2
476     setosa Petal     Width   0.2
477     setosa Petal     Width   0.4
478     setosa Petal     Width   0.2
479     setosa Petal     Width   0.2
480     setosa Petal     Width   0.2
481     setosa Petal     Width   0.2
482     setosa Petal     Width   0.4
483     setosa Petal     Width   0.1
484     setosa Petal     Width   0.2
485     setosa Petal     Width   0.2
486     setosa Petal     Width   0.2
487     setosa Petal     Width   0.2
488     setosa Petal     Width   0.1
489     setosa Petal     Width   0.2
490     setosa Petal     Width   0.2
491     setosa Petal     Width   0.3
492     setosa Petal     Width   0.3
493     setosa Petal     Width   0.2
494     setosa Petal     Width   0.6
495     setosa Petal     Width   0.4
496     setosa Petal     Width   0.3
497     setosa Petal     Width   0.2
498     setosa Petal     Width   0.2
499     setosa Petal     Width   0.2
500     setosa Petal     Width   0.2
501 versicolor Petal     Width   1.4
502 versicolor Petal     Width   1.5
503 versicolor Petal     Width   1.5
504 versicolor Petal     Width   1.3
505 versicolor Petal     Width   1.5
506 versicolor Petal     Width   1.3
507 versicolor Petal     Width   1.6
508 versicolor Petal     Width   1.0
509 versicolor Petal     Width   1.3
510 versicolor Petal     Width   1.4
511 versicolor Petal     Width   1.0
512 versicolor Petal     Width   1.5
513 versicolor Petal     Width   1.0
514 versicolor Petal     Width   1.4
515 versicolor Petal     Width   1.3
516 versicolor Petal     Width   1.4
517 versicolor Petal     Width   1.5
518 versicolor Petal     Width   1.0
519 versicolor Petal     Width   1.5
520 versicolor Petal     Width   1.1
521 versicolor Petal     Width   1.8
522 versicolor Petal     Width   1.3
523 versicolor Petal     Width   1.5
524 versicolor Petal     Width   1.2
525 versicolor Petal     Width   1.3
526 versicolor Petal     Width   1.4
527 versicolor Petal     Width   1.4
528 versicolor Petal     Width   1.7
529 versicolor Petal     Width   1.5
530 versicolor Petal     Width   1.0
531 versicolor Petal     Width   1.1
532 versicolor Petal     Width   1.0
533 versicolor Petal     Width   1.2
534 versicolor Petal     Width   1.6
535 versicolor Petal     Width   1.5
536 versicolor Petal     Width   1.6
537 versicolor Petal     Width   1.5
538 versicolor Petal     Width   1.3
539 versicolor Petal     Width   1.3
540 versicolor Petal     Width   1.3
541 versicolor Petal     Width   1.2
542 versicolor Petal     Width   1.4
543 versicolor Petal     Width   1.2
544 versicolor Petal     Width   1.0
545 versicolor Petal     Width   1.3
546 versicolor Petal     Width   1.2
547 versicolor Petal     Width   1.3
548 versicolor Petal     Width   1.3
549 versicolor Petal     Width   1.1
550 versicolor Petal     Width   1.3
551  virginica Petal     Width   2.5
552  virginica Petal     Width   1.9
553  virginica Petal     Width   2.1
554  virginica Petal     Width   1.8
555  virginica Petal     Width   2.2
556  virginica Petal     Width   2.1
557  virginica Petal     Width   1.7
558  virginica Petal     Width   1.8
559  virginica Petal     Width   1.8
560  virginica Petal     Width   2.5
561  virginica Petal     Width   2.0
562  virginica Petal     Width   1.9
563  virginica Petal     Width   2.1
564  virginica Petal     Width   2.0
565  virginica Petal     Width   2.4
566  virginica Petal     Width   2.3
567  virginica Petal     Width   1.8
568  virginica Petal     Width   2.2
569  virginica Petal     Width   2.3
570  virginica Petal     Width   1.5
571  virginica Petal     Width   2.3
572  virginica Petal     Width   2.0
573  virginica Petal     Width   2.0
574  virginica Petal     Width   1.8
575  virginica Petal     Width   2.1
576  virginica Petal     Width   1.8
577  virginica Petal     Width   1.8
578  virginica Petal     Width   1.8
579  virginica Petal     Width   2.1
580  virginica Petal     Width   1.6
581  virginica Petal     Width   1.9
582  virginica Petal     Width   2.0
583  virginica Petal     Width   2.2
584  virginica Petal     Width   1.5
585  virginica Petal     Width   1.4
586  virginica Petal     Width   2.3
587  virginica Petal     Width   2.4
588  virginica Petal     Width   1.8
589  virginica Petal     Width   1.8
590  virginica Petal     Width   2.1
591  virginica Petal     Width   2.4
592  virginica Petal     Width   2.3
593  virginica Petal     Width   1.9
594  virginica Petal     Width   2.3
595  virginica Petal     Width   2.5
596  virginica Petal     Width   2.3
597  virginica Petal     Width   1.9
598  virginica Petal     Width   2.0
599  virginica Petal     Width   2.3
600  virginica Petal     Width   1.8
```


Reshaping datasets
========================================================

You can also work the opposite way, spreading data _across columns_.

The `tidyr::spread` functions is actually considerably less functional than `reshape2::cast`. This is by design, but it's also frustrating.

Reshaping datasets
========================================================


```r
df <- data.frame(x = c("a", "b"), 
                 y = c(3, 4), 
                 z = c(5, 6))
df
```

```
  x y z
1 a 3 5
2 b 4 6
```

```r
df %>% spread(x, y)
```

```
  z  a  b
1 5  3 NA
2 6 NA  4
```

Reshaping datasets
========================================================


```r
df
```

```
  x y z
1 a 3 5
2 b 4 6
```

```r
df %>% 
  spread(x, y) %>% 
  gather(x, y, a:b, na.rm = TRUE)
```

```
  z x y
1 5 a 3
4 6 b 4
```


Summarizing and manipulating data
========================================================

Thinking back to the typical data pipeline, we often want to summarize data by groups as an intermediate or final step. For example, for each subgroup we might want to:

* Compute mean, max, min, etc. (`n`->1)
* Compute rolling mean and other window functions (`n`->`n`)
* Fit models and extract their parameters, goodness of fit, etc.

Specific examples:

* `cars`: for each speed, what's the farthest distance traveled?
* `iris`: how many samples were taken from each species?
* `babynames`: what's the most common name over time?


Split-apply-combine
========================================================

These are generally known as *split-apply-combine* problems.

<img src="images/split_apply_combine.png" width="600" />

From https://github.com/ramnathv/rblocks/issues/8


aggregate
========================================================

Base R has an `aggregate` function. It's not particularly fast or flexible, and confusingly it has different forms (syntax).

It can however be useful for simple operations:


```r
# What's the farthest distance at each speed?
aggregate(dist ~ speed, 
          data = cars, FUN = max)
```

```
   speed dist
1      4   10
2      7   22
3      8   16
4      9   10
5     10   34
6     11   28
7     12   28
8     13   46
9     14   80
10    15   54
11    16   40
12    17   50
13    18   84
14    19   68
15    20   64
16    22   66
17    23   54
18    24  120
19    25   85
```


dplyr
========================================================

The newer `dplyr` package specializes in data frames, recognizing that most people use them most of the time.

`dplyr` also allows you to work with remote, out-of-memory databases, using exactly the same tools, because it abstracts away *how* your data is stored.

`dplyr` is **extremely fast**.


Verbs
========================================================

`dplyr` provides functions for each basic *verb* of data manipulation. These tend to have analogues in base R, but use a consistent, compact syntax, and are very high performance.

* `filter()` - subset rows; like `base::subset()`
* `arrange()` - reorder rows; like `order()`
* `select()` - select columns
* `mutate()` - add new columns
* `summarise()` - like `aggregate`


Grouping
========================================================

`dplyr` verbs become particularly powerful when used in conjunction with *groups* we define in the dataset. The `group_by` function converts an existing data frame into a grouped `tbl`.


```r
library(dplyr)
cars %>%
  group_by(speed)
```

```
Source: local data frame [50 x 2]
Groups: speed [19]

   speed  dist
   <dbl> <dbl>
1      4     2
2      4    10
3      7     4
4      7    22
5      8    16
6      9    10
7     10    18
8     10    26
9     10    34
10    11    17
# ... with 40 more rows
```


Summarizing cars
========================================================

We previously did this using `aggregate`. Now, `dplyr`:


```r
cars %>% 
  group_by(speed) %>% 
  summarise(max(dist))
```

```
# A tibble: 19 x 2
   speed max(dist)
   <dbl>     <dbl>
1      4        10
2      7        22
3      8        16
4      9        10
5     10        34
6     11        28
7     12        28
8     13        46
9     14        80
10    15        54
11    16        40
12    17        50
13    18        84
14    19        68
15    20        64
16    22        66
17    23        54
18    24       120
19    25        85
```


Summarizing iris
========================================================


```r
iris %>% 
  group_by(Species) %>% 
  summarise(msl = mean(Sepal.Length))
```

```
# A tibble: 3 x 2
     Species   msl
      <fctr> <dbl>
1     setosa 5.006
2 versicolor 5.936
3  virginica 6.588
```


Summarizing iris
========================================================

We can apply (multiple) functions across (multiple) columns.


```r
iris %>% 
  group_by(Species) %>% 
  summarise_each(funs(mean, median, sd), 
                 Sepal.Length)
```

```
# A tibble: 3 x 4
     Species  mean median        sd
      <fctr> <dbl>  <dbl>     <dbl>
1     setosa 5.006    5.0 0.3524897
2 versicolor 5.936    5.9 0.5161711
3  virginica 6.588    6.5 0.6358796
```


Introducting `babynames`
========================================================


```r
library(babynames)
babynames
```

```
# A tibble: 1,825,433 x 5
    year   sex      name     n       prop
   <dbl> <chr>     <chr> <int>      <dbl>
1   1880     F      Mary  7065 0.07238359
2   1880     F      Anna  2604 0.02667896
3   1880     F      Emma  2003 0.02052149
4   1880     F Elizabeth  1939 0.01986579
5   1880     F    Minnie  1746 0.01788843
6   1880     F  Margaret  1578 0.01616720
7   1880     F       Ida  1472 0.01508119
8   1880     F     Alice  1414 0.01448696
9   1880     F    Bertha  1320 0.01352390
10  1880     F     Sarah  1288 0.01319605
# ... with 1,825,423 more rows
```


Summarizing babynames
========================================================

What does this calculate?


```r
babynames %>%
  group_by(year, sex) %>% 
  summarise(prop = max(prop), 
            name = name[which.max(prop)])
```

```
Source: local data frame [270 x 4]
Groups: year [?]

    year   sex       prop  name
   <dbl> <chr>      <dbl> <chr>
1   1880     F 0.07238359  Mary
2   1880     M 0.08154561  John
3   1881     F 0.06999069  Mary
4   1881     M 0.08098149  John
5   1882     F 0.07042473  Mary
6   1882     M 0.07831488  John
7   1883     F 0.06673108  Mary
8   1883     M 0.07907183  John
9   1884     F 0.06698985  Mary
10  1884     M 0.07648626  John
# ... with 260 more rows
```


Summarizing babynames
========================================================

<img src="images/popular_babynames.png" width="800" />

https://en.wikipedia.org/wiki/Linda_(1946_song)


Why use dplyr?
========================================================

* Clean, concise, and consistent syntax.

* In general `dplyr` is ~10x faster than the older `plyr` package. (And `plyr` was ~10x faster than base R.)

* Same code can work with data frames or remote databases.


Hands-on: manipulating the `babynames` dataset
========================================================
type: prompt
incremental: false

Load the dataset using `library(babynames)`.

Read its help page. Look at its structure (rows, columns, summary).

Use `dplyr` to calculate the total number of names in the SSA database for each year. 

Calculate the 5th most popular name for girls in each year. Hint: `nth()`.




Things we didn't talk about
========================================================

- reading data into R (not much)
- working with non-text data
- reshaping data
- writing data
- graphing data



Last thoughts
========================================================

>The best thing about R is that it was written by statisticians. The worst thing about R is that it was written by statisticians.
>
>-- Bow Cowgill

All the source code for this presentation is available at https://github.com/bpbond/R-data-picarro


Resources
========================================================
type: section


Resources
========================================================

* [CRAN](http://cran.r-project.org) - The Comprehensive R Archive Network.
* [GitHub](https://github.com/JGCRI) - The JGCRI organization page on GitHub.
* [RStudio](http://www.rstudio.com) - the integrated development environment for R. Makes many things hugely easier.
* [Advanced R](http://adv-r.had.co.nz) - the companion website for “Advanced R”, a book in Chapman & Hall’s R Series. Detailed, in depth look at many of the issues covered here.


Resources
========================================================

R has many contributed *packages* across a wide variety of scientific fields. Almost anything you want to do will have packages to support it.

[CRAN](http://cran.r-project.org) also provides "Task Views". For example:

***

- Bayesian
- Clinical Trials
- Differential Equations
- Finance
- Genetics
- HPC
- Meta-analysis
- Optimization
- [**Reproducible Research**](http://cran.r-project.org/web/views/ReproducibleResearch.html)
- Spatial Statistics
- Time Series
