#import "@preview/charged-ieee:0.1.4": ieee
#import "@preview/wrap-it:0.1.1": wrap-content
#import "nn.typ": neural-net, cnn-net

#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure

#import "@preview/commute:0.3.0": node, arr, commutative-diagram

// #import "@preview/catppuccin:1.0.1": catppuccin, flavors
// #show: catppuccin.with(flavors.frappe)


#show: ieee.with(
  title: [Secure Transmission in Wireless Semantic Communications With Adversarial Training],
  abstract: [
    The Burgeoning technology of deep learning based semantic communications has significantly enhanced the efficiency and reliability of wireless communication systems by facilitating the transmission of semantic features. However, security threats, notably the interception of sensitive data, remain a sigfnificant challenge for secure communications. To safeguard the confidentiality of transmitted sematics and effectively counteract eavesdropping threats, this letter propose a secure deep learning-based semantic communication system, SecureDSC. It comprises semantic encoder/decoder, channel encoder/decoder, and encryption/decryption modules with a key processing network.
  ],
  authors: (
    (
      name: "Muhammed Yasinhan Yaşar",
      department: [Computer Science],
      organization: [Ankara Yıldırım Beyazıt University],
      location: [Ankara, Turkey],
      email: "myyasar2001@gmail.com"
    ),
  ),
  index-terms: ("Semantic communications", "symmetric encryption", "secure transmission"),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)


#let lettrine(term)=text(size:28pt,box[#term], baseline: -0.5pt)

#let IntroText1 = [
  EEP learning-based semantic communications have attracted much attention due to the focus on transmisson and interaction at the smeantic level @qin2022semanticcommunicationsprincipleschallenges_1. Compared to traditional communication systems, sematic communications achieve higher transmission efficiency and lower bandwith with less susceptible to noise or other interference @DeepLearningEnabledSemanticCommunicationSystems_2. Nevertheless, the inherent openness and accessibility of wireless channels present a significant security risk to extracted semantic features transmitted in plaintext, enabling eavesdropping attacks and resulting in the disclosure of sensitive information. With the development of  semantic communications, ensuring secure transmission is crucial for fostering trustworthy interactions within semantic communication systems and reliable evolution of wireless communication technologies.
]

= Introduction
#wrap-content(
  lettrine[*D*],
  IntroText1,
  align: left,
  column-gutter: 0.25em,
)
#v(1em)
#text(
  [Thanks for Muhammed Yasinhan Yaşar for their helps and contributions #lorem(40)],
  size: 0.8em
)

#set figure.caption(position: bottom)
#show figure.caption: set align(center)

#figure(
  neural-net(
    layers: (2, 3, 1),
    show-weights: true,
    weights: (
      (
        (0.1, -0.3, 0.8),
        (0.2, 0.9, -0.4),
      ),
      (
        (0.6,),
        (-0.7,),
        (0.3,),
      ),
    ),
    weight-color: black,
    neuron-radius: 10pt,
    layer-spacing: 75pt,
    label-layers: true,
  ),
  caption: [The model of proposed secure text semantic communication system.],
) <CNN>


#let mtb(x) = $upright(bold(#x))$

= System Model
As shown in @CNN, Alice sends a message #mtb("m") to the legitimate receiver Bob, and both of them use the same shared session key #mtb("k") for encryption and decryption. The eavesdropping attacker Eve aims to reconstruct the original information communicated between legitimate users. As a black-box attacker, Eve lacks the knowledge of specific parameters used in the models employed by Alice and Bob. However, it can eavesdrop and analyze messages transmitted within the channel and leverage a large number of input-output pairs to invert the original network for private information.

Without loss of generality, we take the example of transmitting a text message i.e., $mtb(m) = [w_1, w_2, ..., w_L]$ where $w_l$ denotes the $l^"th"$ word in the sentence. At the sender end, the message passes through a semantic encoder to obtain  a semantic feature #mtb("f"), then #mtb("f") is input into a cipher encoder to generate ciphertext #mtb("c"), and #mtb("c") is converted into asymbol stream #mtb("x") using a channel encoder, which is expressed as

$
  upright(bold(x)) = C e_gamma (E n_beta (S e_alpha (mtb(m)), K_kappa (mtb(k)))),
$\
where $S e_alpha (circle.filled.tiny)$ is the semantic encoder network with parameter set $mtb(alpha)$, $E n_beta (circle.filled.tiny)$ is the encrypt network with parameter set $beta$, $C e_gamma (circle.filled.tiny)$ is the channel encoder network with parameter set $gamma$ and $K_kappa (circle.filled.tiny)$ is key processing network with parameter set $kappa$.\

