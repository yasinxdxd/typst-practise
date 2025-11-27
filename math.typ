#import "@preview/charged-ieee:0.1.4": ieee
#import "@preview/wrap-it:0.1.1": wrap-content
#import "nn.typ": neural-net

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
$ hat(bold("y")) = h bold("x") + bold("n") , $
where $h$ is the channel coefficient assumed to be constant for a quasi-static channel, and $bold("n")$ is the additive white Gaussian noise (AWGN) with a mean of zero and a variance $sigma^2_n$. With the support of channel, chiper and semantic decoders, $hat(bold("y"))$ is decoded to reconstruct the original message as
$
  hat(bold("m")) = S d_(bold(theta)) ( D e_(bold(delta)) (C d_(bold(chi)) (hat(bold("y"))), K_(bold(kappa)) (bold("k")))),
$\
 in which $S d_(bold(theta)) (circle.filled.tiny)$ is the semantic decoder network with parameter set $bold(theta)$, $D e_(bold(delta)) (circle.filled.tiny)$ is the decrypt network with parameter set $bold(delta)$ and $C d_(bold(chi)) (circle.filled.tiny)$ is the channel decoder network with parameter set $bold(chi)$. Moreover, it is straightforward that Alice and Bob utilize the same key processing network $K_(bold(kappa)) (circle.filled.tiny)$ to obtain the same session key in the symmetric  encryption.

 The atacker Eve eavesdrops on the open wireless channel, intercepting the transmitted signal $macron(bold("y"))$. As the session key $bold("k")$ secretly shared between legitimate users is inaccessible, Eve replaces it with a random number $bold("r")$ to reconstruct the original message as
 $
   macron(bold("m")) = S d_(dash(bold(theta))) (D e_(dash(bold(delta))) (C d_(dash(bold(chi))) (hat(bold("y"))), bold("r"))).
 $\
 It is noteworthy that despite the similar network structure between Bob and Eve, the parameter sets differ due to Eve's absence from the joint training between Alice and Bob.

 = Propesed SecreDSC System

 This section presents the basic model of the proposed semantic communication system SecureDSC, including the composition of the network layers and the procedures of encryption and decryption. We then  discuss the design of loss function and the adversarial training process that provides the confidentiality protection of transmitted messages.

 == Basic Model