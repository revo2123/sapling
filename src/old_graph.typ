// Graphs: undirected, directed, weighted and mixed, with self-loops and parallel edges.
//
// Accepted notations:
//   vertices   "A" or 1                  placed on a circle, first vertex on top, clockwise
//              ("A", 0, 1)               placed at column 0, row 1 (all vertices or none)
//   edges      ("A", "B")                edge
//              ("A", "B", 5)             edge with a weight (any label, such as "2/5")
//              edge("A", "B", 5, bend: 0.5cm)
//                                        same, with extra options
//   Example: graph(("A", "B", "C"), (("A", "B", 3), ("B", "C", 1), ("C", "A", 2)))
//
// Vertices are identified by strings or integers (1 and "1" are the same vertex).
// Use labels: to display something else, such as math.

#import "colors.typ": colors

/// Edge with extra options:
/// directed: overrides the setting of the graph (for mixed graphs),
/// bend:     curves the edge to the left of its direction (length),
/// pos:      position of the weight along the edge (0 = start, 1 = end),
/// angle:    direction of a self-loop (0deg = right, 90deg = down).
#let edge(from, to, ..weight, directed: auto, bend: auto, pos: 0.5, angle: auto) = {
  assert(weight.pos().len() <= 1, message: "edge: at most one weight")
  (
    from: from,
    to: to,
    weight: weight.pos().at(0, default: none),
    directed: directed,
    bend: bend,
    pos: pos,
    angle: angle,
  )
}

/// The edges of a path through the given vertices, e.g. for marked-edges.
#let path-edges(..vertices) = vertices.pos().windows(2)

#let _id(v) = {
  assert(
    type(v) == str or type(v) == int,
    message: "graph: a vertex must be a string or an integer, use labels: to display math",
  )
  str(v)
}

#let _normalize-vertex(v) = {
  if type(v) == array {
    assert(v.len() == 3, message: "graph: a placed vertex is (id, column, row)")
    (id: _id(v.at(0)), x: v.at(1), y: v.at(2))
  } else {
    (id: _id(v), x: none, y: none)
  }
}

#let _normalize-edge(e, directed) = {
  if type(e) == array {
    assert(
      e.len() == 2 or e.len() == 3,
      message: "graph: an edge is (from, to) or (from, to, weight)",
    )
    e = edge(..e)
  }
  assert(
    type(e) == dictionary,
    message: "graph: an edge is (from, to) or (from, to, weight), a single edge needs a trailing comma: ((from, to),)",
  )
  e + (
    from: _id(e.from),
    to: _id(e.to),
    directed: if e.directed == auto { directed } else { e.directed },
  )
}

// Converts the notations into (vertices: (id, x, y), edges: (from, to, weight, ...)).
#let _normalize-graph(vertices, edges, directed) = {
  assert(
    type(vertices) == array and type(edges) == array,
    message: "graph: vertices and edges must be arrays",
  )
  let vs = vertices.map(_normalize-vertex)
  let ids = vs.map(v => v.id)
  assert(ids.dedup().len() == ids.len(), message: "graph: duplicate vertex")
  let es = edges.map(e => _normalize-edge(e, directed))
  for e in es {
    for v in (e.from, e.to) {
      assert(v in ids, message: "graph: edge with unknown vertex " + v)
    }
  }
  (vertices: vs, edges: es)
}

// Grid positions: the given ones, or a circle whose neighbours are one grid unit apart.
#let _positions(vs) = {
  let placed = vs.filter(v => v.x != none).len()
  assert(placed in (0, vs.len()), message: "graph: place all vertices or none")
  if placed > 0 { return vs.map(v => (v.x, v.y)) }
  let n = vs.len()
  let radius = if n < 2 { 0 } else { 0.5 / calc.sin(180deg / n) }
  range(n).map(i => {
    let a = -90deg + i * 360deg / n
    (radius * calc.cos(a), radius * calc.sin(a))
  })
}

// Vector helpers. Points are arrays (x, y), in cm.

// Unit vector from a to b, pointing up if they coincide.
#let _unit(a, b) = {
  let x = b.at(0) - a.at(0)
  let y = b.at(1) - a.at(1)
  let len = calc.sqrt(x * x + y * y)
  if len < 0.001 { (0, -1) } else { (x / len, y / len) }
}

