# library(sand)
# install_sand_packages()

## Eso no nos funcionó, así que iremos instalando y cargando los paquetes uno en uno
library(igraph)
library(igraphdata)

### La función del libro
g2 <- graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 
                    4-6, 4-7, 5-6, 6-7)

### La función que usan en el github
g <- graph_from_literal(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 
                        4-6, 4-7, 5-6, 6-7)

g3 <- graph_from_literal(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 
                        4-6, 4-7, 5-6, 6-7)

V(g)
E(g)

### Los objetos no son iguales
identical(g, g2)
# [1] FALSE

### str despliega la lista de todos los nodos pero intenta desplegar uno más 
### y genera un error
str(g)
# $ :Error in adjacent_vertices(x, i, mode = if (directed) "out" else "all") : 
#   At iterators.c:759 : Cannot create iterator, invalid vertex id, Invalid vertex id

## Lista de adyacencia
print_all(g)

plot(g)
plot(g2)

dg <- graph_from_literal(1-+2, 1-+3, 2++3)
plot(dg)

dg <- graph_from_literal(Sam-+Mary, Sam-+Tom, Mary++Tom)
## No funciona: Sam--Mary, Sam-Mary
## No marca error pero no se genera la arista

print_all(dg)
## IGRAPH 7f46b81 DN-- 3 4 --  
## DN: directed

plot(dg)

### Sigue generando el error del iterador
str(dg)

V(dg)$name <- c("Sam", "Mary", "Tom")
vertices <- V(dg)
edges <- E(dg)

#### Esto no funciona
g3 <- get.adjacency(g)
g4 <- graph.adjlist(g3)

### Forma correcta de pasar a lista de adyacencia y de crear una gráfica desde una lista de adyacencia
g3 <- as_adj_list(g)
g4 <- graph_from_adj_list(g3)

### Forma correcta de pasar a matriz de adyacencia y de crear una gráfica desde una matriz de adyacencia
g5 <- as_adjacency_matrix(g)
g6 <- graph_from_adjacency_matrix(g5)

### Usamos como ejemplo la red del Zachary's karate club network
data("karate")
plot(karate)
print_all(karate)
### IGRAPH 4b458a1 UNW- 34 78 -- Zachary's karate club network
### UNW Es undirected y weighted

### Esta es solo la lista de aristas 
E(karate)
## Aquí sí vemos los pesos y otros atributos de las aristas
as_data_frame(karate, what = "edges")
E(karate)$weight

## Esta función no genera error, así que probablemente es solo la implementación cuando
## se usa una red que se construye a partir de una literal
str(karate)

### Atributos en los vértices
as_data_frame(karate, what = "vertices")
V(karate)
V(karate)$label

### Matriz de adyacencia. Dos funciones para obtenerla
identical(as_adjacency_matrix(karate), as_adj(karate))
# [1] TRUE

### Aristas adyacentes
as_adj_edge_list(karate)
### Vertices vecinos
as_adj_list(karate)
## Estas no son iguales. Una regresa aristas, la otra vértices
identical(as_adj_edge_list(karate), as_adj_list(karate))
# [1] FALSE

## Cambiamos el color de los vértices solo modificando el atributo color
V(karate)$color = ifelse(V(karate)$color == 1, 3, 4)
plot(karate)

## También funciona con nombres de colores
V(karate)$color = ifelse(V(karate)$color == 3, "blue", "black")
plot(karate)
