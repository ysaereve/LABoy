### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 0053bace-00d4-11eb-1072-cbc1284550c5
# 環境設定
begin
	using Printf
	using Dates
	using PlutoUI
	using Plots

	_date_=today()
	md"""
	### 目前進度： 單元 3．Gaussian Elimination <<<
	Date: $_date_
	"""
end

# ╔═╡ 9d9a54ea-ff9c-11ea-1db7-1ba194b9fb3c
md"""
# 線性代數 + Julia + $$\LaTeX$$ 的學習筆記 
Date: $_date_

整個學習過程將以如下「線性代數」課程為主軸學習：

### 線性代數 台灣大學電機系 蘇柏青

本課程是線性代數的入門課程。線性代數係以「向量空間」(Vector Space)為核心概念之數學工具，擁有極廣泛之應用，非常值得理工商管等科系大學部同學深入修習，作為日後專業應用之基礎。   

課程來源：[http://ocw.aca.ntu.edu.tw/ntu-ocw/index.php/ocw/cou/102S207](http://ocw.aca.ntu.edu.tw/ntu-ocw/index.php/ocw/cou/102S207)

## 學習目標
如下為幾個學習的子目標

### 學科
- 線性代數 - 

### 工具

- Julia 
- Pluto
- LaTeX
- Markdown

### 服務
- GitHub - 學習使用 GitHub 服務，並記錄學習歷程及分享學習內容。
"""

# ╔═╡ c4b94650-026a-11eb-3526-f39fc9a07563


# ╔═╡ cb144730-026e-11eb-088b-db01b40d6da4


# ╔═╡ 55153d26-00d1-11eb-016d-9b1def7d4644
html"""
<hr>
"""

# ╔═╡ a40a1be4-ff9c-11ea-33d3-8bcf3b73e930
md"## 單元 1．Basic Concepts on Matrices and Vectors"

# ╔═╡ 71136776-fff2-11ea-0eb6-47a04c1c77d6
md"""
### Matrix
$$A=\begin{bmatrix} a_{11} & \dots & a_{1n} \\ \vdots & \ddots & \vdots \\ a_{m1} & \dots & a_{mn}\end{bmatrix}=\begin{bmatrix} a_{ij} \end{bmatrix}=M_{mn}$$
"""

# ╔═╡ a156894a-ffd4-11ea-1e22-29fb46b20097
md"""
### Matrix Addition
$$\begin{bmatrix} 1 & 2 \\ 3 & 4 \\ 5 & 6 \end{bmatrix} + \begin{bmatrix} 1 & 1 \\ 1 & 1 \\ 1 & 2 \end{bmatrix} = \begin{bmatrix} 2 & 3 \\ 4 & 5 \\ 6 & 8 \end{bmatrix}$$
"""

# ╔═╡ 06754e3a-ffe2-11ea-0220-9b066f8651e7
[1 2; 3 4; 5 6]+[1 1; 1 1; 1 2]

# ╔═╡ c50b8e9a-ffe2-11ea-2326-c3b69913b27c
md"""
### Scalar Multiplication
$$cA$$
$$3 \cdot \begin{bmatrix} 1 & 2 \\ 3 & 4 \\ 5 & 6 \end{bmatrix}$$
"""

# ╔═╡ 04823ca4-ffe3-11ea-3fab-0d8eaedb8c9a
3 * [1 2; 3 4; 5 6]

# ╔═╡ b7bcfc2c-ffe4-11ea-2862-432081314a58
3 .* [1 2; 3 4; 5 6]

# ╔═╡ f4077336-ffe4-11ea-2482-81f261e32798
md"""
### Transpose
$$C=\begin{bmatrix} 7 & 9 \\ 18 & 31 \\ 52 & 68 \end{bmatrix} \;\:\Rightarrow\;\; C^T = \begin{bmatrix} 7 & 18 & 52 \\ 9 & 31 & 68 \end{bmatrix}$$
"""

# ╔═╡ 047d2898-ffe5-11ea-241f-6d1064a665e8
let
	C=[7 9; 18 31; 52 68]
	C'
end

# ╔═╡ ea9c0a1c-ffe8-11ea-3df9-c5a82dc5c077
md"""
### Vectors

Row Vector:

$$\begin{bmatrix} 1 & 2 & 3 & 4 \end{bmatrix}$$

Column Vector:

$$\begin{bmatrix} 1 \\ 2 \\ 3 \\ 4 \end{bmatrix}$$

$$\Downarrow$$

$$\begin{bmatrix} 1 & 2 & 3 & 4 \end{bmatrix}^T$$

The ith componet of $$\textbf{v}$$

$$v_i$$

"""

