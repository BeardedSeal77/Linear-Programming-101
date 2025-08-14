# Jack's Moving Truck - Knapsack Problem Solution

## Problem Statement
Jack is moving from Gauteng to Mpumalanga and has rented a truck that can haul up to **1,100 dm³** of furniture. We need to determine which items should Jack bring to maximize value.

## Given Data
| Item | Value (R 1000) | Volume (dm³) |
|------|----------------|--------------|
| Bedroom set (x₁) | 60 | 800 |
| Dining Room set (x₂) | 48 | 600 |
| Stereo (x₃) | 14 | 300 |
| Sofa (x₄) | 31 | 400 |
| TV Set (x₅) | 10 | 200 |

## Mathematical Formulation
**Objective Function:**
```
Maximize z = 60x₁ + 48x₂ + 14x₃ + 31x₄ + 10x₅
```

**Constraint:**
```
800x₁ + 600x₂ + 300x₃ + 400x₄ + 200x₅ ≤ 1,100
```

**Decision Variables:**
```
xᵢ ∈ {0, 1} for i = 1, 2, 3, 4, 5 (binary variables)
```

## Step 1: Setting Up Excel Solver

Set up the Excel solver with:
- **Objective Function:** Maximize z = 60x₁ + 48x₂ + 14x₃ + 31x₄ + 10x₅
- **Constraint:** 800x₁ + 600x₂ + 300x₃ + 400x₄ + 200x₅ ≤ 1,100
- **Variables:** x₁, x₂, x₃, x₄, x₅ as binary (0 or 1)

## Step 2: Ratio Test Table

The ratio test helps us identify the most efficient items by calculating **Value per Unit Volume**.

| Item | Value (R 1000) | Volume (dm³) | Ratio (Value/Volume) | Rank |
|------|----------------|--------------|---------------------|------|
| Bedroom set (x₁) | 60 | 800 | 60/800 = 0.075 | 3 |
| Dining Room set (x₂) | 48 | 600 | 48/600 = 0.080 | 1 |
| Stereo (x₃) | 14 | 300 | 14/300 = 0.047 | 5 |
| Sofa (x₄) | 31 | 400 | 31/400 = 0.078 | 2 |
| TV Set (x₅) | 10 | 200 | 10/200 = 0.050 | 4 |

### Ratio Test Analysis
**Ranking by efficiency (highest ratio first):**
1. **Dining Room set (x₂)**: 0.080 R/dm³
2. **Sofa (x₄)**: 0.078 R/dm³  
3. **Bedroom set (x₁)**: 0.075 R/dm³
4. **TV Set (x₅)**: 0.050 R/dm³
5. **Stereo (x₃)**: 0.047 R/dm³

The ratio test suggests prioritizing items with higher value-to-volume ratios when making selection decisions.

### Excel Formula for Ranking
For ranking the ratios in Excel (assuming F34:F38 are ratios, G34:G38 are ranks):
```excel
=RANK(F34,$F$34:$F$38,0)
```
Copy this formula down to G35:G38.

## Step 3: First Problem - Greedy Approach

Now we'll solve using a greedy approach: start with the highest ranked item and keep adding items until we run out of capacity.

### Greedy Selection Table (Linear Programming Relaxation)
| Rank | Item | Value (R 1000) | Volume (dm³) | Remaining Volume | Include | Decision |
|------|------|----------------|--------------|------------------|---------|----------|
| - | Starting Capacity | - | - | 1,100 | - | Available capacity |
| 1 | Dining Room set (x₂) | 48 | 600 | 500 | x₂ = 1 | Take it (1,100 - 600 = 500) |
| 2 | Sofa (x₄) | 31 | 400 | 100 | x₄ = 1 | Take it (500 - 400 = 100) |
| 3 | Bedroom set (x₁) | 60 | 800 | - | x₁ = 100/800 = 1/8 | **Fractional** (100/800 = 0.125) |

### Linear Programming Solution (Upper Bound)
**Selected Items:**
- Dining Room set (x₂) = 1
- Sofa (x₄) = 1  
- Bedroom set (x₁) = 1/8 (fractional)

**Total Value (Z):** 
- Z = 48(1) + 31(1) + 60(1/8)
- Z = 48 + 31 + 7.5 = **86.5 (R 1000)**
- **In fractional form: Z = 48 + 31 + 60/8 = 79 + 15/2 = 173/2**

### Branch and Bound Setup
Since x₁ is fractional (1/8), we create two subproblems:

**Subproblem 1:** x₁ = 0 (don't take bedroom set)  
**Subproblem 2:** x₁ = 1 (must take bedroom set)

*The LP relaxation gives us Z = 86.5 as our upper bound for the optimal integer solution.*