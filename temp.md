**Objective function:**
min z = 264x₁₂ + 434x₁₃ + 328x₁₄ + 116x₁₅ + 174x₁₆ +
132x₂₁ + 290x₂₃ + 201x₂₄ + 79x₂₅ + 119x₂₆ +
217x₃₁ + 580x₃₂ + 226x₃₄ + 606x₃₅ + 909x₃₆ +
164x₄₁ + 402x₄₂ + 113x₄₃ + 196x₄₅ + 294x₄₆ +
58x₅₁ + 158x₅₂ + 303x₅₃ + 392x₅₄ + 441x₅₆ +
87x₆₁ + 237x₆₂ + 455x₆₃ + 588x₆₄ + 662x₆₅

**Arriving once in a city constraints:**
x₂₁ + x₃₁ + x₄₁ + x₅₁ + x₆₁ = 1
x₁₂ + x₃₂ + x₄₂ + x₅₂ + x₆₂ = 1
x₁₃ + x₂₃ + x₄₃ + x₅₃ + x₆₃ = 1
x₁₄ + x₂₄ + x₃₄ + x₅₄ + x₆₄ = 1
x₁₅ + x₂₅ + x₃₅ + x₄₅ + x₆₅ = 1
x₁₆ + x₂₆ + x₃₆ + x₄₆ + x₅₆ = 1

**Leaving a city once constraints:**
x₁₂ + x₁₃ + x₁₄ + x₁₅ + x₁₆ = 1
x₂₁ + x₂₃ + x₂₄ + x₂₅ + x₂₆ = 1
x₃₁ + x₃₂ + x₃₄ + x₃₅ + x₃₆ = 1
x₄₁ + x₄₂ + x₄₃ + x₄₅ + x₄₆ = 1
x₅₁ + x₅₂ + x₅₃ + x₅₄ + x₅₆ = 1
x₆₁ + x₆₂ + x₆₃ + x₆₄ + x₆₅ = 1

**Sub-tour constraints:**
U₂ - U₃ + 6x₂₃ ≤ 5
U₂ - U₄ + 6x₂₄ ≤ 5
U₂ - U₅ + 6x₂₅ ≤ 5
U₂ - U₆ + 6x₂₆ ≤ 5
U₃ - U₂ + 6x₃₂ ≤ 5
U₃ - U₄ + 6x₃₄ ≤ 5
U₃ - U₅ + 6x₃₅ ≤ 5
U₃ - U₆ + 6x₃₆ ≤ 5
U₄ - U₂ + 6x₄₂ ≤ 5
U₄ - U₃ + 6x₄₃ ≤ 5
U₄ - U₅ + 6x₄₅ ≤ 5
U₄ - U₆ + 6x₄₆ ≤ 5
U₅ - U₂ + 6x₅₂ ≤ 5
U₅ - U₃ + 6x₅₃ ≤ 5
U₅ - U₄ + 6x₅₄ ≤ 5
U₅ - U₆ + 6x₅₆ ≤ 5
U₆ - U₂ + 6x₆₂ ≤ 5
U₆ - U₃ + 6x₆₃ ≤ 5
U₆ - U₄ + 6x₆₄ ≤ 5
U₆ - U₅ + 6x₆₅ ≤ 5

**Sign restrictions:**
xᵢⱼ = 0 or 1
Uᵢ ≥ 0 and integers