# ╔═╡ 5018d0f0-ffe9-11ea-0ba4-f3ca17a7eddb
[ 1 2 3 4]

# ╔═╡ 676ff59e-ffe9-11ea-22ec-31be78dfa211
[1; 2; 3; 4;]

# ╔═╡ 491d2fd0-ffeb-11ea-009f-4b10a02ba938
[ 1 2 3 4]'

# ╔═╡ 47e73308-fff9-11ea-2cee-7f050938fe19
md"""
### Linear Combination
A $$\textcolor{red}{linear\;combination}\;of\;vectors \; 
$$\textbf{u}_1,\textbf{u}_2,\dots,\textbf{u}_k$$ is a vector of the form

$$c_1\textbf{u}_1+c_2\textbf{u}_2+\dots+c_k\textbf{u}_k$$

where $$c_1,c_2,\dots,c_k$$ are scalars. These scalars are called the $$\textcolor{red}{coefficients}$$ of the linear combination.
"""

# ╔═╡ 99e6bccc-fffa-11ea-223a-a3dfd65dee92
md"""
### Standard Vectors

The standard vectors of $$R^n$$ are defined as

$$e_1=\begin{bmatrix} 1 \\ 0 \\ \vdots \\ 0 \end{bmatrix}, e_2=\begin{bmatrix} 0 \\ 1 \\ \vdots \\ 0 \end{bmatrix}, \dots , e_n=\begin{bmatrix} 0 \\ 0 \\ \vdots \\ 1 \end{bmatrix}$$

"""

# ╔═╡ 741db230-fffb-11ea-23aa-63d365767cbd
md"""
### Matrix-Vector Product
$$Av=v_1a_1+v_2a_2+\dots+v_na_n$$
"""

# ╔═╡ c497553e-fffb-11ea-3559-e59103e843e2
let 
	A=[1 2; 3 4; 5 6]
	v=[7;8]
	A*v
end

# ╔═╡ aff2680a-fffe-11ea-0494-1d349105eff0
md"""
### Identity Matrix
$$I_3=\begin{bmatrix} 1 & 0 & 0\\ 0 & 1 & 0 \\ 0 & 0 & 1\end{bmatrix}$$

"""

# ╔═╡ 42f11192-ffff-11ea-34ca-81545f4b5374
md"""
### Stochastic Matrix
$$A=\begin{bmatrix} 0.85 & 0.03 \\ 0.15 & 0.97 \end{bmatrix}$$
"""

# ╔═╡ 988b781e-026f-11eb-02b7-8d2de841d478
begin
	u01xslider = @bind u01x Slider(1:100; default=40, show_value=true)
	u01cslider = @bind u01c Slider(0:1200; default=1200, show_value=true)
	u01sslider = @bind u01s Slider(0:1200; default=0, show_value=true)
	md"""
	Slide to set number of **years**: $(u01xslider) 
	
	Slide to set population of **city**: $(u01cslider)
	
	Slide to set population of **suburban**: $(u01sslider)
	"""
end