As a legitimate receiver, Bob receives the signal $hat(bold("y"))$ with the interference and noise which is represented as
$ hat(bold("y")) = h bold("x") + bold("n") , $\
where $h$ is the channel coefficient assumed to be constant for a quasi-static channel, and $bold("n")$ is the additive white Gaussian noise (AWGN) with a mean of zero and a variance $sigma^2_n$. With the support of channel, chiper and semantic decoders, $hat(bold("y"))$ is decoded to reconstruct the original message as
$
  hat(bold("m")) = S d_(bold(theta)) ( D e_(bold(delta)) (C d_(bold(chi)) (hat(bold("y"))), K_(bold(kappa)) (bold("k")))),
$\
in which $S d_(bold(theta)) (circle.filled.tiny)$ is the semantic decoder network with parameter set $bold(theta)$, $D e_(bold(delta)) (circle.filled.tiny)$ is the decrypt network with parameter set $bold(delta)$ and $C d_(bold(chi)) (circle.filled.tiny)$ is the channel decoder network with parameter set $bold(chi)$. Moreover, it is straightforward that Alice and Bob utilize the same key processing network $K_(bold(kappa)) (circle.filled.tiny)$ to obtain the same session key in the symmetric  encryption.

The attacker Eve eavesdrops on the open wireless channel, intercepting the transmitted signal $macron(bold("y"))$. As the session key $bold("k")$ secretly shared between legitimate users is inaccessible, Eve replaces it with a random number $bold("r")$ to reconstruct the original message as
$
  macron(bold("m")) = S d_(dash(bold(theta))) (D e_(dash(bold(delta))) (C d_(dash(bold(chi))) (hat(bold("y"))), bold("r"))).
$\
It is noteworthy that despite the similar network structure between Bob and Eve, the parameter sets differ due to Eve's absence from the joint training between Alice and Bob.

= Proposed SecreDSC System

This section presents the basic model of the proposed semantic communication system SecureDSC, including the composition of the network layers and the procedures of encryption and decryption. We then  discuss the design of loss function and the adversarial training process that provides the confidentiality protection of transmitted messages.

== Basic Model

@CNN2 illustrates the whole sturcture of the neural network. Tje embeding layer first performs a transformation on the input message $bold("M")$, mapping it to a dense vector representation. Then, the semantic encoder $S e_(bold(alpha))(circle.filled.tiny)$ extracts semantic features from the embedded input. Subsequently, extracted features $bold("F")$ and keys $bold("K")$ serve as inputs for the encryptor $E n_(beta)(circle.filled.tiny)$ to generate the ciphertext $bold("C")$. Before being transmitted over the channel, the ciphertext is input into the channel encoder $C e_gamma(circle.filled.tiny)$ to generate symbol streams. The network on the receiver end is symmetrical to that on the transmitter end, except for a prediction layer with Softmax as the activation function at the end for outouttşng the decoded results $bold("M")$


#figure(
  placement: top,
  scope: "parent",
  pad(y: -40pt,
  align(center)[
    #cnn-net(
      layers: (
        (type: "conv", label: "Conv2D", dims: (28, 28, 32), params: "3×3"),
        (type: "pool", label: "MaxPool", dims: (14, 14, 32), params: "2×2"),
        (type: "conv", label: "Conv2D", dims: (14, 14, 64), params: "3×3"),
        (type: "pool", label: "MaxPool", dims: (7, 7, 64), params: "2×2"),
        (type: "flatten", label: "Flatten", dims: (3136,)),
        (type: "dense", label: "Dense", dims: (256,)),
        (type: "dense", label: "Dense", dims: (128,)),
        (type: "dense", label: "Output", dims: (10,)),
      ),
      box-width: 36pt,
      box-height: 48pt,
      layer-spacing: 25pt,
      
      show-labels: true,
      show-dimensions: true,
    )
  ]
  ),
  caption: align(start)[The whole neural network and components for the proposed SecureDSC system.],
)<CNN2>

#let fig_3 = align(center)[#commutative-diagram(
  node((0, 0), $X$),
  node((0, 1), $Y$),
  node((1, 0), $X \/ "ker"(f)$, "quot"),
  arr($X$, $Y$, $f$),
  arr("quot", (0, 1), $tilde(f)$, label-pos: right, "dashed", "inj"),
  arr($X$, "quot", $pi$),
)]

