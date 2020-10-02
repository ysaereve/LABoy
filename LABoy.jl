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
	# using LinearAlgebra # Most of them are in Base
	using RowEchelon # 單元 9．Column Correspondence Theorem

	_date_=today()
	html"""
	<hr>
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
如下為幾個學習的子目標：

### 學科
- 線性代數 - 重新學習線性代數，了解重要概念的中文及英文詞𢑥及應用。

### 工具

- Julia - 深入學習，了解重要套件的應用及使用。
- Pluto - 隨之成長，作為撰寫學習記錄的工具。
- LaTeX - 隨緣學習，作為撰寫學習記錄的工具。
- Markdown - 隨緣學習，作為撰寫學習記錄的工具。

### 服務
- GitHub - 學習使用 GitHub 服務，並記錄學習歷程及分享學習內容。
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
	with_terminal() do
		A=[1 -2 -1; 3 -6 -5; 2 -1 1]
		b=[3; 3; 0]
		x=A \ b
		println(x)
		println(A*x)
		println(A*x == b)
	end
end

# ╔═╡ 6a110912-0009-11eb-0a73-0b2e2ec0b634
md"""
### Row Echelon Form & Reduced Row Echelon Form
"""

# ╔═╡ 4b8f75e0-000a-11eb-175b-d7a9102f65ca
# Solve System of Linear Equations
let 
	with_terminal() do
		A=[1 -3 0 2 0; 0 0 1 6 0; 0 0 0 0 1; 0 0 0 0 0]
		b=[7; 9; 2; 0]
		x=A \ b
		println(x)
		println(A*x)
		println(A*x == b)
	end
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
	with_terminal(dump, o)
end

# ╔═╡ 479e95e2-0274-11eb-2c2a-993ba9119fba
let
	with_terminal() do
		println("👍 選定之輸出方案： 1) 容易以 do ... end 區塊包裝 3) 轉貼程式碼到他處不用修改\n")
		# Get Current Time
		command=`date`
		run(command)
		# Matrix
		A=[ 1 2 3; 4 5 6; 7 8 9]
		print("A: "); dump(A)
		# Elements
		print("A[1, 1]: "); dump(A[1, 1])
		print("A[end, end]: "); dump(A[end, end])
		# Row
		r1=A[1,:]
		print("r1: ");	dump(r1)
		∑Ai=A[1,:]+A[2,:]+A[3,:]
		print("∑Ai: "); dump(∑Ai)
		# Column
		c1=A[:,1]
		print("c1: ");	dump(c1)
		∑Aj=A[:,1]+A[:,2]+A[:,3]
		print("∑Aj: "); dump(∑Aj)
		println()
		run(`cal -h`)
	end 
end

# ╔═╡ 816cc338-03a1-11eb-2872-c7643faab770
let
	Text() do io
		# Matrix
		A=[ 1 2 3; 4 5 6; 7 8 9]
		print(io, "A: "); dump(io, A)
		# Elements
		print(io, "A[1, 1]: "); dump(io, A[1, 1])
		print(io, "A[end, end]: "); dump(io, A[end, end])
		# Row
		r1=A[1,:]
		print(io, "r1: ");	dump(io, r1)
		∑Ai=A[1,:]+A[2,:]+A[3,:]
		print(io, "∑Ai: "); dump(io, ∑Ai)
		# Column
		c1=A[:,1]
		print(io, "c1: ");	dump(io, c1)
		∑Aj=A[:,1]+A[:,2]+A[:,3]
		print(io, "∑Aj: "); dump(io, ∑Aj)
	end
end

# ╔═╡ ee3ed802-03a3-11eb-025c-5bee178511af
let
		# Matrix
		A=[ 1 2 3; 4 5 6; 7 8 9]
		# Row
		r1=A[1,:]
		∑Ai=A[1,:]+A[2,:]+A[3,:]
		# Column
		c1=A[:,1]
		∑Aj=A[:,1]+A[:,2]+A[:,3]
	md"""
	A: $(Text(A))
	
	A[1, 1]: $(Text(A[1, 1]))
	
	A[end, end]: $(Text(A[end, end]))

	r1: $(Text(r1))

	∑Ai: $(Text(∑Ai))
	
	c1: $(Text(c1))
	
	∑Aj: $(Text(∑Aj))
	"""
end

# ╔═╡ f7de8296-0393-11eb-0782-57e9272ad999
md"""
## 單元 4．The language of set theory
"""

# ╔═╡ 35ec879e-03ae-11eb-15ce-016ae8a89168
md"""
#### Subset
$$Let\; S_1=\{a, b, c, d, e\},\; S_2={a, b, e}$$$$
S_2 ⊂ S_1\;means\;$$$$ 
∀x ∈ S_2,\:x\;is\;also ∈ S_1.$$
"""

# ╔═╡ cfaeab08-03b2-11eb-3930-ddb92e799789
let
	with_terminal() do
		s1=Set(["a", "b", "c", "d", "e"])
		println("🖐 Give Me Five, 原來集合在 Julia 裹頭是長這樣子喔！☯")
		dump(s1)
		println(s1)
		s2=Set(["a", "b", "e"])
		println(s2)
		# subset
		println(⊆(s2, s1))
		# union set
		println(∪(s1, s2))
		# intersection set
		println(∩(s1, s2))
		# difference set
		println(setdiff(s1, s2))
		println(setdiff(s2, s1))
	end
end

# ╔═╡ 0445c5ba-03cb-11eb-2093-b71bae438a19
md"""
## 單元 5．Span of a Set of Vectors
"""

# ╔═╡ 698fc53a-03d5-11eb-39b7-a776fabae2f2
md"""
實作參考：

