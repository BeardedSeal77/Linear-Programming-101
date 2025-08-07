# Linear Programming Canonical Forms - Step-by-Step Walkthrough

## Table of Contents
1. [Theory & Definitions](#theory--definitions)
2. [Example Problems](#example-problems)
3. [Standard Form Conversions](#standard-form-conversions)
4. [Canonical Form Conversions](#canonical-form-conversions)
5. [Excel Verification Guide](#excel-verification-guide)

---

## Theory & Definitions

### Standard Form
A linear programming problem is in **Standard Form** when:
- **Objective**: Minimize z = c₁x₁ + c₂x₂ + ... + cₙxₙ
- **Constraints**: All are equalities (=)
- **Variables**: All variables ≥ 0 (non-negative)

### Canonical Form

#### For Maximization Problems:
- **Objective**: Maximize z = c₁x₁ + c₂x₂ + ... + cₙxₙ
- **Constraints**: All are ≤ inequalities
- **Variables**: All variables ≥ 0 (non-negative)

#### For Minimization Problems:
- **Objective**: Minimize z = c₁x₁ + c₂x₂ + ... + cₙxₙ
- **Constraints**: All are ≥ inequalities
- **Variables**: All variables ≥ 0 (non-negative)

### Key Conversion Rules
1. **Max ↔ Min**: Maximize z = c₁x₁ + c₂x₂ becomes Minimize z = -c₁x₁ - c₂x₂
2. **Flip inequality**: a₁x₁ + a₂x₂ ≤ b becomes -a₁x₁ - a₂x₂ ≥ -b
3. **Split equality**: a₁x₁ + a₂x₂ = b becomes two constraints: ≤ b AND ≥ b
4. **Add slack variable**: a₁x₁ + a₂x₂ ≤ b becomes a₁x₁ + a₂x₂ + s = b, s ≥ 0
5. **Add surplus variable**: a₁x₁ + a₂x₂ ≥ b becomes a₁x₁ + a₂x₂ - r = b, r ≥ 0

---

## Example Problems

### Example 1: Maximization Problem (Production Planning)

**Business Context**: A company produces chairs and tables
- Profit: $40 per chair, $30 per table
- Labor: 2 hours per chair, 3 hours per table, 120 hours available
- Material: 1 unit per chair, 2 units per table, 60 units available  
- Demand: At most 50 chairs can be sold

**Mathematical Formulation**:
```
Maximize z = 40x₁ + 30x₂

Subject to:
  2x₁ + 3x₂ ≤ 120    (labor constraint)
  x₁ + 2x₂ ≤ 60      (material constraint)
  x₁ ≤ 50            (demand constraint)
  x₁, x₂ ≥ 0         (non-negativity)
```

**Manual Setup for Excel Tables:**
- Set up decision variables x₁ (chairs) and x₂ (tables) in columns
- List constraints in rows with coefficients and constraint types
- All constraints are ≤ inequalities for this canonical form

### Example 2: Minimization Problem (Transportation Cost)

**Business Context**: Transport goods from warehouses to meet demands
- Cost: $8 per unit from warehouse 1, $12 per unit from warehouse 2
- Minimum from warehouse 1: 20 units
- Minimum from warehouse 2: 15 units
- Total minimum demand: 50 units

**Mathematical Formulation**:
```
Minimize z = 8x₁ + 12x₂

Subject to:
  x₁ ≥ 20           (warehouse 1 minimum)
  x₂ ≥ 15           (warehouse 2 minimum)
  x₁ + x₂ ≥ 50      (total demand)
  x₁, x₂ ≥ 0        (non-negativity)
```

**Manual Setup for Excel Tables:**
- Set up decision variables x₁ and x₂ in columns
- List constraints in rows with coefficients and constraint types
- All constraints are ≥ inequalities for this canonical form

---

## Standard Form Conversions

### Converting Maximization Example to Standard Form

**Goal**: Convert to Minimize cx, Ax = b, x ≥ 0

#### Step 1: Convert Maximization to Minimization
- **Original**: Maximize 40x₁ + 30x₂
- **Standard**: Minimize -40x₁ - 30x₂
- **New c**: [-40, -30]

#### Step 2: Convert Inequalities to Equalities (Add Slack Variables)

**Constraint 1**: 2x₁ + 3x₂ ≤ 120
- Add slack variable s₁ ≥ 0
- **Becomes**: 2x₁ + 3x₂ + s₁ = 120

**Constraint 2**: x₁ + 2x₂ ≤ 60
- Add slack variable s₂ ≥ 0
- **Becomes**: x₁ + 2x₂ + s₂ = 60

**Constraint 3**: x₁ ≤ 50
- Add slack variable s₃ ≥ 0
- **Becomes**: x₁ + s₃ = 50

#### Final Standard Form:
```
Minimize z = -40x₁ - 30x₂ + 0s₁ + 0s₂ + 0s₃

Subject to:
  2x₁ + 3x₂ + 1s₁ + 0s₂ + 0s₃ = 120
  1x₁ + 2x₂ + 0s₁ + 1s₂ + 0s₃ = 60
  1x₁ + 0x₂ + 0s₁ + 0s₂ + 1s₃ = 50
  x₁, x₂, s₁, s₂, s₃ ≥ 0
```

**Manual Excel Table Setup**:
- Create columns for: x₁, x₂, s₁, s₂, s₃, RHS
- Row 1: Objective coefficients: [-40, -30, 0, 0, 0, 0]
- Row 2: Constraint 1: [2, 3, 1, 0, 0, 120]
- Row 3: Constraint 2: [1, 2, 0, 1, 0, 60]
- Row 4: Constraint 3: [1, 0, 0, 0, 1, 50]

### Converting Minimization Example to Standard Form

**Goal**: Convert to Minimize cx, Ax = b, x ≥ 0

#### Step 1: Objective Already Minimization
- **Keep**: Minimize 8x₁ + 12x₂
- **c remains**: [8, 12]

#### Step 2: Convert Inequalities to Equalities (Add Surplus Variables)

**Constraint 1**: x₁ ≥ 20
- Add surplus variable r₁ ≥ 0
- **Becomes**: x₁ - r₁ = 20

**Constraint 2**: x₂ ≥ 15
- Add surplus variable r₂ ≥ 0
- **Becomes**: x₂ - r₂ = 15

**Constraint 3**: x₁ + x₂ ≥ 50
- Add surplus variable r₃ ≥ 0
- **Becomes**: x₁ + x₂ - r₃ = 50

#### Final Standard Form:
```
Minimize z = 8x₁ + 12x₂ + 0r₁ + 0r₂ + 0r₃

Subject to:
  1x₁ + 0x₂ - 1r₁ + 0r₂ + 0r₃ = 20
  0x₁ + 1x₂ + 0r₁ - 1r₂ + 0r₃ = 15
  1x₁ + 1x₂ + 0r₁ + 0r₂ - 1r₃ = 50
  x₁, x₂, r₁, r₂, r₃ ≥ 0
```

**Manual Excel Table Setup**:
- Create columns for: x₁, x₂, r₁, r₂, r₃, RHS
- Row 1: Objective coefficients: [8, 12, 0, 0, 0, 0]
- Row 2: Constraint 1: [1, 0, -1, 0, 0, 20]
- Row 3: Constraint 2: [0, 1, 0, -1, 0, 15]
- Row 4: Constraint 3: [1, 1, 0, 0, -1, 50]

---

## Canonical Form Conversions

### Converting Maximization Example to Canonical Form

**Goal**: Convert to Maximize cx, Ax ≤ b, x ≥ 0

#### Analysis:
- **Objective**: Already maximization ✓
- **Constraints**: All are ≤ ✓
- **Variables**: Already ≥ 0 ✓

#### Result:
**Already in canonical form!** No changes needed.

```
Maximize z = 40x₁ + 30x₂

Subject to:
  2x₁ + 3x₂ ≤ 120
  x₁ + 2x₂ ≤ 60
  x₁ ≤ 50
  x₁, x₂ ≥ 0
```

### Converting Minimization Example to Canonical Form

**Goal**: Convert to Minimize cx, Ax ≥ b, x ≥ 0

#### Analysis:
- **Objective**: Already minimization ✓
- **Constraints**: All are ≥ ✓
- **Variables**: Already ≥ 0 ✓

#### Result:
**Already in canonical form!** No changes needed.

```
Minimize z = 8x₁ + 12x₂

Subject to:
  x₁ ≥ 20
  x₂ ≥ 15
  x₁ + x₂ ≥ 50
  x₁, x₂ ≥ 0
```

### Example: Converting Mixed Constraints

**Suppose we had**: Maximize 3x₁ + 2x₂
```
Subject to:
  x₁ + x₂ ≤ 10
  2x₁ - x₂ ≥ 4
  x₁ + 2x₂ = 8
  x₁, x₂ ≥ 0
```

#### Converting to Canonical Form (Max, all ≤):

**Constraint 1**: x₁ + x₂ ≤ 10 → **Keep as is**

**Constraint 2**: 2x₁ - x₂ ≥ 4 → **Multiply by -1**
- Becomes: -2x₁ + x₂ ≤ -4

**Constraint 3**: x₁ + 2x₂ = 8 → **Split into two inequalities**
- x₁ + 2x₂ ≤ 8 (keep)
- x₁ + 2x₂ ≥ 8 → multiply by -1 → -x₁ - 2x₂ ≤ -8

#### Final Canonical Form:
```
Maximize z = 3x₁ + 2x₂

Subject to:
  x₁ + x₂ ≤ 10
  -2x₁ + x₂ ≤ -4
  x₁ + 2x₂ ≤ 8
  -x₁ - 2x₂ ≤ -8
  x₁, x₂ ≥ 0
```

---

## Manual W-Form Setup in Excel

### What is W-Form?
W-form (Working form) is the standard tableau format used for manual simplex method calculations. It organizes all problem data into a systematic table structure for step-by-step solution.

### Step-by-Step W-Form Setup Process

#### Step 1: Create the Basic Table Structure
1. **Set up columns**: Create headers for all variables (decision + slack/surplus) plus RHS
2. **Set up rows**: Create rows for objective function and each constraint
3. **Label clearly**: Use consistent variable names throughout

#### Step 2: Enter Objective Function Row
1. **Place objective coefficients** in first row under variable columns
2. **For maximization**: Enter coefficients as negative values (-c₁, -c₂, ...)
3. **For minimization**: Enter coefficients as positive values (c₁, c₂, ...)
4. **Slack/surplus variables**: Always enter as 0 in objective row

#### Step 3: Enter Constraint Rows  
1. **Copy constraint coefficients** exactly as they appear in standard form
2. **Include slack variables**: Enter 1 in appropriate column, 0 elsewhere
3. **Include surplus variables**: Enter -1 in appropriate column, 0 elsewhere
4. **Enter RHS values** in the rightmost column

#### Step 4: Manual Calculation Setup
1. **Create ratio test column** for pivot selection
2. **Set up separate area** for row operations calculations
3. **Prepare iteration tracking** to record each tableau step

### Example W-Form Setup

**Problem**: 
```
Maximize z = 40x₁ + 30x₂
Subject to:
  2x₁ + 3x₂ ≤ 120
  x₁ + 2x₂ ≤ 60  
  x₁ ≤ 50
  x₁, x₂ ≥ 0
```

**Manual W-Form Table in Excel**:

| Iteration | Basis | x₁  | x₂  | s₁ | s₂ | s₃ | RHS | Ratio |
|-----------|-------|-----|-----|----|----|----|----|-------|
| T-0       | z     | -40 | -30 | 0  | 0  | 0  | 0   | -     |
|           | s₁    | 2   | 3   | 1  | 0  | 0  | 120 | 60    |
|           | s₂    | 1   | 2   | 0  | 1  | 0  | 60  | 60    |
|           | s₃    | 1   | 0   | 0  | 0  | 1  | 50  | 50    |

### Manual Pivot Selection Rules

#### Entering Variable (Column Selection)
1. **For maximization**: Choose column with most negative coefficient in z-row
2. **For minimization**: Choose column with most positive coefficient in z-row
3. **Tie-breaking**: Choose leftmost column if coefficients are equal

#### Leaving Variable (Row Selection) 
1. **Calculate ratios**: RHS value ÷ pivot column value (only for positive pivot values)
2. **Choose smallest ratio**: This determines the leaving variable
3. **Tie-breaking**: Choose topmost row if ratios are equal
4. **Ignore negative ratios**: These don't impose constraints

### Manual Row Operations Process

#### Step 1: New Pivot Row Calculation
```
New pivot row = Old pivot row ÷ pivot element
```

#### Step 2: All Other Rows Calculation
```
New row = Old row - (pivot column coefficient × new pivot row)
```

#### Step 3: Manual Calculation Example
If pivot element is 3 in position (2,2):
1. **New row 2**: Divide entire row 2 by 3
2. **Row 1 update**: Row 1 - (-30 × new row 2)
3. **Row 3 update**: Row 3 - (0 × new row 2) = no change
4. **Row 4 update**: Row 4 - (0 × new row 2) = no change

## Excel Verification Guide

### Setting Up Your Excel Worksheet

#### Step 1: Problem Setup
1. **Create sections** for original problem, standard form, and canonical form
2. **Use clear headers** for each transformation step
3. **Color-code** different constraint types (≤, ≥, =)

#### Step 2: Matrix Representation
1. **Coefficient matrix (A)**: One section for original, one for transformed
2. **Objective vector (c)**: Show before and after transformations
3. **RHS vector (b)**: Display constraint values
4. **Variable labels**: Include slack/surplus variables

### Verification Checklist

#### For Standard Form:
- [ ] **Objective is minimization**
- [ ] **All constraints are equalities (=)**
- [ ] **All variables ≥ 0**
- [ ] **Slack variables added for ≤ constraints** (coefficient +1)
- [ ] **Surplus variables added for ≥ constraints** (coefficient -1)
- [ ] **Slack/surplus variables have 0 cost** in objective

#### For Canonical Form:
- [ ] **Maximization**: All constraints are ≤
- [ ] **Minimization**: All constraints are ≥
- [ ] **No artificial variables needed**
- [ ] **All variables ≥ 0**
- [ ] **Matrix dimensions match** (variables vs constraints)

### Step-by-Step Excel Process

#### Converting to Standard Form:
1. **Copy original problem** to new section
2. **Negate objective coefficients** if maximizing
3. **Add slack columns** for ≤ constraints
4. **Add surplus columns** for ≥ constraints (with -1 coefficients)
5. **Verify matrix dimensions** match
6. **Check all entries** against conversion rules

#### Converting to Canonical Form:
1. **Check current form** against canonical requirements
2. **Multiply constraints by -1** as needed to flip inequalities
3. **Split equality constraints** into two inequalities
4. **Verify all constraints** have correct inequality direction
5. **Confirm objective direction** matches canonical form

### Manual Calculation Guidelines

#### Negating Objective Function:
- **By hand**: Change the sign of each coefficient
- **Example**: 40x₁ + 30x₂ becomes -40x₁ - 30x₂

#### Adding Slack Variables:
- **For ≤ constraints**: Add +1 in the slack column for that constraint
- **Example**: x₁ + x₂ ≤ 10 becomes x₁ + x₂ + s₁ = 10

#### Adding Surplus Variables:
- **For ≥ constraints**: Add -1 in the surplus column for that constraint  
- **Example**: x₁ + x₂ ≥ 8 becomes x₁ + x₂ - r₁ = 8

#### Flipping Inequality:
- **Rule**: Multiply entire constraint by -1 when converting ≥ to ≤
- **Example**: x₁ + x₂ ≥ 8 becomes -x₁ - x₂ ≤ -8

### Manual Verification Checklist

#### Check Standard Form:
- [ ] **Objective is minimization**
- [ ] **All constraints are equalities (=)**  
- [ ] **All variables ≥ 0**
- [ ] **Count slack variables**: Should equal number of ≤ constraints in original
- [ ] **Count surplus variables**: Should equal number of ≥ constraints in original

#### Check Canonical Form:
- [ ] **Maximization problems**: All constraints should be ≤
- [ ] **Minimization problems**: All constraints should be ≥
- [ ] **All variables ≥ 0**
- [ ] **No slack/surplus variables added yet**

### Common Mistakes to Avoid:

1. **Forgetting to negate objective** when converting Max to Min
2. **Wrong sign on surplus variables** (should be -1)
3. **Forgetting to flip inequality** when multiplying by -1
4. **Not splitting equality constraints** properly
5. **Adding slack/surplus to wrong constraints**
6. **Inconsistent variable bounds** (not all ≥ 0)
7. **Matrix dimension mismatches** after adding variables

### Troubleshooting Guide

#### If Standard Form Verification Fails:
1. **Check objective direction** (should be minimization)
2. **Verify all constraints are equalities**
3. **Confirm slack/surplus variables** have correct signs
4. **Ensure no artificial variables** are present

#### If Canonical Form Verification Fails:
1. **Match inequality direction** with objective type
2. **Check for mixed constraint types**
3. **Verify equality constraints** were split properly
4. **Confirm all coefficients** after transformations

---

*This walkthrough provides a systematic approach to converting between LP forms. Use the Excel verification steps to ensure accuracy and build confidence in your transformations.*