# Primal Simplex Method Guide

## Table of Contents
1. [Problem Formulation](#problem-formulation)
2. [Converting to Canonical Form](#converting-to-canonical-form)
3. [Initial Simplex Tableau](#initial-simplex-tableau)
4. [Simplex Algorithm Steps](#simplex-algorithm-steps)
5. [Worked Example: Limpopo Furniture Company](#worked-example-limpopo-furniture-company)
6. [Practice Exercises](#practice-exercises)

---

## When to Use Primal Simplex Method

### Ideal Problem Characteristics:
- **Maximization or minimization** problems in standard form
- **All constraints are equalities** (after adding slack/surplus variables)
- **All variables ≥ 0** (non-negativity constraints)
- **Feasible starting point available** - typically the origin with slack variables

### Specific Scenarios:
1. **Production Planning**: Maximize profit subject to resource constraints
2. **Resource Allocation**: Optimize resource distribution with capacity limits
3. **Portfolio Optimization**: Maximize returns within investment constraints
4. **Diet Problems**: Minimize cost while meeting nutritional requirements
5. **Transportation Problems**: Minimize shipping costs with supply/demand constraints

### Starting Conditions Required:
- **Basic feasible solution exists** at origin (all original variables = 0)
- **Slack variables provide initial basic variables** 
- **All RHS values ≥ 0** (feasible starting point)
- **Clear objective function** to maximize or minimize

### When NOT to Use Primal Simplex:
- **Problem starts infeasible** (negative RHS values) → Use Dual Simplex
- **All constraints are ≥ type** in minimization → Consider Dual Simplex first
- **Mixed integer requirements** → Use Branch & Bound after LP relaxation
- **Very large problems** → Use specialized software instead of manual methods

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

#### For MAXIMIZATION Problems:
- **Optimal**: All coefficients in z-row are ≥ 0
- **Not optimal**: Any coefficient in z-row is < 0 → Continue to Step 2
- **Example**: Z-row [0, 2, 0, 3, 1] → **OPTIMAL** (all ≥ 0)
- **Example**: Z-row [0, -3, 0, 2, 1] → **NOT OPTIMAL** (-3 < 0)

#### For MINIMIZATION Problems:
- **Optimal**: All coefficients in z-row are ≤ 0
- **Not optimal**: Any coefficient in z-row is > 0 → Continue to Step 2  
- **Example**: Z-row [0, -2, 0, -3, -1] → **OPTIMAL** (all ≤ 0)
- **Example**: Z-row [0, 3, 0, -2, -1] → **NOT OPTIMAL** (3 > 0)

## Crystal Clear Primal Simplex Pivot Rules

### For MAXIMIZATION Problems:

#### Pivot Column Selection (Entering Variable):
1. **Rule**: Choose column with **most negative** coefficient in z-row
2. **Reason**: Most negative coefficient gives greatest rate of improvement per unit
3. **Example**: Z-row coefficients [-8, -5, 0, 0, 0] → Choose x₁ column (coefficient -8)
4. **Tie-breaking**: If equal, choose leftmost column

#### Pivot Row Selection (Leaving Variable) - Ratio Test:
1. **Rule**: Calculate θ = RHS ÷ Pivot Column Coefficient
2. **CRITICAL**: **ONLY** for **positive coefficients** in pivot column
3. **Ignore**: Zero and negative coefficients (don't constrain solution)
4. **Choose**: Row with **smallest positive ratio**
5. **Example**:
   - Pivot column x₁: coefficients [8, 4, 2], RHS [48, 20, 8]
   - Row 1: θ = 48 ÷ 8 = 6
   - Row 2: θ = 20 ÷ 4 = 5  
   - Row 3: θ = 8 ÷ 2 = 4 ← **Smallest, choose Row 3**

### For MINIMIZATION Problems:

#### Pivot Column Selection (Entering Variable):
1. **Rule**: Choose column with **most positive** coefficient in z-row
2. **Reason**: Most positive coefficient represents highest cost reduction potential
3. **Example**: Z-row coefficients [0, 3, -2, 1, 0] → Choose x₂ column (coefficient +3)
4. **Tie-breaking**: If equal, choose leftmost column

#### Pivot Row Selection (Leaving Variable) - Ratio Test:
1. **Rule**: Calculate θ = RHS ÷ Pivot Column Coefficient  
2. **CRITICAL**: **ONLY** for **positive coefficients** in pivot column
3. **Ignore**: Zero and negative coefficients (same as maximization)
4. **Choose**: Row with **smallest positive ratio** (same process as maximization)
5. **Example**:
   - Pivot column x₂: coefficients [2, -1, 3], RHS [10, 5, 15]
   - Row 1: θ = 10 ÷ 2 = 5
   - Row 2: -1 < 0, ignore
   - Row 3: θ = 15 ÷ 3 = 5 
   - **Tie**: Choose Row 1 (topmost)

### Key Differences Summary:

| Aspect | Maximization | Minimization |
|--------|-------------|-------------|
| **Pivot Column** | Most negative z-coefficient | Most positive z-coefficient |
| **Pivot Row** | Smallest positive ratio | Smallest positive ratio |
| **Optimality Check** | All z-coefficients ≥ 0 | All z-coefficients ≤ 0 |

### Step 2: Select Pivot Column (Entering Variable)
**Apply the rules above based on your problem type (maximization vs minimization)**

### Step 3: Select Pivot Row (Leaving Variable) - Manual Ratio Test

#### Manual Ratio Test Process:
1. **Identify pivot column** (from Step 2)
2. **Examine each row** in the constraint section (ignore z-row)
3. **Calculate ratios manually**:
   ```
   Ratio = RHS value ÷ pivot column coefficient
   ```
4. **Apply ratio test rules**:
   - **Only consider positive pivot column coefficients** (negative/zero are ignored)
   - **Calculate ratio for each positive coefficient**
   - **Choose row with smallest positive ratio**

#### Step-by-Step Manual Example:
If pivot column is x₁ with coefficients [8, 4, 2] and RHS [48, 20, 8]:
- **Row 1**: 48 ÷ 8 = 6
- **Row 2**: 20 ÷ 4 = 5  
- **Row 3**: 8 ÷ 2 = 4 ← **Smallest ratio**
- **Leaving variable**: Variable in Row 3 (s₃)

#### Tie-Breaking Rules:
- **If ratios are equal**: Choose topmost row
- **If coefficient ≤ 0**: Ignore this row (doesn't constrain the solution)

### Step 4: Manual Pivot Operations

#### Identifying the Pivot Element:
- **Pivot element** = intersection of pivot row and pivot column
- **Example**: If Row 3 and x₁ column, pivot element is the coefficient of x₁ in Row 3

#### Manual Row Operations Process:

**Step 4a: Create New Pivot Row**
```
New pivot row = Old pivot row ÷ pivot element
```
- **Divide every element** in the pivot row by the pivot element
- **Example**: If pivot row is [2, 1.5, 0.5, 0, 0, 1, 8] and pivot element is 2:
  - New pivot row = [1, 0.75, 0.25, 0, 0, 0.5, 4]

**Step 4b: Update All Other Rows**
For each other row (including z-row):
```
New row = Old row - (multiplier × new pivot row)
```
Where **multiplier** = coefficient in that row's pivot column

#### Manual Calculation Example:
If updating z-row with multiplier -60:
- **Old z-row**: [-60, -30, -20, 0, 0, 0, 0]
- **New pivot row**: [1, 0.75, 0.25, 0, 0, 0.5, 4]  
- **Calculation**: [-60, -30, -20, 0, 0, 0, 0] - (-60) × [1, 0.75, 0.25, 0, 0, 0.5, 4]
- **New z-row**: [0, 15, -5, 0, 0, 30, 240]

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

**Manual Analysis Process:**
1. **Check optimality**: Z-row has negative coefficients [-60, -30, -20] → Not optimal
2. **Select pivot column**: Most negative is -60 → x₁ column selected
3. **Manual ratio test**:
   - Row 1: RHS=48, coefficient=8 → Ratio = 48÷8 = 6
   - Row 2: RHS=20, coefficient=4 → Ratio = 20÷4 = 5  
   - Row 3: RHS=8, coefficient=2 → Ratio = 8÷2 = 4 ← **Smallest**
4. **Select pivot row**: Row 3 (smallest ratio)
5. **Pivot element**: 2 (intersection of Row 3 and x₁ column)

### Iteration 2: After First Pivot

| t-2 | x₁ | x₂  | x₃  | s₁ | s₂ | s₃ | rhs | θ        |
|-----|----|----|-----|----|----|----|----|----------|
| z   | 0  | 15 | -5  | 0  | 0  | 30 | 240 |          |
| 1   | 0  | 0  | -1  | 1  | 0  | -4 | 16  | -16 (neg)|
| 2   | 0  | -1 | 0.5 | 0  | 1  | -2 | 4   | 4/0.5=8  |
| 3   | 1  | 0.75| 0.25| 0  | 0  | 0.5| 4   | 4/0.25=16|

**Manual Analysis Process:**
1. **Check optimality**: Z-row has -5 coefficient for x₃ → Not optimal  
2. **Select pivot column**: Most negative is -5 → x₃ column selected
3. **Manual ratio test**:
   - Row 1: RHS=16, coefficient=-1 → **Negative, ignore**
   - Row 2: RHS=4, coefficient=0.5 → Ratio = 4÷0.5 = 8
   - Row 3: RHS=4, coefficient=0.25 → Ratio = 4÷0.25 = 16
4. **Select pivot row**: Row 2 (only positive ratio: 8)
5. **Pivot element**: 0.5 (intersection of Row 2 and x₃ column)

### Iteration 3: Final Optimal Tableau

| t-3 | x₁ | x₂ | x₃ | s₁ | s₂ | s₃ | rhs |
|-----|----|----|----|----|----|----|-----|
| z   | 0  | 5  | 0  | 0  | 10 | 10 | 280 |
| 1   | 0  | -2 | 0  | 1  | 2  | -8 | 24  |
| 2   | 0  | -2 | 1  | 0  | 2  | -4 | 8   |
| 3   | 1  | 1.5| 0  | 0  | -0.5| 1.5| 2  |

**Manual Optimality Check:**
1. **Check z-row coefficients**: [0, 5, 0, 0, 10, 10] → All ≥ 0 ✓
2. **Solution is OPTIMAL**

**Reading the Solution:**
- **Basic variables** (values from RHS column):
  - s₁ = 24 (slack in Row 1)
  - x₃ = 8 (basic in Row 2)  
  - x₁ = 2 (basic in Row 3)
- **Non-basic variables** (not in basis): x₂ = 0, s₂ = 0, s₃ = 0

**Final Answer:**
- x₁ = 2 desks, x₂ = 0 tables, x₃ = 8 chairs
- Maximum revenue = 280 (from z-row RHS)

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

## Quick Reference Card: Primal Simplex Rules

### MAXIMIZATION Problems

| Step | Rule | Example |
|------|------|---------|
| **Optimality Check** | All z-coefficients ≥ 0 | [0, 2, 0, 1] → OPTIMAL ✓ |
| **Pivot Column** | Most negative z-coefficient | [-8, -5, 0] → Choose x₁ (-8) |
| **Pivot Row** | Smallest positive ratio | θ = RHS÷coeff, ignore ≤0 |
| **Ratio Calculation** | θ = 48÷8=6, 20÷4=5, 8÷2=4 | Choose row 3 (θ=4) |

### MINIMIZATION Problems  

| Step | Rule | Example |
|------|------|---------|
| **Optimality Check** | All z-coefficients ≤ 0 | [0, -2, 0, -1] → OPTIMAL ✓ |
| **Pivot Column** | Most positive z-coefficient | [0, 3, -2, 1] → Choose x₂ (+3) |
| **Pivot Row** | Smallest positive ratio | Same as maximization |
| **Ratio Calculation** | θ = 10÷2=5, ignore -1, 15÷3=5 | Choose row 1 (tie-break) |

### Common Mistakes to Avoid:
1. **Wrong pivot column direction**: Negative for max, positive for min
2. **Including negative ratios**: Only use positive coefficients in ratio test
3. **Wrong optimality check**: ≥0 for max, ≤0 for min
4. **Forgetting to check feasibility**: All RHS must be ≥0

### Manual Calculation Reminders:
- **New pivot row** = Old pivot row ÷ pivot element
- **Other rows** = Old row - (multiplier × new pivot row)  
- **Multiplier** = coefficient in that row's pivot column
- **Check work**: Pivot element should become 1, other pivot column entries become 0

---

*This guide is based on the Belgium Campus Linear Programming course materials.*