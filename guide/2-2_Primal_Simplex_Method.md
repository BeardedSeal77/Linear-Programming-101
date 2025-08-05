# Primal Simplex Method Guide

## Table of Contents
1. [Problem Formulation](#problem-formulation)
2. [Converting to Canonical Form](#converting-to-canonical-form)
3. [Initial Simplex Tableau](#initial-simplex-tableau)
4. [Simplex Algorithm Steps](#simplex-algorithm-steps)
5. [Worked Example: Limpopo Furniture Company](#worked-example-limpopo-furniture-company)
6. [Practice Exercises](#practice-exercises)

---

## Problem Formulation

### The Limpopo Furniture Company Example

**Business Context:**
The Limpopo Furniture Company manufactures desks, tables, and chairs. Each type of furniture requires:
- Lumber (raw material)
- Two types of skilled labour: finishing and carpentry

**Resource Requirements:**

| Product | Lumber (meters) | Finishing Hours | Carpentry Hours | Selling Price |
|---------|----------------|-----------------|-----------------|---------------|
| Desk    | 8              | 4               | 2               | R60           |
| Table   | 6              | 2               | 1.5             | R30           |
| Chair   | 1              | 1.5             | 0.5             | R20           |

**Available Resources:**
- 48 board meters of lumber
- 20 finishing hours  
- 8 carpentry hours

**Objective:** Maximize total revenue (resources already purchased)

### Step-by-Step Formulation

#### Step 1: Define Decision Variables
Let xᵢ = The number of product i manufactured
- x₁ = Number of desks
- x₂ = Number of tables  
- x₃ = Number of chairs

#### Step 2: Create Objective Function
Maximize revenue based on selling prices:
```
max z = 60x₁ + 30x₂ + 20x₃
```

#### Step 3: Create Constraints

**Lumber Constraint:**
8 meters per desk + 6 meters per table + 1 meter per chair ≤ 48 meters available
```
8x₁ + 6x₂ + 1x₃ ≤ 48
```

**Finishing Hours Constraint:**
4 hours per desk + 2 hours per table + 1.5 hours per chair ≤ 20 hours available
```
4x₁ + 2x₂ + 1.5x₃ ≤ 20
```

**Carpentry Hours Constraint:**
2 hours per desk + 1.5 hours per table + 0.5 hours per chair ≤ 8 hours available
```
2x₁ + 1.5x₂ + 0.5x₃ ≤ 8
```

#### Step 4: Non-negativity Constraints
```
x₁, x₂, x₃ ≥ 0
```

### Complete Mathematical Model
```
Maximize z = 60x₁ + 30x₂ + 20x₃

Subject to:
  8x₁ + 6x₂ + 1x₃ ≤ 48    (lumber)
  4x₁ + 2x₂ + 1.5x₃ ≤ 20  (finishing)
  2x₁ + 1.5x₂ + 0.5x₃ ≤ 8 (carpentry)
  x₁, x₂, x₃ ≥ 0
```

---

## Converting to Canonical Form

### Canonical Form Requirements
For the Primal Simplex Algorithm, we need:
- **Objective function** in the form: (z) - c₁x₁ - c₂x₂ - ... = 0
- **All constraints** as equalities using slack variables
- **All variables** ≥ 0

### Adding Slack Variables
Convert inequalities (≤) to equalities by adding slack variables:

**Original constraints:**
```
8x₁ + 6x₂ + 1x₃ ≤ 48
4x₁ + 2x₂ + 1.5x₃ ≤ 20
2x₁ + 1.5x₂ + 0.5x₃ ≤ 8
```

**With slack variables:**
```
8x₁ + 6x₂ + 1x₃ + s₁ = 48
4x₁ + 2x₂ + 1.5x₃ + s₂ = 20
2x₁ + 1.5x₂ + 0.5x₃ + s₃ = 8
```

### Complete Canonical Form
```
(z) - 60x₁ - 30x₂ - 20x₃ = 0
8x₁ + 6x₂ + 1x₃ + s₁ = 48
4x₁ + 2x₂ + 1.5x₃ + s₂ = 20
2x₁ + 1.5x₂ + 0.5x₃ + s₃ = 8
x₁, x₂, x₃, s₁, s₂, s₃ ≥ 0
```

---

## Initial Simplex Tableau

### Tableau Structure
The simplex tableau organizes all information systematically:

| t-i | x₁  | x₂  | x₃  | s₁ | s₂ | s₃ | rhs | θ   |
|-----|-----|-----|-----|----|----|----|----|-----|
| z   | -60 | -30 | -20 | 0  | 0  | 0  | 0   |     |
| 1   | 8   | 6   | 1   | 1  | 0  | 0  | 48  | 6   |
| 2   | 4   | 2   | 1.5 | 0  | 1  | 0  | 20  | 5   |
| 3   | 2   | 1.5 | 0.5 | 0  | 0  | 1  | 8   | 4   |

### Column Explanations
- **t-i**: Tableau iteration and constraint number
- **x₁, x₂, x₃**: Original decision variables
- **s₁, s₂, s₃**: Slack variables
- **rhs**: Right-hand side values
- **θ**: Ratio test column (rhs ÷ pivot column value)

---

## Simplex Algorithm Steps

### Step 1: Check Optimality
**For Maximization Problems:**
- If all coefficients in the z-row are ≥ 0, the solution is optimal
- If any coefficient in the z-row is < 0, continue to Step 2

### Step 2: Select Pivot Column (Entering Variable)
**For Maximization:**
- Choose the column with the **most negative** coefficient in the z-row
- This variable will "enter" the solution

### Step 3: Select Pivot Row (Leaving Variable) - Ratio Test
**Ratio Test Formula:**
```
θ = rhs value ÷ pivot column value (only for positive pivot column values)
```
- Choose the row with the **smallest non-negative ratio**
- This variable will "leave" the solution

### Step 4: Pivot Operations
**Pivot Element:** The intersection of pivot row and pivot column

**Row Operations:**
1. **New pivot row** = Old pivot row ÷ pivot element
2. **All other rows** = Old row - (pivot column value × new pivot row)

### Step 5: Create New Tableau
- Update all values using pivot operations
- Return to Step 1

---

## Worked Example: Limpopo Furniture Company

### Iteration 1: Initial Tableau

| t-1 | x₁  | x₂  | x₃  | s₁ | s₂ | s₃ | rhs | θ     |
|-----|-----|-----|-----|----|----|----|----|-------|
| z   | -60 | -30 | -20 | 0  | 0  | 0  | 0   |       |
| 1   | 8   | 6   | 1   | 1  | 0  | 0  | 48  | 48/8=6|
| 2   | 4   | 2   | 1.5 | 0  | 1  | 0  | 20  | 20/4=5|
| 3   | 2   | 1.5 | 0.5 | 0  | 0  | 1  | 8   | 8/2=4 |

**Analysis:**
- **Pivot column:** x₁ (most negative: -60)
- **Pivot row:** Row 3 (smallest ratio: 4)
- **Pivot element:** 2

### Iteration 2: After First Pivot

| t-2 | x₁ | x₂  | x₃  | s₁ | s₂ | s₃ | rhs | θ        |
|-----|----|----|-----|----|----|----|----|----------|
| z   | 0  | 15 | -5  | 0  | 0  | 30 | 240 |          |
| 1   | 0  | 0  | -1  | 1  | 0  | -4 | 16  | -16 (neg)|
| 2   | 0  | -1 | 0.5 | 0  | 1  | -2 | 4   | 4/0.5=8  |
| 3   | 1  | 0.75| 0.25| 0  | 0  | 0.5| 4   | 4/0.25=16|

**Analysis:**
- **Pivot column:** x₃ (most negative: -5)
- **Pivot row:** Row 2 (smallest positive ratio: 8)
- **Pivot element:** 0.5

### Iteration 3: Final Optimal Tableau

| t-3 | x₁ | x₂ | x₃ | s₁ | s₂ | s₃ | rhs |
|-----|----|----|----|----|----|----|-----|
| z   | 0  | 5  | 0  | 0  | 10 | 10 | 280 |
| 1   | 0  | -2 | 0  | 1  | 2  | -8 | 24  |
| 2   | 0  | -2 | 1  | 0  | 2  | -4 | 8   |
| 3   | 1  | 1.5| 0  | 0  | -0.5| 1.5| 2  |

**Optimal Solution:**
- All z-row coefficients are ≥ 0 → **OPTIMAL**
- x₁ = 2 desks
- x₂ = 0 tables  
- x₃ = 8 chairs
- Maximum revenue = R280

---

## Practice Exercises

### Exercise 1: Santa's Workshop

**Problem Statement:**
Santa's Workshop manufactures wooden soldiers and trains:

**Product Details:**
- **Soldier:** Sells for R27, uses R10 materials, R14 variable costs
- **Train:** Sells for R21, uses R9 materials, R10 variable costs

**Profit Calculation:**
- **Soldier profit:** R27 - R10 - R14 = R3 per soldier
- **Train profit:** R21 - R9 - R10 = R2 per train

**Resource Requirements:**

| Product | Finishing Hours | Carpentry Hours |
|---------|----------------|-----------------|
| Soldier | 2              | 1               |
| Train   | 1              | 1               |

**Constraints:**
- 100 finishing hours available per week
- 80 carpentry hours available per week
- Maximum 40 soldiers can be sold per week
- Unlimited demand for trains

**Tasks:**
1. Formulate the mathematical model
2. Solve using Primal Simplex Algorithm

### Exercise 2: Accessories Inc.

**Problem Statement:**
Accessories Inc. manufactures belts and shoes:

**Resource Requirements:**

| Product | Leather (m²) | Skilled Labour (hours) | Selling Price |
|---------|--------------|------------------------|---------------|
| Belt    | 2            | 1                      | R23           |
| Shoes   | 3            | 2                      | R40           |

**Resource Costs:**
- Leather: R5 per m²
- Skilled labour: R10 per hour

**Available Resources:**
- 25 m² leather
- 15 hours skilled labour

**Profit Calculation:**
- **Belt profit:** R23 - (2×R5) - (1×R10) = R3 per belt
- **Shoe profit:** R40 - (3×R5) - (2×R10) = R5 per pair

**Tasks:**
1. Formulate the mathematical model
2. Solve using Primal Simplex Algorithm

---

## Key Takeaways

### When to Use Primal Simplex
- **Maximization problems** in canonical form
- **All constraints** are ≤ inequalities
- **All variables** are non-negative
- **Feasible starting point** available (origin with slack variables)

### Algorithm Benefits
- **Systematic approach** to finding optimal solutions
- **Guaranteed convergence** for feasible problems
- **Provides sensitivity information** through final tableau
- **Handles multiple constraints** efficiently

### Common Mistakes to Avoid
1. **Wrong pivot selection** - always choose most negative for max problems
2. **Incorrect ratio test** - ignore negative and zero ratios
3. **Pivot operation errors** - double-check arithmetic
4. **Premature termination** - ensure all z-row coefficients are non-negative

---

*This guide is based on the Belgium Campus Linear Programming course materials.*