
// following part is generated via claude-sonnet 4.5:

// Neural Network Drawing Macro for Typst
// Usage: #neural-net(layers: (3, 4, 2), weights: true, ...)

#let neural-net(
  layers: (3, 4, 2),           // Number of neurons in each layer
  neuron-radius: 8pt,          // Radius of neuron circles
  layer-spacing: 80pt,         // Horizontal spacing between layers
  neuron-spacing: 30pt,        // Vertical spacing between neurons
  neuron-fill: white,          // Fill color for neurons
  neuron-stroke: 1pt + black,  // Stroke for neuron circles
  connection-stroke: 0.5pt + gray, // Stroke for connections
  show-weights: false,         // Whether to show weight labels
  weights: none,               // Optional weight matrix array
  weight-decimals: 2,          // Decimal places for weights
  weight-size: 6pt,            // Font size for weight labels
  weight-color: blue,
  label-layers: false,         // Whether to show layer labels
  layer-names: none,           // Custom layer names array
) = {
  
  // Calculate total width and height
  let total-width = (layers.len() - 1) * layer-spacing
  let max-neurons = calc.max(..layers)
  let total-height = (max-neurons - 1) * neuron-spacing
  
  // Create the neural network diagram
  box(
    width: total-width + 2 * neuron-radius + 20pt,
    height: total-height + 2 * neuron-radius + 40pt,
  )[
    #place(
      dx: neuron-radius + 10pt,
      dy: neuron-radius + 20pt,
    )[
      // Draw connections first (so they appear behind neurons)
      #for l in range(layers.len() - 1) {
        let curr-layer = layers.at(l)
        let next-layer = layers.at(l + 1)
        
        // Calculate vertical centering offsets
        let curr-offset = (max-neurons - curr-layer) * neuron-spacing / 2
        let next-offset = (max-neurons - next-layer) * neuron-spacing / 2
        
        for i in range(curr-layer) {
          for j in range(next-layer) {
            let start-x = l * layer-spacing
            let start-y = curr-offset + i * neuron-spacing
            let end-x = (l + 1) * layer-spacing
            let end-y = next-offset + j * neuron-spacing
            
            // Draw connection line
            place(
              dx: start-x,
              dy: start-y,
            )[
              #line(
                start: (0pt, 0pt),
                end: (end-x - start-x, end-y - start-y),
                stroke: connection-stroke,
              )
            ]
            
            // Draw weight label if requested
            if show-weights and weights != none {
              if l < weights.len() and i < weights.at(l).len() and j < weights.at(l).at(i).len() {
                let w = weights.at(l).at(i).at(j)
                let mid-x = (start-x + end-x) / 2
                let mid-y = (start-y + end-y) / 2
                
                place(
                  dx: mid-x - 8pt,
                  dy: mid-y - 4pt,
                )[
                  #text(size: weight-size, fill: weight-color)[
                    #box(fill: white.transparentize(20%), inset: 1pt, radius: 2pt)[
                      #calc.round(w, digits: weight-decimals)
                    ]
                  ]
                ]
              }
            }
          }
        }
      }
      
      // Draw neurons on top
      #for (l, layer-size) in layers.enumerate() {
        let layer-offset = (max-neurons - layer-size) * neuron-spacing / 2
        
        for i in range(layer-size) {
          let x = l * layer-spacing
          let y = layer-offset + i * neuron-spacing
          
          place(
            dx: x - neuron-radius,
            dy: y - neuron-radius,
          )[
            #circle(
              radius: neuron-radius,
              fill: neuron-fill,
              stroke: neuron-stroke,
            )
          ]
        }
        
        // Draw layer label if requested
        if label-layers {
          let label = if layer-names != none and l < layer-names.len() {
            layer-names.at(l)
          } else if l == 0 {
            "Input"
          } else if l == layers.len() - 1 {
            "Output"
          } else {
            "Hidden " + str(l)
          }
          
          place(
            dx: l * layer-spacing - 15pt,
            dy: total-height + neuron-radius + 5pt,
          )[
            #text(size: 8pt, weight: "bold")[#label]
          ]
        }
      }
    ]
  ]
}

// Example 1: Simple neural network
// #neural-net(
//   layers: (3, 4, 2),
//   label-layers: true,
// )

// Example 2: With custom styling
// #neural-net(
//   layers: (4, 6, 6, 3),
//   neuron-fill: blue.lighten(80%),
//   neuron-stroke: 2pt + blue,
//   connection-stroke: 0.3pt + blue.lighten(40%),
//   layer-spacing: 100pt,
//   label-layers: true,
//   layer-names: ("Input", "Hidden 1", "Hidden 2", "Output"),
// )

// // Example 3: With weights displayed
// #neural-net(
//   layers: (2, 3, 1),
//   show-weights: true,
//   weights: (
//     // Weights from layer 0 to layer 1
//     (
//       (0.5, -0.3, 0.8),   // From neuron 0 to all neurons in next layer
//       (0.2, 0.9, -0.4),   // From neuron 1 to all neurons in next layer
//     ),
//     // Weights from layer 1 to layer 2
//     (
//       (0.6,),             // From neuron 0 to all neurons in next layer
//       (-0.7,),            // From neuron 1 to all neurons in next layer
//       (0.3,),             // From neuron 2 to all neurons in next layer
//     ),
//   ),
//   neuron-radius: 10pt,
//   layer-spacing: 90pt,
//   label-layers: true,
// )