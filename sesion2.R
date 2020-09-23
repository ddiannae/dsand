library(igraph)

## de la sesión anterior
g <- graph_from_literal(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 
                        4-6, 4-7, 5-6, 6-7)
h <- induced_subgraph(g, 1:5)
print_all(h)

h2 <- g - vertices(c(6,7))

identical_graphs(h, h2)
## [1] TRUE

h2 <- h2 + vertices(c(6,7))
plot(h2)
g2 <- h2 + edges(c(4,6),c(4,7),c(5,6),c(6,7))

identical_graphs(g, g2) 
## [1] FALSE
## queeeeee??? Si tomamos una subgráfica y restamos o calculamos la 
## subgráfica inducida por algunos vértices, el resultado sí es igual. 
## Si añadimos vértices, las gráficas no son iguales :/

plot(g)
plot(g2)

print_all(g)
# IGRAPH bb9d007 UN-- 7 10 -- 
#   + attr: name (v/c)
# + edges (vertex names):
# 1 -- 2, 3
# 2 -- 1, 3, 4
# 3 -- 1, 2, 5
# 4 -- 2, 5, 6, 7
# 5 -- 3, 4, 6
# 6 -- 4, 5, 7
# 7 -- 4, 6

print_all(g2)
# IGRAPH 66831a0 UN-- 7 10 -- 
#   + attr: name (v/c)
# + edges (vertex names):
# 1 -- 2, 3
# 2 -- 1, 3, 4
# 3 -- 1, 2, 5
# 4 -- 2, 5, 6, 7
# 5 -- 3, 4, 6
# 6 -- 4, 5, 7
# 7 -- 4, 6
g2 - g
## vacío
g - g2
## vacío
difference(g2, g)
## vacío
difference(g, g2)
## vacío

### Intentemos otra cosa
h1 <- h
h2 <- graph_from_literal(4-6, 4-7, 5-6, 6-7)
g3 <- union(h1,h2)
identical_graphs(g, g3)
## [1] FALSE
identical_graphs(g2, g3)
## [1] FALSE
## No. Esto necesita más investigación


dg <- graph_from_literal(Sam-+Mary, Sam-+Tom, 
                         Mary++Tom)
V(dg)$name
V(dg)$gender <- c("M", "F", "M")

V(dg)$color <- c("red", "blue", "green")
V(dg)$color <- c("red", "blue", "green")
V(dg)$color <- ifelse(V(dg)$gender == "M", "blue", "pink")

is_weighted(g)

wg <- g
E(wg)$weight <- runif(ecount(wg))
is_weighted(wg)

print_all(wg)
## atributos: nombre (v o e/tipo de dato)

library(sand)
### para importar el data frame de lazega
g.lazega <- graph_from_data_frame(elist.lazega,
                                  directed="FALSE",
                                  vertices=v.attr.lazega)
g.lazega$name <- "Lazega Lawyers"

vcount(g.lazega)
ecount(g.lazega)

### Otra forma de obtener el número de aristas y vértices
length(E(g.lazega))
length(V(g.lazega))

### La info del data frame
head(elist.lazega)
head(v.attr.lazega)

### Los atributos 
vertex_attr_names(g.lazega)
edge_attr_names(g.lazega)

is_simple(g)
## [1] TRUE
mg <- g + edge(2,3)
print_all(mg)

is_simple(mg)
## [1] FALSE
E(mg)$weight <- 1
wg2 <- simplify(mg)
is_simple(wg2)

neighbors(g,5)

dgr <- degree(g)
names(dgr)

degree(dg, mode = "in")
degree(dg, mode = "out")

is_connected(g)
clusters(g)
 g <- g + vertex(8)
 
 
is.connected(dg, mode="weak")
plot(dg)

diameter(g, weights=NA)

g.full <- make_full_graph(7)
g.ring <- make_ring(7)
g.tree <- make_tree(7, children=2, mode="undirected")
g.star <- make_star(7, mode="undirected")
par(mfrow=c(2, 2), mai = c(0.2, 0.2, 0.2, 0.2))
plot(g.full)
plot(g.ring)
plot(g.tree)
plot(g.star)


is_dag(dg)
## [1] FALSE

g.bip <- graph_from_literal(actor1:actor2:actor3,
                            movie1:movie2, actor1:actor2 - movie1,
                            actor2:actor3 - movie2)
V(g.bip)$type <- grepl("^movie", V(g.bip)$name)
print_all(g.bip, v=T)
## La B por bipartita
# IGRAPH 03c5caf UN-B 5 4 -- 
#   + attr: name (v/c), type (v/l)
# + vertex attributes:
#   |       name  type
# | [1] actor1 FALSE
# | [2] actor2 FALSE
# | [3] actor3 FALSE
# | [4] movie1  TRUE
# | [5] movie2  TRUE
# + edges from 03c5caf (vertex names):
#   [1] actor1--movie1 actor2--movie1 actor2--movie2 actor3--movie2

proj <- bipartite_projection(g.bip)
print_all(proj[[1]])
print_all(proj[[2]])
plot(g.bip, layout= layout.bipartite(g.bip))

