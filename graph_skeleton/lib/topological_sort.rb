require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# KAHN'S
def topological_sort(vertices)
  top_level = find_tops(vertices)
  sorted = []

  until top_level.empty?
    current = top_level.shift
    sorted << current

    current.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      edge.destroy!
      top_level << to_vertex if to_vertex.in_edges.empty?
    end
  end

  sorted
end

# TARJAN

def tarjan_sort(vertices)

end

def dfs!(vertex, explored, ordering)

end

private
def find_tops(vertices)
  tops = []

  vertices.each do |vertex|
    tops << vertex unless vertex.in_edges
  end
end

def delete_edge(current, dest_node)
  current.out_edges.each do |edge|
    edge.destroy! if edge.to_vertex == dest_node
  end
end
