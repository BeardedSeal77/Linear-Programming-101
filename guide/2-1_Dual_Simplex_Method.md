# Dual Simplex Method Guide

## Table of Contents
1. [Introduction to Dual Simplex](#introduction-to-dual-simplex)
2. [When to Use Dual Simplex](#when-to-use-dual-simplex)
3. [Canonical Form for Dual Simplex](#canonical-form-for-dual-simplex)
4. [Dual Simplex Algorithm Steps](#dual-simplex-algorithm-steps)
5. [Worked Example: Farmer Brown's Planning](#worked-example-farmer-browns-planning)
6. [Two-Phase Process: Dual to Primal](#two-phase-process-dual-to-primal)
7. [Practice Exercises](#practice-exercises)

---

## Introduction to Dual Simplex

### What is the Dual Simplex Method?
The Dual Simplex Method is used when:
- The **objective function** is optimal (no negative coefficients in z-row)
- The **basic solution** is **infeasible** (negative values in RHS)

Unlike the Primal Simplex which starts feasible but non-optimal, the Dual Simplex starts **optimal but infeasible** and works toward feasibility while maintaining optimality.

### Key Differences from Primal Simplex

| Aspect | Primal Simplex | Dual Simplex |
|--------|---------------|--------------|
| **Starting Point** | Feasible, Non-optimal | Optimal, Infeasible |
| **Pivot Row Selection** | Most negative z-coefficient | Most negative RHS value |
| **Pivot Column Selection** | Ratio test (RHS/column) | Ratio test (z-value/row value) |
| **Goal** | Reach optimality | Reach feasibility |

---

## When to Use Dual Simplex

### Ideal Scenarios:
1. **Minimization problems** with ≥ constraints
2. **Problems with negative RHS values** after converting to standard form
3. **Sensitivity analysis** when adding new constraints
4. **Post-optimal analysis** scenarios

### Problem Characteristics:
- **Objective**: Usually minimization
- **Constraints**: Primarily ≥ inequalities
- **Variables**: Non-negative
- **Special feature**: Creates negative RHS values in initial tableau

---

## Canonical Form for Dual Simplex

### Conversion Rules

#### For ≥ Constraints (Most Common):
**Original**: ax ≥ b
1. **Subtract excess variable**: ax - e = b
2. **Multiply by -1**: -ax + e = -b
3. **Result**: Excess variable enters as basic variable with negative RHS

#### For ≤ Constraints:
**Original**: ax ≤ b
- **Add slack variable**: ax + s = b
- **Result**: Standard slack variable handling

#### For = Constraints:
**Original**: ax = b
1. **Split into two constraints**:
   - ax ≤ b (becomes ax + s = b)
   - ax ≥ b (becomes -ax + e = -b)
2. **Apply respective rules above**

### Example Conversion Process

**Original Problem**:
```
Max z = 100x₁ + 30x₂
Subject to:
  x₂ ≥ 3         (government regulation)
  x₁ + x₂ ≤ 7    (acres available)
  10x₁ + 4x₂ ≤ 40 (labor hours)
  x₁, x₂ ≥ 0
```

**Canonical Form**:
```
(z) - 100x₁ - 30x₂ = 0
-x₂ + e₁ = -3          (from x₂ ≥ 3)
x₁ + x₂ + s₂ = 7       (from x₁ + x₂ ≤ 7)
10x₁ + 4x₂ + s₃ = 40   (from 10x₁ + 4x₂ ≤ 40)
```

---

## Dual Simplex Algorithm Steps

### Step 1: Check Feasibility
- **If all RHS values ≥ 0**: Solution is optimal and feasible (DONE)
- **If any RHS value < 0**: Continue to Step 2

### Step 2: Select Pivot Row (Leaving Variable)
- **Rule**: Choose the row with the **most negative RHS value**
- **Reason**: This gives the biggest improvement toward feasibility
- **Tie-breaking**: Choose arbitrarily or use smallest subscript

### Step 3: Select Pivot Column (Entering Variable) - Manual Dual Ratio Test

#### Manual Process for Pivot Column Selection:
1. **Identify pivot row** (row with most negative RHS)
2. **Examine all coefficients** in the pivot row  
3. **Only consider negative coefficients** - positive coefficients are ignored
4. **Calculate ratios manually**:
   - For each negative coefficient aᵢⱼ in pivot row
   - Calculate: |z-row coefficient| ÷ |pivot row coefficient|
   - Example: If z-row has -30 and pivot row has -2, ratio = 30 ÷ 2 = 15

#### Step-by-Step Manual Calculation:
1. **List all variables** with negative coefficients in pivot row
2. **Write down each ratio**: |cⱼ| / |aᵢⱼ| where aᵢⱼ < 0
3. **Choose smallest ratio** - this determines entering variable
4. **Tie-breaking**: If ratios are equal, choose leftmost variable
5. **No negative coefficients**: Problem is infeasible - STOP

### Step 4: Manual Pivot Operations

#### Manual Row Operations Process:
1. **Identify pivot element** (intersection of pivot row and pivot column)
2. **Calculate new pivot row** by hand:
   - Divide each element in pivot row by pivot element
   - New pivot row = [old element₁ ÷ pivot, old element₂ ÷ pivot, ...]

3. **Update all other rows manually**:
   - For each other row: New row = Old row - (multiplier × new pivot row)  
   - Multiplier = pivot column coefficient in that row

#### Example Manual Calculation:
If pivot element is -2 and pivot row is [0, -2, 1, 0, -3]:
- **New pivot row**: [0÷(-2), (-2)÷(-2), 1÷(-2), 0÷(-2), (-3)÷(-2)] = [0, 1, -0.5, 0, 1.5]

For updating z-row with coefficient -30 in pivot column:
- **New z-row** = Old z-row - (-30 × new pivot row)
- **New z-row** = Old z-row + 30 × [0, 1, -0.5, 0, 1.5]

### Step 5: Update Tableau and Repeat
- Return to Step 1 with new tableau

---

## Worked Example: Farmer Brown's Planning

### Problem Statement
Farmer Brown needs to decide how many acres of wheat (x₁) and corn (x₂) to plant.

**Resource Details**:
- **Wheat**: 25 bushels/acre, 10 labor hours/week, R4/bushel
- **Corn**: 10 bushels/acre, 4 labor hours/week, R3/bushel
- **Revenue per acre**: Wheat = 25 × R4 = R100, Corn = 10 × R3 = R30

**Constraints**:
- **Land**: 7 acres available
- **Labor**: 40 hours/week available  
- **Government**: At least 30 bushels of corn = 3 acres minimum

### Mathematical Formulation
```
Maximize z = 100x₁ + 30x₂

Subject to:
  x₂ ≥ 3           (government requirement)
  x₁ + x₂ ≤ 7      (land constraint)
  10x₁ + 4x₂ ≤ 40  (labor constraint)
  x₁, x₂ ≥ 0
```

### Iteration 1: Initial Dual Simplex Tableau

| t-1 | x₁  | x₂  | e₁ | s₂ | s₃ | rhs | θ        |
|-----|-----|-----|----|----|----|----|----------|
| z   | -100| -30 | 0  | 0  | 0  | 0   |          |
| 1   | 0   | -1  | 1  | 0  | 0  | -3  | **Selected** |
| 2   | 1   | 1   | 0  | 1  | 0  | 7   |          |
| 3   | 10  | 4   | 0  | 0  | 1  | 40  |          |

**Manual Analysis Process**:
1. **Step 1**: Check feasibility - Row 1 has RHS = -3 < 0, continue
2. **Step 2**: Select pivot row - Row 1 has only negative RHS (-3), select Row 1
3. **Step 3**: Manual dual ratio test for pivot column:
   - Row 1 coefficients: [0, -1, 1, 0, 0] 
   - Only x₂ has negative coefficient (-1)
   - Z-row coefficient for x₂: -30
   - Ratio calculation: |(-30)| ÷ |(-1)| = 30 ÷ 1 = 30
   - **Pivot column**: x₂ (only option)
4. **Step 4**: **Pivot element**: -1 (intersection of Row 1 and x₂ column)

### Iteration 2: After First Pivot

| t-2 | x₁  | x₂ | e₁ | s₂ | s₃ | rhs | Ratio Test |
|-----|-----|----|----|----|----|----|------------|
| z   | -100| 0  | -30| 0  | 0  | 90  |            |
| 1   | 0   | 1  | -1 | 0  | 0  | 3   |            |
| 2   | 1   | 0  | 1  | 1  | 0  | 4   | 4/1 = 4    |
| 3   | 10  | 0  | 4  | 0  | 1  | 28  | 28/10 = 2.8|

**Manual Analysis Process**:
1. **Step 1**: Check feasibility - All RHS ≥ 0: [90, 3, 4, 28] ✓ Feasible!
2. **Dual phase complete** - Switch to Primal Simplex Method
3. **Check optimality**: Z-row has -100 coefficient (still not optimal)
4. **Manual Primal Simplex**:
   - **Pivot column**: x₁ (most negative z-coefficient: -100)
   - **Manual ratio test**: 
     * Row 2: 4 ÷ 1 = 4
     * Row 3: 28 ÷ 10 = 2.8 (smallest)
   - **Pivot row**: Row 3 (smallest ratio)
   - **Pivot element**: 10

### Iteration 3: Final Optimal Tableau

| t-3 | x₁ | x₂ | e₁  | s₂   | s₃  | rhs  |
|-----|----|----|-----|------|-----|------|
| z   | 0  | 0  | 10  | 0    | 10  | 370  |
| 1   | 0  | 1  | -1  | 0    | 0   | 3    |
| 2   | 0  | 0  | 3/5 | 1    | -1/10| 1⅕  |
| 3   | 1  | 0  | 2/5 | 0    | 1/10| 2⅘   |

**Optimal Solution**:
- **x₁ = 2⅘ acres of wheat**
- **x₂ = 3 acres of corn**
- **Maximum revenue = R370**

---

## Two-Phase Process: Dual to Primal

### Phase 1: Dual Simplex (Achieve Feasibility)
**Objective**: Eliminate negative RHS values
- **Pivot row**: Most negative RHS
- **Pivot column**: Dual ratio test
- **Continue until**: All RHS ≥ 0

### Phase 2: Primal Simplex (Maintain Optimality)
**Objective**: Optimize while maintaining feasibility
- **Pivot column**: Most negative z-coefficient
- **Pivot row**: Standard ratio test
- **Continue until**: All z-coefficients ≥ 0

### Transition Point
The algorithm automatically switches from Dual to Primal when:
- **All RHS values become non-negative** (feasible)
- **But z-row still has negative coefficients** (not optimal)

---

## Practice Exercises

### Exercise 1: Korean Auto Advertising

**Problem Statement**:
Korean Auto wants to minimize advertising costs while reaching target audiences.

**Advertising Details**:
- **Comedy ads**: ₩50,000 each, reach 7M high-income women + 2M high-income men
- **Football ads**: ₩100,000 each, reach 2M high-income women + 12M high-income men

**Requirements**:
- At least 28M high-income women
- At least 24M high-income men

**Mathematical Model**:
```
Minimize z = 50x₁ + 100x₂

Subject to:
  7x₁ + 2x₂ ≥ 28   (women requirement)
  2x₁ + 12x₂ ≥ 24  (men requirement)
  x₁, x₂ ≥ 0
```

**Why Dual Simplex?**
- Minimization problem
- All ≥ constraints
- Will create negative RHS values

### Exercise 2: Freshman's Diet Problem

**Problem Statement**:
Minimize cost while meeting nutritional requirements.

**Food Options and Costs**:

| Food | Cost | Calories | Chocolate (g) | Sugar (g) | Fat (g) |
|------|------|----------|---------------|-----------|---------|
| Brownie | 50¢ | 400 | 3 | 2 | 2 |
| Chocolate Ice Cream | 20¢ | 200 | 2 | 2 | 4 |
| Cola | 30¢ | 150 | 0 | 4 | 1 |
| Pineapple Cheesecake | 80¢ | 500 | 0 | 4 | 5 |

**Requirements**:
- At least 500 calories
- At least 6g chocolate
- At least 10g sugar
- At least 8g fat

**Mathematical Model**:
```
Minimize z = 50x₁ + 20x₂ + 30x₃ + 80x₄

Subject to:
  400x₁ + 200x₂ + 150x₃ + 500x₄ ≥ 500  (calories)
  3x₁ + 2x₂ + 0x₃ + 0x₄ ≥ 6            (chocolate)
  2x₁ + 2x₂ + 4x₃ + 4x₄ ≥ 10            (sugar)
  2x₁ + 4x₂ + 1x₃ + 5x₄ ≥ 8             (fat)
  x₁, x₂, x₃, x₄ ≥ 0
```

**Solution Steps**:
1. Convert to canonical form (create negative RHS)
2. Apply Dual Simplex until feasible
3. Switch to Primal Simplex for optimality
4. Interpret nutritional solution

---

## Key Takeaways

### When Dual Simplex is Preferred
1. **Minimization problems** with ≥ constraints
2. **Sensitivity analysis** scenarios
3. **Problems starting with infeasible solutions**
4. **Resource allocation** with minimum requirements

### Algorithm Benefits
- **Efficient for certain problem types**
- **Maintains optimality** throughout process
- **Natural for minimum requirement problems**
- **Avoids artificial variables** in many cases

### Common Mistakes to Avoid
1. **Wrong pivot row selection** - must be most negative RHS
2. **Incorrect ratio test** - use absolute values and z-coefficients
3. **Missing the transition** from Dual to Primal phase
4. **Forgetting excess variable rules** when converting ≥ constraints

### Manual Excel Implementation Tips

#### Setting Up Manual Calculations
1. **Create separate calculation area** for ratio tests
2. **Use manual formulas** like `=D2/E2` for individual ratios
3. **Track pivot elements** in a separate column
4. **Document each step** for verification

#### Manual Dual Simplex Checklist
- [ ] **Identify most negative RHS** - mark as pivot row
- [ ] **List negative coefficients** in pivot row only
- [ ] **Calculate each ratio** by hand: |z-coeff| ÷ |pivot-coeff|  
- [ ] **Choose smallest ratio** - mark as pivot column
- [ ] **Perform row operations** step by step
- [ ] **Verify feasibility** after each iteration

#### Phase Transition Recognition
- **Dual phase**: Any RHS < 0, use dual ratio test
- **Primal phase**: All RHS ≥ 0, use regular ratio test  
- **Optimal**: All RHS ≥ 0 AND all z-coefficients ≥ 0 (for maximization)

---

*This guide is based on the Belgium Campus Linear Programming course materials and focuses on practical application of the Dual Simplex Method.*