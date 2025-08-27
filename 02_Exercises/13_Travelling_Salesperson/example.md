# Travelling Salesperson Problem - Gandalf's Journey

## Problem Description

Gandalf the Grey lives in Gondor, Middle Earth. He is responsible for the communities in Gondor, Isengard, Rivendell, Lothlórien, and Rohan. Each Yule, he visits each of these communities. The distance between each community (in miles) is shown in the table below.

## Distance Matrix

|            | 1. Gondor | 2. Isengard | 3. Rivendell | 4. Lothlorien | 5. Rohan |
|------------|-----------|-------------|--------------|---------------|----------|
| 1. Gondor  |     0     |     132     |     217      |      164      |    58    |
| 2. Isengard|    132    |      0      |     290      |      201      |    79    |
| 3. Rivendell|   217    |     290     |      0       |      113      |   303    |
| 4. Lothlorien| 164     |     201     |     113      |       0       |   196    |
| 5. Rohan   |    58     |      79     |     303      |      196      |    0     |

## Linear Programming Formulation

### Decision Variables

xij = 1 if Gandalf leaves city i and travels next to city j, 0 otherwise

Where:
- i, j ∈ {1, 2, 3, 4, 5}
- 1 = Gondor, 2 = Isengard, 3 = Rivendell, 4 = Lothlorien, 5 = Rohan

### Objective Function

**Minimize:**
```
z = 132x₁₂ + 217x₁₃ + 164x₁₄ + 58x₁₅ +
    132x₂₁ + 290x₂₃ + 201x₂₄ + 79x₂₅ +
    217x₃₁ + 290x₃₂ + 113x₃₄ + 303x₃₅ +
    164x₄₁ + 201x₄₂ + 113x₄₃ + 196x₄₅ +
    58x₅₁ + 79x₅₂ + 303x₅₃ + 196x₅₄
```

### Constraints

**Arriving once in each city:**
```
x₂₁ + x₃₁ + x₄₁ + x₅₁ = 1  (Arrive at Gondor)
x₁₂ + x₃₂ + x₄₂ + x₅₂ = 1  (Arrive at Isengard)
x₁₃ + x₂₃ + x₄₃ + x₅₃ = 1  (Arrive at Rivendell)
x₁₄ + x₂₄ + x₃₄ + x₅₄ = 1  (Arrive at Lothlorien)
x₁₅ + x₂₅ + x₃₅ + x₄₅ = 1  (Arrive at Rohan)
```

**Leaving each city once:**
```
x₁₂ + x₁₃ + x₁₄ + x₁₅ = 1  (Leave Gondor)
x₂₁ + x₂₃ + x₂₄ + x₂₅ = 1  (Leave Isengard)
x₃₁ + x₃₂ + x₃₄ + x₃₅ = 1  (Leave Rivendell)
x₄₁ + x₄₂ + x₄₃ + x₄₅ = 1  (Leave Lothlorien)
x₅₁ + x₅₂ + x₅₃ + x₅₄ = 1  (Leave Rohan)
```

**Sign restrictions:**
```
xij ∈ {0, 1} for all i, j
```

<div style="page-break-before: always;"></div>

## Subtour Elimination Constraints

### The Problem with Basic Formulation

The constraints above ensure that we enter and leave each city exactly once, but they don't prevent **subtours** - smaller cycles that don't include all cities. For example, we could have:
- Subtour 1: Gondor → Rohan → Gondor
- Subtour 2: Isengard → Rivendell → Lothlorien → Isengard

This would satisfy all the arrival/departure constraints but wouldn't give us a single tour visiting all cities.

### Miller-Tucker-Zemlin (MTZ) Formulation

**Additional Decision Variables:**
```
Ui = position of city i in the tour sequence
U₁ = 1 (Gondor is always position 1)
2 ≤ Ui ≤ 5 for i = 2, 3, 4, 5
```

**Subtour Elimination Constraints:**
```
Ui - Uj + 5xij ≤ 4  for all pairs i,j (excluding city 1)
```

### How It Works: Breaking Down U₃ - U₄ + 5x₃₄ ≤ 4

**Case 1: No travel 3→4 (x₃₄ = 0)**
```
U₃ - U₄ ≤ 4  (always satisfied since positions are 2-5)
```

**Case 2: Travel 3→4 (x₃₄ = 1)**
```
U₃ - U₄ + 5 ≤ 4
U₃ ≤ U₄ - 1
```
This forces city 3 to come **before** city 4 in the sequence.

<div style="page-break-before: always;"></div>

### How Constraint Pairs Prevent Subtours

The constraints work in **pairs** to prevent cycles. For cities 3 and 4:

1. **U₃ - U₄ + 5x₃₄ ≤ 4**: If x₃₄ = 1, then U₃ < U₄
2. **U₄ - U₃ + 5x₄₃ ≤ 4**: If x₄₃ = 1, then U₄ < U₃

**Why this prevents the subtour 3→4→3:**

If both x₃₄ = 1 AND x₄₃ = 1:
- From constraint 1: U₃ ≤ U₄ - 1
- From constraint 2: U₄ ≤ U₃ - 1
- Combined: U₃ ≤ U₃ - 2 (impossible!)

Therefore, we can't have both x₃₄ = 1 and x₄₃ = 1.

### Complete Subtour Elimination Constraints

```
U₁ = 1, 2 ≤ Ui ≤ 5 for i = 2,3,4,5

U₂ - U₃ + 5x₂₃ ≤ 4    U₂ - U₄ + 5x₂₄ ≤ 4    U₂ - U₅ + 5x₂₅ ≤ 4
U₃ - U₂ + 5x₃₂ ≤ 4    U₃ - U₄ + 5x₃₄ ≤ 4    U₃ - U₅ + 5x₃₅ ≤ 4
U₄ - U₂ + 5x₄₂ ≤ 4    U₄ - U₃ + 5x₄₃ ≤ 4    U₄ - U₅ + 5x₄₅ ≤ 4
U₅ - U₂ + 5x₅₂ ≤ 4    U₅ - U₃ + 5x₅₃ ≤ 4    U₅ - U₄ + 5x₅₄ ≤ 4
```

Note: No constraints involve U₁ since it's fixed at 1.

<div style="page-break-before: always;"></div>