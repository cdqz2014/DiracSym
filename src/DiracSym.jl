module DiracSym

using Base: Symbol
using SymbolicUtils: Sym, Symbolic
# add a method for vacancy type and String type
Sym(x) = Sym{Real}(x)
Sym(x::String) = Sym{Real}(Symbol(x))

abstract type FockSpace{T} <: Symbolic{T} end
abstract type FockSpaceDual{T} <: Symbolic{T} end

abstract type HilbertSpace{T} <: Symbolic{T} end
abstract type HilbertSpaceDual{T} <: Symbolic{T} end

#####################################################################
###################### Single-particle States #######################
#####################################################################
struct ket{T} <: HilbertSpace{T}
	name::Symbol
end
struct bra{T} <: HilbertSpaceDual{T}
	name::Symbol
end
"Realization if instances"

ket(x::Symbol) = ket{Real}(x) # for other types like Type{String} and Type{Symbol}
ket(x::String) = ket{Real}(Symbol(x)) # for other types like Type{String} and Type{Symbol}
bra(x::Symbol) = bra{Real}(x) # for other types like Type{String} and Type{Symbol}
bra(x::String) = bra{Real}(Symbol(x)) # for other types like Type{String} and Type{Symbol}


"Add methods for recognizing symbolic states"
Base.isequal(x::ket, y::ket) = (x.name == y.name) # isequal(,) is similar to Base.(==)(,)
Base.isequal(x::bra, y::bra) = (x.name == y.name) # isequal(,) is similar to Base.(==)(,)


#####################################################################
################ Promotion Rules and Type Convertion ################
#####################################################################
"add methods for conjugate of Ket and Bra"
conj(x::ket) = bra(x.name)
conj(x::bra) = ket(x.name)

"Change the show methods for Type{ket} (default looks like `ket(x)`; here we now display with Dirac notation" 
function Base.show(io::IO, x::ket)
	str = "|$(x.name)⟩"
	print(io, str)
end
function Base.show(io::IO, x::bra)
	str = "⟨$(x.name)|"
	print(io, str)
end


#####################################################################
########################## Tests Start Here #########################
#####################################################################

psi = ket(:psi)
phi = ket(:phi)
println(pi*psi+im*psi+3*phi)


end # module