#show: style-algorithm
#let algo_fig = algorithm-figure(
  "Training Algorithm of SecureDSC",
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
    Procedure(
      "Encrypt_Decrypt",
      ("A", "n", "v"),
      {
        Comment[Initialize the search range]
        Assign[$l$][$1$]
        Assign[$r$][$n$]
        LineBreak
        While(
          $l <= r$,
          {
            Assign([mid], FnInline[floor][$(l + r) / 2$])
            IfElseChain(
              $A ["mid"] < v$,
              {
                Assign[$l$][$"mid" + 1$]
              },
              [$A ["mid"] > v$],
              {
                Assign[$r$][$"mid" - 1$]
              },
              Return[mid],
            )
          },
        )
        Return[*null*]
      },
    )
  }
)

#figure(
  fig_3,
  caption: align(start)[The detailed encryption and decryption process and network interconnection schematics.]
)<CNN3>

== Loss Function Design and Training Process

Given that the data is coveyed in textual format, cross-entropy (CE) is employed as the loss function to quantify the discrepancy between two sentences as follows

$
 &ℒ_(C E) (bold("m")_1, bold("m")_2)\
 &= - sum_(l=1) p(w_l) log q(w_l) + (1 - p(w_l)) log(1 - q(w_l))
$\
where $p(w_l)$ and $q(w_l)$ denote the real probability of the $l^"th"$ word $w_l$ appearing in message $bold("m")_1$ and the predicted probability of it appearing in $bold("m")_2$, respectively.

To accomplish successful transmission and fulfill aforementioned goals, we perform joint and independent training of net, modules for legitimate transmitters and receivers. Additionally, we devis an adversarial training mechanism that account for the impact of adversaries throughout the training process.

For the independent training of the semantic encoder and decoder, the loss function is designed as

$
 ℒ_( s e m) (bold("s"), bold(hat("s")); bold(alpha), bold(theta)) = ℒ_(C E) (bold("s"), S d_(bold(theta)) (S e_(bold(alpha)) (bold("s")))),
$\
where $bold("s")$ is the batch data. Likewise, to train the encryptor, decryptor, and the key processing module independently, the loss function follows the subsequent expression

$
 &ℒ_(c i p) (bold("s"), bold(hat("s")); bold(Beta), bold(delta), bold(kappa))\
 &= ℒ_(C E) (bold("s"), D e_delta (E n_Beta (bold("s"), K_kappa (bold("k"))), K_kappa (bold("k")))).
$\
Hence the basic modules in the network can operate independently using the aforementioned two loss functions.

At the same time, to jointly train the entire network, the loss function for the legitimate receiver Bob is designed as

$
  ℒ_B ( bold("m"), bold(hat("m")); bold(chi), bold(delta), bold(theta), bold(kappa) ) = ℒ_(C E) (bold("m"), bold(hat("m"))),
$\
where $bold(hat("m"))$ is the received message defşned in (3). Considering the adversary Eve in the channel with the sane network structure as the legitimate receiver, the loss function is defined similarly as

$
  ℒ_E ( bold("m"), bold(dash("m")); bold(dash(chi)), bold(dash(delta)), bold(dash(theta)), bold(dash(kappa)) ) = ℒ_(C E) (bold("m"), bold(dash("m"))).
$

Utilizing adversarial cryptography, we combine the above two loss functions to design the joint loss function as

$
  &ℒ_B ( bold("m"), bold(hat("m")), bold(dash("m")); bold(alpha), bold(beta), bold(gamma), bold(chi), bold(delta), bold(theta), bold(kappa) )\
  &= ℒ_B + "abs"(ℒ_E - lambda)
$\
where $"abs"(circle.filled.tiny)$ is the absolute value function and $lambda$ is the hper parameter for adversarial training to restrict Eve's ability of information reconstruction.

As shown in @Algo1, the entire network is updated sequentially according to the above loss functions. Simce the primary focus of the SecreDSC system is to protect the confidentiality of semantic features, the training of channel codecs is ommited here and the parameters are updated throughout the training process. In this algorithm, the keys shared between Alice and Bob are randomized for each message, awhile Eve replaces them with random sequences as mentioned above.


#algo_fig<Algo1>

= Performance Evaluation
== Performance Evaluation of the Proposed SecreDSC

We very first verify the feasibility of the proposed SecureDSC by evaluating loss functions of Bob and Eve under Signal-to-Noise Ratios (SNRs) of 12dB and 6dB, with varying learning rates _lr_, as shown in @Fig4. Adam optimizer is adopted with $Beta_1 = 0.9$, $Beta_2 = 0.98$ andl $lambda = 6$. From the figure it is evident that during the training process, $ℒ_B$ gradually decreases and finally converges, while $ℒ_E$ stabilizes at a sigfnificantly higher level due to the influence of $lambda$. Meanwhile, $ℒ_B$ converges to alower level as the SNR increases. According to results to a smoother variation in the loss function, which hence is selected for subsequent experiments.

