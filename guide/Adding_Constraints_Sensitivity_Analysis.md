# Adding Constraints - Sensitivity Analysis Guide

## Table of Contents
1. [Introduction to Sensitivity Analysis](#introduction-to-sensitivity-analysis)
2. [When to Add Constraints](#when-to-add-constraints)
3. [The Three-Step Process](#the-three-step-process)
4. [Example 1: Adding ≤ Constraint (No Conflict)](#example-1-adding--constraint-no-conflict)
5. [Example 2: Adding ≤ Constraint (With Conflict)](#example-2-adding--constraint-with-conflict)
6. [Example 3: Adding ≥ Constraint (With Conflict)](#example-3-adding--constraint-with-conflict)
7. [Conflict Resolution Strategies](#conflict-resolution-strategies)
8. [Practice Exercises](#practice-exercises)

---

## Introduction to Sensitivity Analysis

### What is Sensitivity Analysis?
**Sensitivity Analysis** examines how changes to a linear programming model affect the optimal solution. One common scenario is **adding new constraints** to an already solved problem.

### Why Add Constraints?
- **Business rule changes**: New regulations or policies
- **Resource limitations**: Additional restrictions discovered
- **Market conditions**: New requirements or limitations
- **Post-optimal analysis**: "What if" scenarios

### Starting Point
We begin with the **optimal tableau** from the original problem and modify it to include the new constraint, avoiding the need to resolve from scratch.

---

## When to Add Constraints

### Scenarios for Adding Constraints:
1. **Management decisions**: Maximum/minimum production levels
2. **Regulatory requirements**: Government-imposed limits
3. **Resource discoveries**: Additional capacity constraints
4. **Market research**: New demand restrictions
5. **Cost considerations**: Budget limitations

### Types of New Constraints:
- **≤ constraints**: Maximum limits (add slack variables)
- **≥ constraints**: Minimum requirements (add excess variables)
- **= constraints**: Exact requirements (convert to two inequalities)

---

## The Three-Step Process

### Step 1: Write Constraint in Canonical Form
- **For ≤**: Add slack variable (s)
- **For ≥**: Subtract excess variable (e), then multiply by -1
- **For =**: Split into ≤ and ≥ constraints

### Step 2: Check for Variable Conflicts
- **Conflict occurs** when a basic variable in the optimal solution becomes non-basic in the new constraint
- **Identify conflicts**: Look for basic variables that appear in the new constraint row
- **Resolution required**: Must eliminate conflicts before proceeding

### Step 3: Ensure New Variable is Basic
- **Slack/excess variable** must enter as a basic variable
- **Add new row** to the optimal tableau
- **Continue with simplex** if infeasible or non-optimal

---

## Example 1: Adding ≤ Constraint (No Conflict)

### Starting Point: Limpopo Furniture Optimal Solution

**Original Problem**:
```
Maximize z = 60x₁ + 30x₂ + 20x₃

Subject to:
  8x₁ + 6x₂ + 1x₃ ≤ 48   (lumber)
  4x₁ + 2x₂ + 1.5x₃ ≤ 20 (finishing)
  2x₁ + 1.5x₂ + 0.5x₃ ≤ 8 (carpentry)
  x₁, x₂, x₃ ≥ 0
```

**Optimal Solution**:
- x₁ = 2 desks, x₂ = 0 tables, x₃ = 8 chairs
- Maximum revenue = R280

**Optimal Tableau**:
| T* | x₁ | x₂  | x₃ | s₁ | s₂ | s₃  | RHS |
|----|----|----|----|----|----|----- |-----|
| z  | 0  | 5  | 0  | 0  | 10 | 10  | 280 |
| 1  | 0  | -2 | 0  | 1  | 2  | -8  | 24  |
| 2  | 0  | -2 | 1  | 0  | 2  | -4  | 8   |
| 3  | 1  | 1¼ | 0  | 0  | -½ | 1½  | 2   |

### Adding New Constraint: x₂ ≤ 5 (Tables limited to 5)

#### Step 1: Write in Canonical Form
**New constraint**: x₂ ≤ 5
**Canonical form**: x₂ + s₄ = 5

#### Step 2: Check for Conflicts
**Current basic variables**: s₁, x₃, x₁
**New constraint involves**: x₂ (non-basic)
**Result**: **No conflict** - x₂ is already non-basic

#### Step 3: Add to Tableau
| T* | x₁ | x₂  | x₃ | s₁ | s₂ | s₃  | s₄ | RHS |
|----|----|----|----|----|----|----- |----|-----|
| z  | 0  | 5  | 0  | 0  | 10 | 10  | 0  | 280 |
| 1  | 0  | -2 | 0  | 1  | 2  | -8  | 0  | 24  |
| 2  | 0  | -2 | 1  | 0  | 2  | -4  | 0  | 8   |
| 3  | 1  | 1¼ | 0  | 0  | -½ | 1½  | 0  | 2   |
| 4  | 0  | 1  | 0  | 0  | 0  | 0   | 1  | 5   |

**Result**: 
- **Solution remains optimal** (all z-coefficients ≥ 0)
- **Constraint is not binding** (x₂ = 0 < 5)
- **No change in optimal solution**

---

## Example 2: Adding ≤ Constraint (With Conflict)

### Adding New Constraint: x₃ ≤ 5 (Chairs limited to 5)

#### Step 1: Write in Canonical Form
**New constraint**: x₃ ≤ 5
**Canonical form**: x₃ + s₄ = 5

#### Step 2: Check for Conflicts
**Current basic variables**: s₁, x₃, x₁
**New constraint involves**: x₃ (basic variable in row 2)
**Result**: **Conflict detected** - x₃ appears in both row 2 and new row 4

#### Step 3: Resolve Conflict Using Row Operations

**Initial setup**:
| Row | x₁ | x₂  | x₃ | s₁ | s₂ | s₃  | s₄ | RHS |
|-----|----|----|----|----|----|----- |----|-----|
| 2   | 0  | -2 | 1  | 0  | 2  | -4  | 0  | 8   |
| 4   | 0  | 0  | 1  | 0  | 0  | 0   | 1  | 5   |

**Row operation**: Row 2 - Row 4
| New Row 2 | x₁ | x₂  | x₃ | s₁ | s₂ | s₃  | s₄ | RHS |
|-----------|----|----|----|----|----|----- |----|-----|
| 2         | 0  | -2 | 0  | 0  | 2  | -4  | -1 | 3   |

#### Final Updated Tableau:
| T* | x₁ | x₂  | x₃ | s₁ | s₂ | s₃  | s₄ | RHS |
|----|----|----|----|----|----|----- |----|-----|
| z  | 0  | 5  | 0  | 0  | 10 | 10  | 0  | 280 |
| 1  | 0  | -2 | 0  | 1  | 2  | -8  | 0  | 24  |
| 2  | 0  | -2 | 0  | 0  | 2  | -4  | -1 | 3   |
| 3  | 1  | 1¼ | 0  | 0  | -½ | 1½  | 0  | 2   |
| 4  | 0  | 0  | 1  | 0  | 0  | 0   | 1  | 5   |

**Analysis**:
- **Negative RHS** in row 4: -3 (infeasible)
- **Apply Dual Simplex**: Use dual simplex to restore feasibility
- **Final result**: New optimal solution with x₃ = 5 (constraint is binding)

#### After Dual Simplex Resolution:
| t-* | x₁ | x₂  | x₃ | s₁ | s₂ | s₃  | s₄ | RHS |
|-----|----|----|----|----|----|----- |----|-----|
| z   | 0  | 15 | 0  | 0  | 0  | 30  | 5  | 265 |
| 1   | 0  | 0  | 0  | 1  | 0  | -4  | 1  | 21  |
| 2   | 0  | 0  | 1  | 0  | 0  | 0   | 1  | 5   |
| 3   | 1  | ¾  | 0  | 0  | 0  | ½   | -¼ | 2¾  |
| 4   | 0  | -1 | 0  | 0  | 1  | -2  | -½ | 1½  |

**New Optimal Solution**:
- x₁ = 2¾ desks, x₂ = 0 tables, x₃ = 5 chairs
- Maximum revenue = R265 (reduced from R280)
- **Constraint impact**: Revenue decreased by R15

---

## Example 3: Adding ≥ Constraint (With Conflict)

### Adding New Constraint: x₁ ≥ 1 (Minimum 1 desk)

#### Step 1: Write in Canonical Form
**Original**: x₁ ≥ 1
**Subtract excess**: x₁ - e₄ = 1
**Multiply by -1**: -x₁ + e₄ = -1

#### Step 2: Check for Conflicts
**Current basic variables**: s₁, x₃, x₁
**New constraint involves**: x₁ (basic variable in row 3)
**Result**: **Conflict detected**

#### Step 3: Resolve Conflict Using Row Operations

**Row operation**: Row 3 - Row 4
- **Row 3**: [1, 1¼, 0, 0, -½, 1½, 0] = 2
- **Row 4**: [1, 0, 0, 0, 0, 0, -1] = 1  
- **Result**: [0, 1¼, 0, 0, -½, 1½, 1] = 1

#### Final Updated Tableau:
| T* | x₁ | x₂  | x₃ | s₁ | s₂ | s₃  | e₄ | RHS |
|----|----|----|----|----|----|----- |----|-----|
| z  | 0  | 5  | 0  | 0  | 10 | 10  | 0  | 280 |
| 1  | 0  | -2 | 0  | 1  | 2  | -8  | 0  | 24  |
| 2  | 0  | -2 | 1  | 0  | 2  | -4  | 0  | 8   |
| 3  | 1  | 1¼ | 0  | 0  | -½ | 1½  | 0  | 2   |
| 4  | 0  | 1¼ | 0  | 0  | -½ | 1½  | 1  | 1   |

**Result**: 
- **Solution remains feasible and optimal**
- **Constraint is not binding** (x₁ = 2 > 1)
- **No change in optimal solution**

---

## Conflict Resolution Strategies

### Identifying Conflicts
1. **Scan new constraint row** for non-zero coefficients
2. **Check if variables are basic** in optimal tableau
3. **Mark conflicting variables** for resolution

### Resolution Methods

#### Method 1: Row Subtraction (Most Common)
- **Identify rows**: Original basic variable row and new constraint row
- **Subtract appropriately**: Eliminate conflict coefficient
- **Update tableau**: Replace conflicting row with result

#### Method 2: Variable Substitution
- **Express basic variable** in terms of non-basic variables
- **Substitute into new constraint**
- **Create conflict-free constraint**

#### Method 3: Pivot Operations
- **Use standard simplex pivoting**
- **Eliminate conflicts systematically**
- **Maintain tableau structure**

### Post-Resolution Actions
1. **Check feasibility**: Look for negative RHS values
2. **Apply appropriate method**:
   - **Dual Simplex**: If infeasible but optimal
   - **Primal Simplex**: If feasible but non-optimal
3. **Iterate until optimal and feasible**

---

## Practice Exercises

### Exercise 1: Limpopo Furniture - Minimum Tables
**Add constraint**: x₂ ≥ 1 (Minimum 1 table must be produced)

**Starting tableau**: Use the original optimal solution
```
x₁ = 2, x₂ = 0, x₃ = 8, Revenue = R280
```

**Tasks**:
1. Convert constraint to canonical form
2. Identify any conflicts with current basic variables
3. Resolve conflicts if necessary
4. Determine new optimal solution
5. Compare revenue impact

**Expected outcome**: This will force table production, likely reducing chairs and revenue.

### Exercise 2: Korean Auto Advertising Constraints

**Original Problem**:
```
Minimize z = 50x₁ + 100x₂

Subject to:
  7x₁ + 2x₂ ≥ 28  (high-income women)
  2x₁ + 12x₂ ≥ 24 (high-income men)
  x₁, x₂ ≥ 0
```

**Optimal Solution**:
| t-3* | x₁ | x₂ | e₁  | e₂   | rhs |
|------|----|----|-----|------|-----|
| z    | 0  | 0  | -5  | -7½  | 320 |
| 1    | 1  | 0  | -3/20| 1/40| 3⅗  |
| 2    | 0  | 1  | 1/40|-7/80| 1⅖  |

**Current solution**: x₁ = 3⅗ comedy ads, x₂ = 1⅖ football ads, Cost = ₩320

#### Part A: Maximum Comedy Ads
**Add constraint**: x₁ ≤ 3 (Maximum 3 comedy ads)

**Tasks**:
1. Check if constraint is currently violated
2. Add slack variable and create new row
3. Resolve any conflicts with current basic variables
4. Apply dual simplex if necessary
5. Determine impact on cost

#### Part B: Minimum Comedy Ads  
**Add constraint**: x₁ ≥ 4 (Minimum 4 comedy ads)

**Tasks**:
1. Convert to canonical form with excess variable
2. Identify conflicts (x₁ is basic in row 1)
3. Resolve using row operations
4. Check feasibility and optimality
5. Calculate new minimum cost

#### Part C: Minimum Football Ads
**Add constraint**: x₂ ≥ 2 (Minimum 2 football ads)

**Tasks**:
1. Convert to canonical form
2. Identify conflicts (x₂ is basic in row 2)  
3. Resolve conflicts systematically
4. Apply appropriate simplex method
5. Analyze cost implications

### Expected Learning Outcomes
After completing these exercises, students should be able to:
1. **Identify when constraints conflict** with existing basic variables
2. **Apply row operations** to resolve conflicts systematically
3. **Recognize when to use dual vs. primal simplex** after adding constraints
4. **Interpret the business impact** of constraint additions
5. **Handle both ≤ and ≥ constraint additions** confidently

---

## Key Takeaways

### When Adding Constraints:
1. **Always start with optimal tableau** - don't resolve from scratch
2. **Check for variable conflicts** before proceeding
3. **Use row operations** to eliminate conflicts systematically
4. **Apply appropriate simplex method** based on resulting tableau state

### Common Scenarios:
- **No conflict + feasible**: Solution unchanged
- **No conflict + infeasible**: Apply dual simplex
- **Conflict + feasible**: Resolve conflict, check optimality
- **Conflict + infeasible**: Resolve conflict, apply dual simplex

### Business Applications:
- **Sensitivity analysis**: Understanding constraint impact
- **What-if scenarios**: Testing business rule changes
- **Resource planning**: Adding newly discovered limitations
- **Regulatory compliance**: Incorporating new requirements

### Excel Implementation Tips:
- **Use absolute cell references** when copying constraint rows
- **Check tableau consistency** after row operations
- **Verify basic variable identification** in each iteration
- **Document constraint reasoning** for business interpretation

---

*This guide demonstrates practical sensitivity analysis techniques using the Limpopo Furniture Company and Korean Auto examples from the Belgium Campus Linear Programming course materials.*