[Linear Algebra – Quantitative Economics with Julia](https://julia.quantecon.org/tools_and_techniques/linear_algebra.html)
"""

# ╔═╡ 408f674e-03d5-11eb-3dc8-ed1addf002be
let
	x_vals = [0 0 0 ; 2 -3 -4]
	y_vals = [0 0 0 ; 4 3 -3.5]
	
	plot(x_vals, y_vals, arrow = true, color = :blue,
	     legend = :none, xlims = (-5, 5), ylims = (-5, 5),
	     annotations = [(2.2, 4.4, "[2, 4]"),
	                    (-3.3, 3.3, "[-3, 3]"),
	                    (-4.4, -3.85, "[-4, -3.5]")],
	     xticks = -5:1:5, yticks = -5:1:5,
	     framestyle = :origin)
end

# ╔═╡ 73360416-03da-11eb-1721-cf76aa462151
begin
	u05islider = @bind u05i Slider(1:5; default=1, show_value=true)
	u05jslider = @bind u05j Slider(1:5; default=5, show_value=true)
	md"""
	Slide to set **i**: $(u05islider) 
	
	Slide to set **j**: $(u05jslider) 
	"""
end

# ╔═╡ ac04f844-03d8-11eb-2db2-dbc19b343325
let
	i=u05i
	j=u05j
	# fixed linear function, to generate a plane
	f(x, y) = 0.2x + 0.1y
	
	# lines to vectors
	x_vec = [0 0 0 0 0; 3 3 -4 -4 3.5]
	y_vec = [0 0 0 0 0; 4 -4 -4 4 0]
	z_vec = [0 0 0 0 0; f(3, 4) f(3, -4) f(-4,-4) f(-4, 4) f(3.5, 0)]
	color = [:blue :green :red :brown :cyan]
	
	# draw the plane
	n = 20
	grid = range(-5, 5, length = n)
	z2 = [ f(grid[row], grid[col]) for row in 1:n, col in 1:n ]
	# wireframe(grid, grid, z2, fill = :blues, gridalpha =1 )
	plot(grid, grid, z2, fill = :blues, gridalpha = 1, lindwidth = 0.5, seriestype = :wireframe)
	# plot(grid, grid, z2, fill = :blues, gridalpha = 1, lindwidth = 0.5, seriestype = :surface)
	# Dots
	# plot!([0; 4; 4; -4; -4], [0; 4; -4; 4; -4], [-1.5; -1.5; -1.5; -1.5; -1.5], labels = "", seriestype = :scatter3d)
	p = [ 0 0 -1.5; 4 4 -1.5; 4 -4 -1.5; -4 4 -1.5; -4 -4 -1.5]' # Transpose
	plot!(p[1, i:j], p[2, i:j], p[3, i:j], labels = "", seriestype = :scatter3d)
	plot!(p[1, i:j], p[2, i:j], p[3, i:j], labels = "", seriestype = :path3d)
	# Vectors
	plot!(x_vec[:, i:j], y_vec[:, i:j], z_vec[:, i:j], color = color[:,i:j], linewidth = 3, xlabel = "x", ylabel = "y", zlabel = "z", labels = "", colorbar = false)
	# plot!(x_vec, y_vec, z_vec, color = color[:,i:j], linewidth = 3, xlabel = "x", ylabel = "y", zlabel = "z", labels = "", colorbar = false)
end

# ╔═╡ 8133c7e0-03d8-11eb-0697-afe2082ed481
md"""
### 單元 6．Linear Dependence and Linear Independence
"""

# ╔═╡ 82e1b674-03df-11eb-26e4-6f09a0a832d8
let
	with_terminal() do
		A=[1 2 -1; -1 1 -8; 2 -1 13; 1 -1 8] 
		b=[0; 1; -2; 1]
		x=A \ b
		println(x)
		println(A*x)
		println(A*x == b)
	end
end

# ╔═╡ 55de62fc-03e8-11eb-2ade-6500eacc11c8
let
	with_terminal() do
		A=[1 -4 2 -1 2; 2 -8 3 2 1]
		b=[0; 0]
		x=A \b 
		println(x)
		println(A*x)
		println(A*x == b)
	end
end

# ╔═╡ 69edd6d6-0469-11eb-1a3a-69b7f222541c
md"""
## 單元 7．Matrix Multiplication
"""

# ╔═╡ 71418e5a-0469-11eb-1c3a-65f8e802284d
md"""
### Matrix Multiplication
$$Let\;v, x, y ∈ R^n. Suppose\;A\;and\;B\;are\;n × n\;matrices.$$
$$x = Bv$$ 
$$y = Ax$$
$$\Downarrow$$
$$y = Cv = A(Bv) = (AB)v$$
"""

# ╔═╡ c95c00b4-046b-11eb-09e0-69068c23a0e0
let
	with_terminal() do
		A=[1 2; 1 1] 
		B = [ 1 1; 1 -1]
		dump(A * B)
		dump(B * A)
	end
end

# ╔═╡ a7edc48a-046e-11eb-2920-73dd6ab80b73
md"""
## 單元 8．Invertibility and Elmentary Matrices
"""

# ╔═╡ b6f85278-046e-11eb-25db-e71ea510fe6a
md"""
### Inverse
An n × n matrix A is called invertible if there exists an n × n matrix B such
that $$AB = BA = I_n$$. In this case, B is called an inverse of A.
"""

# ╔═╡ c42784e8-0483-11eb-2105-41108f06910e
md"""
$$\begin{matrix}
\begin{align*}
A=\begin{bmatrix} 1 & 2 \\ 3 & 5 \end{bmatrix} 
\\
B=\begin{bmatrix} -5 & 2 \\ 3 & -1 \end{bmatrix}
\end{align*}
&
\Rightarrow 
&
\begin{split}
AB=
\begin{bmatrix} 1 & 2 \\ 3 & 5 \end{bmatrix} 
\begin{bmatrix} -5 & 2 \\ 3 & -1 \end{bmatrix}=\begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}=I_2 
\\
BA=
\begin{bmatrix} -5 & 2 \\ 3 & -1 \end{bmatrix}
\begin{bmatrix} 1 & 2 \\ 3 & 5 \end{bmatrix}=\begin{bmatrix} 1 & 0 \\ 0 & 1\end{bmatrix}=I_2
\end{split}
\end{matrix}$$
"""

# ╔═╡ 6a0af07c-0482-11eb-287b-8d97045e4f36
let 
	with_terminal() do
		A=[1 2; 3 5]
		B=inv(A)
		dump(A)
		dump(B)
		dump(round.(B))
		dump.(round.(A*B))
		dump.(round.(B*A))
	end
end

# ╔═╡ 7cadabce-0483-11eb-1a22-d7fcb40f6fe9
md"""
疑：為什麼只是近似的值？因為 3?
"""

# ╔═╡ 061630b8-0496-11eb-1646-137d406b7c37
md"""
## 單元 9．Column Correspondence Theorem
"""

# ╔═╡ d32ddc0a-0497-11eb-14e8-81331c56ebd8
md"""
實作參考：

