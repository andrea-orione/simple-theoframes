// LTeX: language=it-IT

// The general box
#let general-block(
  title,
  title-left-overhang: 0.7em,
  line-size: 1.2pt,
  main-col: black,
  bottom-line-lenght: 1.5em,
  title-contour: "underline",
  breakable: true,
  content-inset:(x: 1em, top: 0.8em, bottom: 1em),
  body
) = {
  let title-color = if type(main-col) == dictionary {main-col.title} else {main-col}
  let lines-color = if type(main-col) == dictionary {main-col.lines} else {main-col}

  let line-stroke = line-size + lines-color
  let title-stroke = if title-contour == "underline" {(bottom: line-stroke)}
    else if title-contour == "box" {line-stroke}
    else if title-contour == "angle" {(bottom: line-stroke, right: line-stroke)}

  let title-rect = rect(
    inset: (x: title-left-overhang),
    stroke: title-stroke,
    text(title-color, title)
  )

  let title-block = place(
    top+left,
    dx: -title-left-overhang,
    float: true,
    clearance: 0pt,
    title-rect
  )

  let content-block = block(
    stroke: (left: line-stroke),
    breakable: breakable,
    inset: content-inset,
    body
  )

  let bottom-line = place(
    bottom + left,
    dx: -0.5*line-size,
    line(length: bottom-line-lenght, stroke: line-stroke)
  )

  block(inset: (left: line-size))[
    #title-block
    #content-block
    #bottom-line
  ]
}

// Theorem
#let theo-counter = counter("theorem")
#let std-theo-num() = context {
  let chapter-counter = counter(heading)
  let max-chapter-count = chapter-counter.final().first()
  if max-chapter-count == 0 {
    numbering("1", theo-counter.get().first())
  } else {
    let chapter-count = chapter-counter.get().first()
    numbering("1.1", chapter-count, theo-counter.get().first())
  }
}
#let theorem(pre-title: "Theorem", numbering: std-theo-num, title: "", body) = {
  let separtator = if title != "" { ": " } else { "" }
  let all-title = if numbering != false {
    theo-counter.step()
    [*#pre-title #context numbering()#separtator#title*]
  } else {
    [*#pre-title#separator#title*]
  }

  let col = rgb("#CC4700")
  general-block(
    all-title,
    main-col: col,
    body
  )
}

// Observation
#let observation(title: "Observation", body) = {
  let col = rgb("#008000")
  general-block(
    [*#title*],
    main-col: col,
    body
  )
}

// Def
#let def-counter = counter("definition")
#let std-def-num() = context {
  let chapter-counter = counter(heading)
  let max-chapter-count = chapter-counter.final().first()
  if max-chapter-count == 0 {
    numbering("1", def-counter.get().first())
  } else {
    let chapter-count = chapter-counter.get().first()
    numbering("1.1", chapter-count, def-counter.get().first())
  }
}
#let definition(pre-title: "Definition", numbering: std-def-num, title: "", body) = {
  let separtator = if title != "" { ": " } else { "" }
  let all-title = if numbering != false {
    def-counter.step()
    [*#pre-title #context numbering()#separtator#title*]
  } else {
    [*#pre-title#separator#title*]
  }

  let col = rgb("#0000CC")
  general-block(
    all-title,
    main-col: col,
    body
  )
}

// Exercise
#let exe-counter = counter("exercise")
#let std-exe-num() = context {
  let chapter-counter = counter(heading)
  let max-chapter-count = chapter-counter.final().first()
  if max-chapter-count == 0 {
    numbering("1", exe-counter.get().first())
  } else {
    let chapter-count = chapter-counter.get().first()
    numbering("1.1", chapter-count, exe-counter.get().first())
  }
}
#let exercise(pre-title: "Exercise", numbering: std-exe-num, title: "", body) = {
  let separtator = if title != "" { ": " } else { "" }
  let all-title = if numbering != false {
    exe-counter.step()
    [*#pre-title #context numbering()#separtator#title*]
  } else {
    [*#pre-title#separator#title*]
  }

  let col = rgb("#008877")
  general-block(
    all-title,
    main-col: col,
    body
  )
}

// Some usefull aliases
#let law = theorem.with(pre-title: "Law")
#let obs = observation.with(title: "Obs.")
#let def = definition.with(title: "Def.")