#let _along(p, dir, len) = (p.at(0) + dir.at(0) * len, p.at(1) + dir.at(1) * len)

#let _bezier(s, c1, c2, e, t) = {
  let u = 1 - t
  range(2).map(i => {
    u * u * u * s.at(i) + 3 * u * u * t * c1.at(i) + 3 * u * t * t * c2.at(i) + t * t * t * e.at(i)
  })
}

// Every edge is a cubic curve from the border of one vertex to the border of the other.
// Self-loops leave and return at an angle. Other edges use one control point, so that a
// bend of zero is a straight line. `out` is the direction away from the centre of the graph.
#let _edge-curve(e, p, q, out, r) = {
  let (c1, c2) = if e.from == e.to {
    let a = if e.angle != auto {
      e.angle
    } else {
      calc.atan2(out.at(0), out.at(1)) + e.rank * 70deg
    }
    let control(b) = _along(p, (calc.cos(b), calc.sin(b)), 3.4 * r)
    (control(a - 30deg), control(a + 30deg))
  } else {
    let d = _unit(p, q)
    let mid = ((p.at(0) + q.at(0)) / 2, (p.at(1) + q.at(1)) / 2)
    let c = _along(mid, (d.at(1), -d.at(0)), e.bend)
    (c, c)
  }
  (start: _along(p, _unit(p, c1), r), c1: c1, c2: c2, end: _along(q, _unit(q, c2), r))
}

// Adds to each edge how its parallel edges fan out: bend in cm, and rank for self-loops.
// Antiparallel edges fan out as well, so they stay apart.
#let _fan-out(edges) = {
  let between(a, b) = (a.from == b.from and a.to == b.to) or (a.from == b.to and a.to == b.from)
  edges.enumerate().map(((i, e)) => {
    let same = range(edges.len()).filter(j => between(edges.at(j), e))
    let rank = same.position(j => j == i)
    // measured against the direction of the first edge, the left of a reversed edge is the right
    let side = if e.from == edges.at(same.first()).from { 1 } else { -1 }
    let bend = if e.bend == auto { side * (rank - (same.len() - 1) / 2) } else { e.bend / 1cm }
    e + (bend: bend, rank: rank)
  })
}

// Does the edge e match the edge given as `spec`? Without a weight, spec matches every weight.
#let _matches(e, spec) = {
  let same-way = e.from == spec.from and e.to == spec.to
  let reversed = not e.directed and e.from == spec.to and e.to == spec.from
  (same-way or reversed) and (spec.weight == none or spec.weight == e.weight)
}

// Normalizes a list of vertices and checks that they exist.
#let _vertex-set(list, ids) = {
  assert(type(list) == array, message: "graph: a single vertex needs a trailing comma: (v,)")
  list.map(v => {
    let id = _id(v)
    assert(id in ids, message: "graph: unknown vertex " + id)
    id
  })
}

// Normalizes a list of edges and checks that they exist.
#let _edge-set(list, edges) = {
  assert(type(list) == array, message: "graph: a list of edges must be an array")
  list.map(s => {
    let spec = _normalize-edge(s, false)
    assert(
      edges.any(e => _matches(e, spec)),
      message: "graph: unknown edge " + spec.from + " - " + spec.to,
    )
    spec
  })
}

// Text of a weight or annotation, on white so that lines do not cross it.
#let _tag(body, size, fill, weight: "regular") = box(
  fill: white,
  inset: 1.2pt,
  text(size: size, fill: fill, weight: weight)[#body],
)