[blegat/RowEchelon.jl: Small package containing the rref fonction for computing the reduced row echelon form of the matrix A]
(https://github.com/blegat/RowEchelon.jl) 
> 可做為 module 及 RREF 計算實作參考。
> 提供的 function 為
> rref, rref!
> rref_with_pivots, rref_with_pivots!, 
"""

# ╔═╡ 5f220836-049a-11eb-389c-b75fa5bb21d7
md"""
### Reduced Row Echelon Form (RREF)
"""

# ╔═╡ 86827bfe-049a-11eb-241c-cbbefed2bd08
let
	with_terminal() do
		println("Using RREF:")
		A=[ 1 2 -1 2 1 2; -1 -2 1 2 3 6; 2 4 -3 2 0 3; -3 -6 2 0 3 9]
		dump(A)
		println(Text(A))
		B=rref(A)
		dump(round.(B))
		println(Text(round.(B)))
		
		println("Using \\:")
		A1=A[:, 1:5]
		b1=A[:, 6]
		x=A1 \ b1
		dump(round.(x))
		println(Text(round.(x)))
		println(Text(round.(A1*x)))
		
		println("Using \\ with RREF:")
		A2=B[:, 1:5]
		b2=B[:, 6]
		y=A2 \ b2
		dump(round.(y))
		println(Text(round.(y)))
		println(Text(round.(A2*y)))
	end
end

# ╔═╡ 5db63852-04ac-11eb-09e2-b3a09a28fe5a
md"""
## 單元 10．The Inverse of a Matrix
"""

# ╔═╡ 68240db4-04ac-11eb-3e83-819f3efb8c66
md"""
### Matrix Inversion
"""

# ╔═╡ 2ae45a8a-04b1-11eb-195e-1399a9b27328
md"""
$$\,
\begin{bmatrix} A & I_3 \end{bmatrix}=
\begin{bmatrix}
\begin{array}{ccc|ccc}1 & 2 & 3 & 1 & 0 & 0 \\ 2 & 5 & 6 & 0 & 1 & 0\\ 3 & 4 & 8 & 0 & 0 & 1\end{array}
\end{bmatrix}
\rightarrow
\begin{bmatrix}
\begin{array}{ccc|ccc}1 & 0 & 0 & -16 & 4 & 3 \\ 0 & 1 & 0 & -2 & 1 & 0\\ 0 & 0 & 1 & 7 & -2 & -1\end{array}
\end{bmatrix}
=
\begin{bmatrix} I_3 & B \end{bmatrix}
\,$$
"""

# ╔═╡ 9642ea30-04ac-11eb-0a86-b7d63a7594d7
let
	with_terminal() do
		AI=[ 1 2 3 1 0 0; 2 5 6 0 1 0; 3 4 8 0 0 1]
		println(AI)
		IB=round.(rref(AI))
		println(IB)
		C=IB[:, 4:6]
		println(C)
		D=round.(inv(AI[:, 1:3]))
		println(D)
	end
end

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

[ ] [線性代數 - 臺大開放式課程 (NTU OpenCourseWare)]
(http://ocw.aca.ntu.edu.tw/ntu-ocw/index.php/ocw/cou/102S207/3)

[ ] [Introduction to Applied Linear Algebra – Vectors, Matrices, and Least Squares]
(http://vmls-book.stanford.edu/)
> [Julia language companion](http://vmls-book.stanford.edu/vmls-julia-companion.pdf)

### Julia

[ ] [Introduction to Julia]
(https://juliaacademy.com/courses/enrolled/375479)

> [ ] Advanced topics

[ ] [Julia for Data Science]
(https://juliaacademy.com/courses/enrolled/937702)

[ ] [18.S191 Introduction to Computational Thinking]
(https://computationalthinking.mit.edu/Fall20/)

[Linear Algebra – Quantitative Economics with Julia]
(https://julia.quantecon.org/tools_and_techniques/linear_algebra.html)

> [QuantEcon.cheatsheet/julia-cheatsheet.pdf](https://github.com/QuantEcon/QuantEcon.cheatsheet/blob/master/julia/julia-cheatsheet.pdf)

[cheatsheets/plotsjl-cheatsheet.pdf]
(https://github.com/sswatson/cheatsheets/blob/master/plotsjl-cheatsheet.pdf)

[Unicode Input · The Julia Language]
(https://docs.julialang.org/en/v1/manual/unicode-input/)

[Visualizing Graphs in Julia using Plots and PlotRecipes – Tom Breloff]
(http://www.breloff.com/Graphs/)

### Pluto
[fonsp/Pluto.jl: 🎈 Simple reactive notebooks for Julia]
(https://github.com/fonsp/Pluto.jl)



[Docstrings · PlutoUI.jl]
(https://juliahub.com/docs/PlutoUI/abXFp/0.6.3/autodocs/)

### $$\LaTeX$$

[LaTeX syntax · Documenter.jl]
(https://juliadocs.github.io/Documenter.jl/v0.7/man/latex.html)

[Documentation - Overleaf, Online LaTeX Editor]
(https://www.overleaf.com/learn/latex/Main_Page)

[LaTeX - Mathematical Python]
(https://www.math.ubc.ca/~pwalls/math-python/jupyter/latex/)

[LaTeX help 1.1 - Table of Contents]
(http://www.emerson.emory.edu/services/latex/latex_toc.html)

[List of mathematical symbols - Wikiwand]
(https://www.wikiwand.com/en/List_of_mathematical_symbols)

### Markdown
[Markdown Cheatsheet · adam-p/markdown-here Wiki]
(https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

[Markdown · The Julia Language]
(https://docs.julialang.org/en/v1/stdlib/Markdown/)

### GitHub

[ ] [Hello World · GitHub Guides]
(https://guides.github.com/activities/hello-world/)

### 其他
[三度辭典網 > 術語中英雙語詞典]
(https://www.3du.tw/term/)
"""

# ╔═╡ Cell order:
# ╟─9d9a54ea-ff9c-11ea-1db7-1ba194b9fb3c
# ╟─0053bace-00d4-11eb-1072-cbc1284550c5
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
# ╠═816cc338-03a1-11eb-2872-c7643faab770
# ╠═ee3ed802-03a3-11eb-025c-5bee178511af
# ╟─f7de8296-0393-11eb-0782-57e9272ad999
# ╟─35ec879e-03ae-11eb-15ce-016ae8a89168
# ╠═cfaeab08-03b2-11eb-3930-ddb92e799789
# ╠═0445c5ba-03cb-11eb-2093-b71bae438a19
# ╠═698fc53a-03d5-11eb-39b7-a776fabae2f2
# ╠═408f674e-03d5-11eb-3dc8-ed1addf002be
# ╠═73360416-03da-11eb-1721-cf76aa462151
# ╠═ac04f844-03d8-11eb-2db2-dbc19b343325
# ╟─8133c7e0-03d8-11eb-0697-afe2082ed481
# ╠═82e1b674-03df-11eb-26e4-6f09a0a832d8
# ╠═55de62fc-03e8-11eb-2ade-6500eacc11c8
# ╟─69edd6d6-0469-11eb-1a3a-69b7f222541c
# ╟─71418e5a-0469-11eb-1c3a-65f8e802284d
# ╠═c95c00b4-046b-11eb-09e0-69068c23a0e0
# ╟─a7edc48a-046e-11eb-2920-73dd6ab80b73
# ╟─b6f85278-046e-11eb-25db-e71ea510fe6a
# ╟─c42784e8-0483-11eb-2105-41108f06910e
# ╠═6a0af07c-0482-11eb-287b-8d97045e4f36
# ╟─7cadabce-0483-11eb-1a22-d7fcb40f6fe9
# ╟─061630b8-0496-11eb-1646-137d406b7c37
# ╟─d32ddc0a-0497-11eb-14e8-81331c56ebd8
# ╟─5f220836-049a-11eb-389c-b75fa5bb21d7
# ╠═86827bfe-049a-11eb-241c-cbbefed2bd08
# ╟─5db63852-04ac-11eb-09e2-b3a09a28fe5a
# ╟─68240db4-04ac-11eb-3e83-819f3efb8c66
# ╟─2ae45a8a-04b1-11eb-195e-1399a9b27328
# ╠═9642ea30-04ac-11eb-0a86-b7d63a7594d7
# ╠═97f12ddc-00cf-11eb-173d-47a7931a9a08
# ╟─7dbac3ec-00d1-11eb-2c17-3bab40ffaa2e
# ╠═770ab5ac-fff8-11ea-1ed1-87b0ae3aca70