# ╔═╡ cb2c5e54-ffff-11ea-3e4e-a349d0a09341
let 
	x=u01x # Number of Years (x)
	pc=u01c # Population of City
	ps=u01s # Population of Suburban
	A=[0.85 0.03; 0.15 0.97]
	#=
	# p0 Population in year 0
	p0=[500; 700]
	p1=A*p0
	p2=A*(p1)
	p3=A*(p2)
	p4=A*(p3)
	p5=A*(p4)
	x=0:5
	Y=hcat(p0, p1, p2, p3, p4, p5)
	plot(x, Y', title = "Population", label = ["City" "Suburban"])
	=#
	p=[pc; ps]
	Y=p
	for i in 1:x
		p=A*p
		Y=hcat(Y, p)
	end
	plot(0:x, Y', title = "Population Trend", label = ["City" "Suburban"])
end

# ╔═╡ 67ed416e-00d1-11eb-29cc-23eaa30c3446
html"""
<hr>
"""

# ╔═╡ afcd29d0-ff9c-11ea-09bf-e5a0ed087c42
md"## 單元 2．System of Linear Equations"

# ╔═╡ 8c300b8a-ffd5-11ea-3ec9-27ccc82cea6e
# \backslash \setminus
md"""
### System of Linear Equations
$$A=\begin{bmatrix} 1 & -2 & -1 \\ 3 & -6 & -5 \\ 2 & -1 & 1 \end{bmatrix} 
\;\;
b=\begin{bmatrix} 3 \\ 3\\ 0 \end{bmatrix}$$
$$Ax=b$$

Solves Ax = b by (essentially) Gaussian elimination (Julia \ Operator):

$$x=A\;\backslash\;b$$
"""

# ╔═╡ 70803966-ff9c-11ea-0a8a-d7860f4f87c0
# Solve System of Linear Equations
let
	A=[1 -2 -1; 3 -6 -5; 2 -1 1]
	b=[3; 3; 0]
	A \ b	
end

# ╔═╡ 6a110912-0009-11eb-0a73-0b2e2ec0b634
md"""
### Row Echelon Form & Reduced Row Echelon Form
"""

# ╔═╡ 4b8f75e0-000a-11eb-175b-d7a9102f65ca
let 
	A=[1 -3 0 2 0; 0 0 1 6 0; 0 0 0 0 1; 0 0 0 0 0]
	b=[7; 9; 2; 0]
	A \ b
end

# ╔═╡ 1f9799ea-00d2-11eb-1b94-d7d3056a2c41
html"""
<hr>
"""

# ╔═╡ ecfe3ef0-007a-11eb-3efb-7740876167a8
md"""
## 單元 3．Gaussian Elimination

實作參考：

[Gaussian-elimination.pdf](http://web.mit.edu/18.06/www/Spring17/Gaussian-elimination.pdf)

[Numerical Analysis by Julia Series 1 — Gauss Elimination | by Treee July | Medium]
(https://medium.com/@julytreee/numerical-analysis-by-julia-series-1-gauss-elimination-68e902a43c7e)
"""

# ╔═╡ b76720a6-00d2-11eb-19ae-d59e7204a005
md"""
對列及行的參照：
"""

# ╔═╡ 0c9dd736-00d8-11eb-077a-67cf34db152d
let
	A=[ 1 2 3; 4 5 6; 7 8 9]
end

# ╔═╡ 2fa8b248-00d6-11eb-0f85-871512ef16d2
let
	o=[]
	# Matrix
	A=[ 1 2 3; 4 5 6; 7 8 9]
	push!(o, @sprintf("A: %s", A))
	# Elements
	push!(o, @sprintf("A[1, 1]: %s", A[1, 1]))
	push!(o, @sprintf("A[end, end]: %s", A[end, end]))
	# Row
	r1=A[1,:]
	push!(o, @sprintf("r1: %s", r1))
	∑Ai=A[1,:]+A[2,:]+A[3,:]
	push!(o, @sprintf("∑Ai: %s", ∑Ai))
	# Column
	c1=A[:,1]
	push!(o, @sprintf("c1: %s", c1))
	∑Aj=A[:,1]+A[:,2]+A[:,3]
	push!(o, @sprintf("∑Aj: %s", ∑Aj))
	# with_terminal(dump, o)
end

# ╔═╡ 479e95e2-0274-11eb-2c2a-993ba9119fba
let
	with_terminal() do
		# Get Current Time
		command=`date`
		run(command)
		# Matrix
		A=[ 1 2 3; 4 5 6; 7 8 9]
		println("A:"); dump(A)
		# Elements
		println("A[1, 1]:"); dump(A[1, 1])
		println("A[end, end]:"); dump(A[end, end])
		# Row
		r1=A[1,:]
		println("r1:");	dump(r1)
		∑Ai=A[1,:]+A[2,:]+A[3,:]
		println("∑Ai:"); dump(∑Ai)
		# Column
		c1=A[:,1]
		println("c1:");	dump(c1)
		∑Aj=A[:,1]+A[:,2]+A[:,3]
		println("∑Aj:"); dump(∑Aj)
	end 
end

# ╔═╡ f7de8296-0393-11eb-0782-57e9272ad999
md"""
## 單元 4．The language of set theory
"""

# ╔═╡ 97f12ddc-00cf-11eb-173d-47a7931a9a08
md"""
### <<<
"""

# ╔═╡ 7dbac3ec-00d1-11eb-2c17-3bab40ffaa2e
html"""
<hr>
"""

# ╔═╡ 770ab5ac-fff8-11ea-1ed1-87b0ae3aca70
md"""
## 參考資料
### Linear Algebra

[ ] [線性代數 - 臺大開放式課程 (NTU OpenCourseWare)](http://ocw.aca.ntu.edu.tw/ntu-ocw/index.php/ocw/cou/102S207/3)

### Julia

[ ] [Introduction to Julia](https://juliaacademy.com/courses/enrolled/375479)

[ ] Advanced topics

[ ] [Julia for Data Science](https://juliaacademy.com/courses/enrolled/937702)

[ ] [18.S191 Introduction to Computational Thinking](https://computationalthinking.mit.edu/Fall20/)

### Pluto
[Docstrings · PlutoUI.jl](https://juliahub.com/docs/PlutoUI/abXFp/0.6.3/autodocs/)

### $$\LaTeX$$
[LaTeX - Mathematical Python](https://www.math.ubc.ca/~pwalls/math-python/jupyter/latex/)

[LaTeX help 1.1 - Table of Contents](http://www.emerson.emory.edu/services/latex/latex_toc.html)

[List of mathematical symbols - Wikiwand](https://www.wikiwand.com/en/List_of_mathematical_symbols)

### Markdown
[Markdown Cheatsheet · adam-p/markdown-here Wiki](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

[Markdown · The Julia Language](https://docs.julialang.org/en/v1/stdlib/Markdown/)

### GitHub

[ ] [Hello World · GitHub Guides](https://guides.github.com/activities/hello-world/)
"""

# ╔═╡ Cell order:
# ╠═9d9a54ea-ff9c-11ea-1db7-1ba194b9fb3c
# ╠═c4b94650-026a-11eb-3526-f39fc9a07563
# ╠═cb144730-026e-11eb-088b-db01b40d6da4
# ╠═0053bace-00d4-11eb-1072-cbc1284550c5
# ╟─55153d26-00d1-11eb-016d-9b1def7d4644
# ╟─a40a1be4-ff9c-11ea-33d3-8bcf3b73e930
# ╟─71136776-fff2-11ea-0eb6-47a04c1c77d6
# ╟─a156894a-ffd4-11ea-1e22-29fb46b20097
# ╠═06754e3a-ffe2-11ea-0220-9b066f8651e7
# ╟─c50b8e9a-ffe2-11ea-2326-c3b69913b27c
# ╠═04823ca4-ffe3-11ea-3fab-0d8eaedb8c9a
# ╠═b7bcfc2c-ffe4-11ea-2862-432081314a58
# ╟─f4077336-ffe4-11ea-2482-81f261e32798
# ╠═047d2898-ffe5-11ea-241f-6d1064a665e8
# ╟─ea9c0a1c-ffe8-11ea-3df9-c5a82dc5c077
# ╠═5018d0f0-ffe9-11ea-0ba4-f3ca17a7eddb
# ╠═676ff59e-ffe9-11ea-22ec-31be78dfa211
# ╠═491d2fd0-ffeb-11ea-009f-4b10a02ba938
# ╟─47e73308-fff9-11ea-2cee-7f050938fe19
# ╟─99e6bccc-fffa-11ea-223a-a3dfd65dee92
# ╟─741db230-fffb-11ea-23aa-63d365767cbd
# ╠═c497553e-fffb-11ea-3559-e59103e843e2
# ╟─aff2680a-fffe-11ea-0494-1d349105eff0
# ╟─42f11192-ffff-11ea-34ca-81545f4b5374
# ╠═988b781e-026f-11eb-02b7-8d2de841d478
# ╠═cb2c5e54-ffff-11ea-3e4e-a349d0a09341
# ╟─67ed416e-00d1-11eb-29cc-23eaa30c3446
# ╟─afcd29d0-ff9c-11ea-09bf-e5a0ed087c42
# ╟─8c300b8a-ffd5-11ea-3ec9-27ccc82cea6e
# ╠═70803966-ff9c-11ea-0a8a-d7860f4f87c0
# ╟─6a110912-0009-11eb-0a73-0b2e2ec0b634
# ╠═4b8f75e0-000a-11eb-175b-d7a9102f65ca
# ╟─1f9799ea-00d2-11eb-1b94-d7d3056a2c41
# ╟─ecfe3ef0-007a-11eb-3efb-7740876167a8
# ╟─b76720a6-00d2-11eb-19ae-d59e7204a005
# ╠═0c9dd736-00d8-11eb-077a-67cf34db152d
# ╠═2fa8b248-00d6-11eb-0f85-871512ef16d2
# ╠═479e95e2-0274-11eb-2c2a-993ba9119fba
# ╠═f7de8296-0393-11eb-0782-57e9272ad999
# ╠═97f12ddc-00cf-11eb-173d-47a7931a9a08
# ╟─7dbac3ec-00d1-11eb-2c17-3bab40ffaa2e
# ╠═770ab5ac-fff8-11ea-1ed1-87b0ae3aca70