#show figure.where(
  kind: "table"
): set figure.caption(position: top)

#figure(
  kind: "table",
  supplement: [Table],
  caption: [ #upper("The Settings of the Proposed SecureDSC")],
  table(
  columns: 4,
  [], [*Layer Name*], [*Units*], [*Activation*],
  [*Semantic Encoder*], [4xTransformer Encoder], [128(8 heads)], [Linear],
  [*Encryptor*], [4xTransformer Encoder], [128(8 heads)], [Butter (room temp.)],
  [Channel Decoder], [Dense],[128], [Relu],
  [*Decryptor*], [Cane sugar],[Cane sugar],[Cane sugar],
  [*Semantic Decoder*],[4xTransformer Encoder], [70% cocoa chocolate],
  [100g], [35-40% cocoa chocolate],
  [2], [Eggs],
  [Pinch], [Salt],
  [Drizzle], [Vanilla extract],
)
)<table1>


#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot


#let style = (stroke: black, fill: rgb("#0a0a994b"))

#let f1(x) = calc.sin(x)
#let fn = (
  ($ x - x^3"/"3! $, x => x - calc.pow(x, 3)/6),
  ($ x - x^3"/"3! - x^5"/"5! $, x => x - calc.pow(x, 3)/6 + calc.pow(x, 5)/120),
  ($ x - x^3"/"3! - x^5"/"5! - x^7"/"7! $, x => x - calc.pow(x, 3)/6 + calc.pow(x, 5)/120 - calc.pow(x, 7)/5040),
)

#set text(size: 10pt)

#figure(
canvas({
  import draw: *

  // Set-up a thin axis style
  set-style(axes: (stroke: .5pt, tick: (stroke: .5pt)),
            legend: (stroke: none, orientation: ttb, item: (spacing: .3), scale: 80%))

  plot.plot(size: (8, 6),
    x-tick-step: calc.pi/2,
    x-format: plot.formats.multiple-of,
    y-tick-step: 2, y-min: -2.5, y-max: 2.5,
    legend: "inner-north",
    {
      let domain = (-1.1 * calc.pi, +1.1 * calc.pi)

      for ((title, f)) in fn {
        plot.add-fill-between(f, f1, domain: domain,
          style: (stroke: none), label: title)
      }
      plot.add(f1, domain: domain, label: $ sin x  $,
        style: (stroke: black))
    })
}),
caption: "Loss of Bob and Eve under different SNRs and learning rates."
)<Fig4>

#set table(
  stroke: (x, y) => if (y == 0 or y == 3){
    (bottom: 0.7pt + black)
  },
)

#figure(
  kind: "table",
  supplement: [Table],
  caption: [ #upper("Complexity Analyses With Different Frameworks")],
  table(
    columns: 4,
    table.header(
      [],
      [*Parameters*],
      [*Training Time*],
      [*Inference Time*],
    ),
    [*DeepSC*], [12.0], [92.1], [92.1],
    [*ESCS*], [16.6], [104],[12.0],
    [*SecureDSC*],[24.7], [16.6], [0.001]
  )
)<table2>


== Comparison of Different Systems

The confidentiality of the proposed SecureDSC is further evaluated by comparing it with the classic DeepSC @DeepLearningEnabledSemanticCommunicationSystems_2 and the recent encrypted semantic communication system ESCS @ESCS. Basic semantic and channeş codecs for all schemes are implemented based on DeepSC with the specific parameter settings detailed in @table1. ESCS and SecureDSC possess different workflows when encrypting semantics. To ensure a fair comparison, their network setups for encryption and decryption are identical, and the loss function used for training are based on (10). Loss and BLEU scores (1-gram) after  500 epochs at different SNRs for DeepSC, SecreDSC, and ESCS are shown @Fig4, respectively.

= Conclusion

This letter proposed an adversarial cryptography-based semantic communication system, named SecreDSC, to guarantee secure textual feature transmission. The proposed system establishes a tripartie model consisting of a legit, transmitter, a legitimate receiver, as well as an attacker. By introducing an adversarial cryptographic mechanism during the training phase, the confidentiality for the extracted semantics is ensured. Additionally, with the joint design of source-encryption-channel, the entire system ensures overall performance on semantic communications. Furthermore, experiments under different transmission and adversary assumptions validate the effectiveness and security of the solution.