/// Draws a graph. directed: true draws every edge as an arrow.
/// marked:        vertices highlighted in red, e.g. the current one
/// visited:       vertices highlighted in blue, e.g. the finished ones
/// groups:        arrays of vertices, each filled in its own colour, e.g. components
/// marked-edges:  edges highlighted in red, e.g. the current one or a path
/// visited-edges: edges highlighted in blue, e.g. a spanning tree
/// faded-edges:   edges dashed in grey, e.g. rejected ones
/// extra:         annotations per vertex, e.g. (A: "0", B: $infinity$)
/// labels:        displayed text per vertex, e.g. (a: $v_1$)
/// dx, dy:        size of a grid unit, which is also the spacing of the circle
#let graph(
  vertices,
  edges,
  directed: false,
  marked: (),
  visited: (),
  groups: (),
  marked-edges: (),
  visited-edges: (),
  faded-edges: (),
  extra: (:),
  labels: (:),
  dx: 1.6cm,
  dy: 1.6cm,
  r: 0.3cm,
  font-size: 9pt,
) = {
  let g = _normalize-graph(vertices, edges, directed)
  let ids = g.vertices.map(v => v.id)

  let is-marked = _vertex-set(marked, ids)
  let is-visited = _vertex-set(visited, ids)
  assert(type(groups) == array, message: "graph: groups must be an array of arrays")
  let group-sets = groups.map(group => _vertex-set(group, ids))
  for key in extra.keys() + labels.keys() {
    assert(key in ids, message: "graph: unknown vertex " + key)
  }
  let edge-marked = _edge-set(marked-edges, g.edges)
  let edge-visited = _edge-set(visited-edges, g.edges)
  let edge-faded = _edge-set(faded-edges, g.edges)

  if ids.len() == 0 { return align(center, text(size: font-size)[∅]) }

  // all internal measurements are plain numbers in cm
  let rf = r / 1cm
  let pos = _positions(g.vertices).map(p => (p.at(0) * dx / 1cm, p.at(1) * dy / 1cm))
  let pos-of(id) = pos.at(ids.position(i => i == id))
  let centre = range(2).map(i => pos.map(p => p.at(i)).sum() / pos.len())

  let es = _fan-out(g.edges).map(e => {
    // layer: the highlighted edges are drawn on top
    let (layer, color, thickness, dash) = if edge-marked.any(s => _matches(e, s)) {
      (3, colors.warn, 1.3pt, "solid")
    } else if edge-visited.any(s => _matches(e, s)) {
      (2, colors.visited, 1.3pt, "solid")
    } else if edge-faded.any(s => _matches(e, s)) {
      (0, colors.faded, 0.6pt, "dashed")
    } else {
      (1, colors.border, 0.6pt, "solid")
    }
    let p = pos-of(e.from)
    let path = _edge-curve(e, p, pos-of(e.to), _unit(centre, p), rf)
    e + (layer: layer, color: color, thickness: thickness, dash: dash, path: path)
  })

  context {
    // boxes reserve the space of everything drawn: (x, y, half width, half height)
    let boxes = ()
    for p in pos { boxes.push((p.at(0), p.at(1), rf, rf)) }

    let tags = ()
    for e in es {
      let c = e.path
      for t in (0.25, 0.5, 0.75) {
        boxes.push(_bezier(c.start, c.c1, c.c2, c.end, t) + (0, 0))
      }
      if e.weight != none {
        let body = _tag(e.weight, 8pt, e.color)
        let size = measure(body)
        let at = _bezier(c.start, c.c1, c.c2, c.end, e.pos)
        boxes.push(at + (size.width / 2cm, size.height / 2cm))
        tags.push((body: body, at: at))
      }
    }
    for (key, value) in extra {
      let p = pos-of(key)
      let out = _unit(centre, p)
      // a self-loop with its weight reaches about 2.6 radii + 0.25cm beyond the centre
      let has-loop = es.any(e => e.from == key and e.to == key)
      let reach = if has-loop { 2.6 * rf + 0.25 } else { rf }
      let body = _tag(value, 8pt, colors.warn, weight: "bold")
      let size = measure(body)
      let (w, h) = (size.width / 2cm, size.height / 2cm)
      // pushed out by the extent of the text in this direction, so that it never touches the vertex
      let at = _along(p, out, reach + calc.abs(out.at(0)) * w + calc.abs(out.at(1)) * h)
      boxes.push(at + (w, h))
      tags.push((body: body, at: at))
    }

    let pad = 0.1
    let min-x = calc.min(..boxes.map(b => b.at(0) - b.at(2))) - pad
    let min-y = calc.min(..boxes.map(b => b.at(1) - b.at(3))) - pad
    let max-x = calc.max(..boxes.map(b => b.at(0) + b.at(2))) + pad
    let max-y = calc.max(..boxes.map(b => b.at(1) + b.at(3))) + pad
    let point(p) = ((p.at(0) - min-x) * 1cm, (p.at(1) - min-y) * 1cm)

    align(center, block(
      width: (max-x - min-x) * 1cm,
      height: (max-y - min-y) * 1cm,
      breakable: false,
      {
        for e in es.sorted(key: e => e.layer) {
          let c = e.path
          let head = 0.17
          let dir = _unit(c.c2, c.end)
          // an arrow stops the line just inside of its head
          let end = if e.directed { _along(c.end, dir, -0.8 * head) } else { c.end }
          place(top + left, curve(
            stroke: (paint: e.color, thickness: e.thickness, dash: e.dash),
            curve.move(point(c.start)),
            curve.cubic(point(c.c1), point(c.c2), point(end)),
          ))
          if e.directed {
            let base = _along(c.end, dir, -head)
            let wing(side) = _along(base, (dir.at(1), -dir.at(0)), side * 0.45 * head)
            place(top + left, polygon(
              fill: e.color,
              stroke: none,
              point(c.end),
              point(wing(1)),
              point(wing(-1)),
            ))
          }
        }
        for tag in tags {
          let (x, y) = point(tag.at)
          let size = measure(tag.body)
          place(top + left, dx: x - size.width / 2, dy: y - size.height / 2, tag.body)
        }
        for (i, id) in ids.enumerate() {
          let (x, y) = point(pos.at(i))
          let group = group-sets.position(group => id in group)
          let fill = if group != none {
            colors.groups.at(calc.rem(group, colors.groups.len()))
          } else if id in is-visited {
            colors.visited-fill
          } else {
            colors.fill
          }
          let stroke = if id in is-marked {
            1.3pt + colors.warn
          } else if id in is-visited {
            1.3pt + colors.visited
          } else {
            0.7pt + colors.border
          }
          place(top + left, dx: x - r, dy: y - r, circle(
            radius: r, inset: 0pt, fill: fill, stroke: stroke,
            align(center + horizon, text(size: font-size)[#labels.at(id, default: id)]),
          ))
        }
      },
    ))
  }
}

// The neighbours of a vertex with the weights of the connecting edges, in the order of the edges.
#let _neighbours(id, edges) = {
  let found = ()
  for e in edges {
    if e.from == id {
      found.push((id: e.to, weight: e.weight))
    } else if e.to == id and not e.directed {
      found.push((id: e.from, weight: e.weight))
    }
  }
  found
}

/// Draws the adjacency matrix of a graph. A cell shows the weight of the edge, or 1 if
/// it has none. empty: the content of the other cells, e.g. $infinity$ for weighted graphs.
#let adjacency-matrix(vertices, edges, directed: false, labels: (:), empty: 0, font-size: 9pt) = {
  let g = _normalize-graph(vertices, edges, directed)
  let ids = g.vertices.map(v => v.id)
  let name(id) = strong[#labels.at(id, default: id)]
  let cell(from, to) = {
    let found = _neighbours(from, g.edges).filter(n => n.id == to)
    if found.len() == 0 {
      [#empty]
    } else {
      found.map(n => if n.weight == none { [1] } else { [#n.weight] }).join(", ")
    }
  }
  align(center, text(size: font-size, table(
    columns: (auto,) * (ids.len() + 1),
    align: center + horizon,
    stroke: 0.6pt + colors.border,
    fill: (x, y) => if x == 0 or y == 0 { colors.fill },
    [],
    ..ids.map(name),
    ..ids.map(from => (name(from), ..ids.map(to => cell(from, to)))).flatten(),
  )))
}

/// Draws the adjacency list of a graph: each vertex followed by its neighbours,
/// shown as "neighbour,weight" for weighted edges.
#let adjacency-list(vertices, edges, directed: false, labels: (:), font-size: 9pt) = {
  let g = _normalize-graph(vertices, edges, directed)
  let name(id) = labels.at(id, default: id)
  let box-of(body) = box(
    stroke: 0.6pt + colors.border,
    fill: colors.fill,
    inset: (x: 4pt, y: 3pt),
    body,
  )
  let neighbour(n) = if n.weight == none {
    box-of[#name(n.id)]
  } else {
    box-of[#name(n.id)#text(fill: colors.priority)[,#n.weight]]
  }
  align(center, text(size: font-size, grid(
    columns: (auto, auto),
    column-gutter: 8pt,
    row-gutter: 4pt,
    align: left + horizon,
    ..g.vertices.map(v => (
      box-of(strong[#name(v.id)]),
      _neighbours(v.id, g.edges).map(neighbour).join[ → ],
    )).flatten(),
  )))
}
