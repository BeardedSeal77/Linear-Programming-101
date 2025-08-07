# Branch & Bound Method - Complete Guide

## Table of Contents
1. [Introduction to Branch & Bound](#introduction-to-branch--bound)
2. [When to Use Branch & Bound](#when-to-use-branch--bound)
3. [Core Algorithm Rules](#core-algorithm-rules)
4. [Complete Tree Visualization](#complete-tree-visualization)
5. [Step-by-Step Process](#step-by-step-process)
6. [Worked Example: Oakfield Corporation](#worked-example-oakfield-corporation)
7. [Decision Rules and Strategies](#decision-rules-and-strategies)
8. [Practice Exercises](#practice-exercises)

---

## Introduction to Branch & Bound

### What is Branch & Bound?
**Branch & Bound** is an optimization technique used to solve **Integer Programming (IP)** problems by systematically exploring the solution space through a tree-like structure.

### Key Concepts:
- **Branching**: Dividing the problem into smaller sub-problems
- **Bounding**: Using LP relaxation to establish bounds on optimal values
- **Fathoming**: Eliminating sub-problems that cannot contain the optimal solution

### The Process Overview:
1. **Solve LP Relaxation** of the original IP problem
2. **If solution is integer**: DONE (optimal IP solution found)
3. **If solution is fractional**: Branch on a fractional variable
4. **Create sub-problems** with additional constraints
5. **Repeat process** until all nodes are fathomed

---

## When to Use Branch & Bound

### Problem Types:
- **Pure Integer Programming (IP)**: All variables must be integers
- **Mixed Integer Programming (MIP)**: Some variables must be integers
- **Binary Integer Programming (BIP)**: Variables are 0 or 1

### Ideal Scenarios:
1. **Small to medium-sized problems** (computational efficiency)
2. **When LP relaxation provides good bounds**
3. **Production planning** with discrete units
4. **Resource allocation** with integer constraints
5. **Project selection** problems

---

## Core Algorithm Rules

### Rule 1: Branching Variable Selection
**Primary Rule: Choose the fractional variable closest to 0.5**
- Calculate distance from 0.5 for each fractional part
- Variable closest to 0.5 creates the most balanced branching

**Step-by-step procedure:**
1. **Identify all fractional variables** in the current solution
2. **Calculate fractional parts**: For xⱼ = k.f, fractional part = f
3. **Calculate distances from 0.5**: |fractional part - 0.5|
4. **Select variable with minimum distance**
5. **Tie-breaking rule**: If distances are equal, choose variable with smallest subscript

**Examples:**
- x₁ = 3.75, x₂ = 4.25: 
  - Fractional parts: 0.75, 0.25
  - Distances from 0.5: |0.75-0.5| = 0.25, |0.25-0.5| = 0.25
  - **Equal distances → Choose x₁ (smaller subscript)**
- x₁ = 2.3, x₂ = 5.8:
  - Fractional parts: 0.3, 0.8  
  - Distances from 0.5: |0.3-0.5| = 0.2, |0.8-0.5| = 0.3
  - **Choose x₁ (closer to 0.5)**

### Rule 2: Creating Sub-Problems
For a fractional variable xⱼ = k.f (where k is integer part, f is fractional part):
- **Sub-problem 1**: Add constraint xⱼ ≤ k (floor value)
- **Sub-problem 2**: Add constraint xⱼ ≥ k+1 (ceiling value)

**Step-by-step constraint addition procedure:**
1. **Identify fractional variable**: xⱼ = k.f
2. **Determine integer bounds**: Floor = k, Ceiling = k+1
3. **Create two constraints**:
   - Left branch: xⱼ ≤ k → xⱼ + sₙ = k (add slack)
   - Right branch: xⱼ ≥ k+1 → xⱼ - eₙ = k+1 (subtract excess)
4. **Check for basic variable conflicts** (see Conflict Resolution Rules below)

### Rule 2a: Sub-Problem Generation Procedure
**Complete step-by-step process for creating sub-problems:**

**STEP 1: Identify the Fractional Variable**
1. **Examine current LP relaxation solution**
2. **List all variables with fractional values**
3. **Apply branching variable selection rule** (closest to 0.5)
4. **Document selection rationale**

**STEP 2: Determine the Bounds**
For fractional variable **xⱼ = k.f** (where k = integer part, f = fractional part):
- **Floor value**: k = ⌊xⱼ⌋ (largest integer ≤ xⱼ)
- **Ceiling value**: k+1 = ⌈xⱼ⌉ (smallest integer ≥ xⱼ)
- **Example**: If x₁ = 3.75, then Floor = 3, Ceiling = 4

**STEP 3: Create Two Sub-Problems**
**Sub-problem 1 (Left branch)**: Add constraint **xⱼ ≤ k**
**Sub-problem 2 (Right branch)**: Add constraint **xⱼ ≥ k+1**

**STEP 4: Convert to Standard Form - CORRECT PROCESS**

**For Left Branch (xⱼ ≤ k):**
- **Original**: xⱼ ≤ k
- **Add slack**: xⱼ + sₙ = k
- **Tableau form**: [0, 0, ..., 1, ..., 1] = k (sₙ coefficient = +1)
- **Result**: Ready for tableau, usually feasible

**For Right Branch (xⱼ ≥ k+1) - CRITICAL CORRECTION:**
The user's question about "k+1 >= 3, k+1-e1 = 3, -k-1+e1=-3" is INCORRECT.

**Correct Process:**
- **Original**: xⱼ ≥ k+1
- **Step 1**: Add excess: xⱼ - eₙ = k+1
- **Step 2**: For dual simplex readiness: -xⱼ + eₙ = -(k+1)
- **Tableau form**: [0, 0, ..., -1, ..., 1] = -(k+1) (eₙ coefficient = +1, xⱼ coefficient = -1)

**Example Correction:**
If x₁ ≥ 4:
- **Wrong**: k+1-e₁=3, -k-1+e₁=-3
- **Correct**: x₁ ≥ 4 → x₁ - e₁ = 4 → -x₁ + e₁ = -4

**Why the negative RHS?**
- **Negative RHS = -4** indicates current solution violates constraint by 4 units
- **Dual simplex** will work to eliminate this violation

**STEP 5: Inherit Parent Tableau**
- **Each sub-problem starts with the current optimal tableau**
- **Add one new constraint row for the branching constraint**
- **All original constraints remain unchanged**

**STEP 6: Handle Variable Status - CONFLICT RESOLUTION**

### Case A: Variable is Non-Basic (No Conflict)
- **Situation**: Branching variable has coefficient 0 in all constraint rows
- **Action**: Add new constraint row directly to tableau
- **Example**: If x₂ is non-basic and we add x₂ ≤ 5, simply add row [0, 1, 0, 0, 1, 5]
- **Result**: No conflicts, proceed with simplex/dual simplex

### Case B: Variable is Basic (CONFLICT SITUATION)

#### The "Two 1's" Problem Explained

**What is the conflict?**
When a basic variable appears in a new branching constraint, we get **two rows with coefficient 1** for the same variable, violating tableau structure.

**Example Conflict:**
- **Current tableau**: x₁ is basic in row 2 with coefficient 1
- **New constraint**: x₁ ≤ 3, which becomes x₁ + s₄ = 3
- **Problem**: x₁ now has coefficient 1 in **both** row 2 and row 4
- **Result**: Tableau is no longer in proper form

#### Step-by-Step Conflict Resolution Process

**STEP 1: Identify the Conflict**
- **Check each basic variable** in the current optimal tableau
- **If branching variable is basic**: Conflict exists
- **Note the row number** where the variable is basic (coefficient = 1)

**STEP 2: Extract the Basic Variable Expression**
From the tableau row where the variable is basic, express the variable in terms of non-basic variables.

**Example**: If row 2 is [1, 0, -1¼, ¼, 0, 3¾], then:
x₁ = 3¾ + 1¼s₁ - ¼s₂

**STEP 3: Substitute into New Constraint**
Replace the basic variable in the new constraint with its expression.

**Detailed Example:**
- **New constraint**: x₁ ≤ 3 → x₁ + s₄ = 3
- **Substitute**: (3¾ + 1¼s₁ - ¼s₂) + s₄ = 3
- **Rearrange**: 1¼s₁ - ¼s₂ + s₄ = 3 - 3¾ = -¾
- **Final form**: 1¼s₁ - ¼s₂ + s₄ = -¾

**STEP 4: Create New Tableau Row**
- **New row coefficients**: [0, 0, 1¼, -¼, 1, -¾]
- **Variable order**: [x₁, x₂, s₁, s₂, s₄, RHS]
- **Key**: x₁ coefficient is now 0 (conflict resolved!)

#### Complete Manual Example - Oakfield Corporation

**Starting Point**: Optimal tableau with x₁ = 3¾ basic in row 2
**New Constraint**: x₁ ≤ 3

**Step 1 - Identify Conflict:**
- x₁ is basic in row 2 of current tableau
- New constraint x₁ + s₄ = 3 would create "two 1's" for x₁

**Step 2 - Extract Expression:**
From current tableau row 2: [1, 0, -1¼, ¼, 0] = 3¾
Therefore: x₁ = 3¾ + 1¼s₁ - ¼s₂

**Step 3 - Substitute:**
New constraint: x₁ + s₄ = 3
Substitute: (3¾ + 1¼s₁ - ¼s₂) + s₄ = 3
Simplify: 1¼s₁ - ¼s₂ + s₄ = -¾

**Step 4 - Add to Tableau:**
New row: [0, 0, 1¼, -¼, 1] = -¾

**Step 5 - Apply Dual Simplex:**
Since RHS = -¾ < 0, use dual simplex to restore feasibility

#### Alternative Method: Row Operations

**Instead of substitution, use direct row operations:**

**Given:**
- **Original basic row**: [1, 0, -1¼, ¼, 0, 3¾]
- **New constraint**: [1, 0, 0, 0, 1, 3]

**Row Operation:**
New constraint - Original basic row = Conflict-free row
[1, 0, 0, 0, 1, 3] - [1, 0, -1¼, ¼, 0, 3¾]
= [0, 0, 1¼, -¼, 1, -¾]

#### Why This Works

**Before conflict resolution:**
- Two rows have x₁ coefficient = 1
- Tableau structure violated
- Cannot proceed with simplex

**After conflict resolution:**
- Only one row has x₁ coefficient = 1 (original basic row)
- New row has x₁ coefficient = 0
- Proper tableau structure restored
- Can now apply dual simplex to negative RHS

**Detailed steps for basic variable xⱼ in row i:**
1. **Original row i**: [aᵢ₁, aᵢ₂, ..., aᵢₙ] = bᵢ
2. **New constraint**: xⱼ ≤ k (or ≥ k+1)
3. **Substitution**: Since xⱼ = bᵢ - Σ(aᵢₚ × xₚ), substitute into constraint
4. **New row formation**: 
   - For xⱼ ≤ k: [0, 0, ..., -aᵢₚ, ..., +1] = k - bᵢ
   - For xⱼ ≥ k+1: [0, 0, ..., +aᵢₚ, ..., -1] = bᵢ - (k+1)
5. **Sign check**: If RHS < 0, dual simplex required

### Rule 2b: Sub-Problem Tableau Generation Process
**Detailed process for creating new tableaux from parent tableau:**

**STARTING POINT: Parent Optimal Tableau (T-3)**
| T-3 | x₁ | x₂ | s₁ | s₂ | rhs |
|-----|----|----|----|----|-----|
| z   | 0  | 0  | 1¼ | ¾  | 41¼ |
| 1   | 0  | 1  | 2¼ | -¼ | 2¼  |
| 2   | 1  | 0  | -1¼| ¼  | 3¾  |

**Current solution**: x₁ = 3¾ (basic in row 2), x₂ = 2¼ (basic in row 1)

---

### SUB-PROBLEM 1: x₁ ≤ 3

**STEP 1: Identify the Basic Variable Constraint**
- x₁ is basic in **row 2** with value 3¾
- Row 2 equation: x₁ - 1¼s₁ + ¼s₂ = 3¾

**STEP 2: Add New Constraint**
- New constraint: x₁ ≤ 3 → x₁ + s₃ = 3

**STEP 3: Substitute Basic Variable Expression**
- From row 2: x₁ = 3¾ + 1¼s₁ - ¼s₂
- Substitute into new constraint: (3¾ + 1¼s₁ - ¼s₂) + s₃ = 3
- Rearrange: 3¾ + 1¼s₁ - ¼s₂ + s₃ = 3
- Solve for s₃: s₃ = 3 - 3¾ - 1¼s₁ + ¼s₂ = -¾ - 1¼s₁ + ¼s₂

**STEP 4: Create New Constraint Row**
- Since s₃ = -¾ - 1¼s₁ + ¼s₂, we have:
- **New row 3**: [0, 0, -1¼, ¼, -1] = -¾

**STEP 5: Build Complete Sub-Problem Tableau**
| T-4 | x₁ | x₂ | s₁ | s₂ | s₃ | rhs |
|-----|----|----|----|----|----|----|
| z   | 0  | 0  | 1¼ | ¾  | 0  | 41¼ |
| 1   | 0  | 1  | 2¼ | -¼ | 0  | 2¼  |
| 2   | 1  | 0  | -1¼| ¼  | 0  | 3¾  |
| 3   | 0  | 0  | -1¼| ¼  | -1 | -¾  |

**STEP 6: Apply Dual Simplex (RHS < 0)**
- Row 3 has RHS = -¾ < 0, violates feasibility
- Apply dual simplex method to restore feasibility

---

### SUB-PROBLEM 2: x₁ ≥ 4

**STEP 1: Identify the Basic Variable Constraint**
- x₁ is basic in **row 2** with value 3¾
- Row 2 equation: x₁ - 1¼s₁ + ¼s₂ = 3¾

**STEP 2: Add New Constraint**  
- New constraint: x₁ ≥ 4 → x₁ - e₃ = 4

**STEP 3: Substitute Basic Variable Expression**
- From row 2: x₁ = 3¾ + 1¼s₁ - ¼s₂
- Substitute into new constraint: (3¾ + 1¼s₁ - ¼s₂) - e₃ = 4
- Rearrange: 3¾ + 1¼s₁ - ¼s₂ - e₃ = 4
- Solve for e₃: e₃ = 3¾ + 1¼s₁ - ¼s₂ - 4 = -¼ + 1¼s₁ - ¼s₂

**STEP 4: Create New Constraint Row**
- Since e₃ = -¼ + 1¼s₁ - ¼s₂, we have:
- **New row 3**: [0, 0, 1¼, -¼, -1] = -¼

**STEP 5: Build Complete Sub-Problem Tableau**
| T-4 | x₁ | x₂ | s₁ | s₂ | e₃ | rhs |
|-----|----|----|----|----|----|----|
| z   | 0  | 0  | 1¼ | ¾  | 0  | 41¼ |
| 1   | 0  | 1  | 2¼ | -¼ | 0  | 2¼  |
| 2   | 1  | 0  | -1¼| ¼  | 0  | 3¾  |
| 3   | 0  | 0  | 1¼ | -¼ | -1 | -¼  |

**STEP 6: Apply Dual Simplex (RHS < 0)**
- Row 3 has RHS = -¼ < 0, violates feasibility
- Apply dual simplex method to restore feasibility

---

### KEY TABLEAU GENERATION RULES:

**Rule TG1: Copy Parent Tableau**
- All original rows remain unchanged initially
- Add new column for new variable (s₃ or e₃)
- Fill new column with zeros except for new constraint row

**Rule TG2: Create New Constraint Row**
- Find row where branching variable is basic
- Extract the expression for that variable
- Substitute into new constraint
- Form new row with coefficients

**Rule TG3: Handle Negative RHS**
- If new constraint row has RHS < 0, apply dual simplex
- This restores feasibility while maintaining optimality
- Continue until feasible solution found

**Rule TG4: Variable Status Update**
- Basic variables from parent remain basic (initially)
- New variable (s₃ or e₃) becomes non-basic
- Dual simplex may change variable status

### Rule 3: Fathoming Conditions
A node is **fathomed** (eliminated) if any of these conditions are met:

**Condition 1: Infeasibility**
- LP relaxation has no feasible solution
- **Decision**: Eliminate node, no further branching
- **Identification**: Dual simplex method fails to find feasible solution

**Condition 2: Integer Solution Found**
- All decision variables have integer values
- **Decision**: Record as candidate solution, compare with incumbent
- **Update rule**: If better than current incumbent, update incumbent
- **Note**: Node is fathomed regardless of objective value

**Condition 3: Bound Dominated (for maximization)**
- Current node's objective value ≤ incumbent solution value
- **Decision**: Eliminate node, cannot improve incumbent
- **Formula**: If z_node ≤ z_incumbent, then FATHOM
- **Reverse for minimization**: If z_node ≥ z_incumbent, then FATHOM

**Fathoming Decision Flowchart:**
```
Node Solution → Check Feasibility
    ↓
Feasible? → NO → FATHOM (Infeasible)
    ↓ YES
All Integer? → YES → Update Incumbent → FATHOM (Integer)
    ↓ NO
z > Incumbent? → NO → FATHOM (Bound)
    ↓ YES
CONTINUE BRANCHING
```

### Rule 4: Best Solution Tracking
- **Incumbent**: Current best integer solution found
- **Update**: When a better integer solution is discovered
- **Global Optimal**: Best solution when all nodes are fathomed

---

## Complete Tree Visualization

### Oakfield Corporation Branch & Bound Tree

```
                     LP Relaxation (Root)
                     x₁ = 3¾, x₂ = 2¼
                     z = 41¼
                          |
                    Branch on x₁
                     /         \
                    /           \
               x₁ ≤ 3               x₁ ≥ 4
           x₁ = 3, x₂ = 3          x₁ = 4, x₂ = 1⅘  
              z = 39                  z = 41
         [INTEGER SOLUTION]              |
                                   Branch on x₂
                                    /         \
                                   /           \
                              x₂ ≤ 1              x₂ ≥ 2
                         x₁ = 4, x₂ = 1         INFEASIBLE
                            z = 37              [FATHOMED]
                       [INTEGER SOLUTION]
                           /         \
                          /           \
                     x₁ ≤ 4              x₁ ≥ 5
               x₁ = 4, x₂ = 1       x₁ = 5, x₂ = 0
                  z = 37               z = 40
            [CURRENT OPTIMAL]      [INTEGER SOLUTION]
                                   [GLOBAL OPTIMAL]
```

### Node Status Legend:
- **[INTEGER SOLUTION]**: All variables are integers - candidate solution
- **[FATHOMED]**: Node eliminated (infeasible, bounded, or integer)
- **[CURRENT OPTIMAL]**: Best integer solution at this stage
- **[GLOBAL OPTIMAL]**: Final optimal solution

---

## Step-by-Step Process

### Phase 1: LP Relaxation Setup
1. **Remove integer constraints** from original IP problem
2. **Solve using Simplex Method**
3. **Check solution**:
   - If all variables are integers → **OPTIMAL IP SOLUTION**
   - If variables are fractional → **Continue to Phase 2**

### Phase 2: Branching Process
**Detailed Branching Procedure:**

**Step 1: Variable Selection**
1. **Calculate distances from 0.5** for all fractional variables
2. **Apply tie-breaking rule** if distances are equal
3. **Document selection rationale**

**Step 2: Sub-Problem Creation**
1. **Identify bounds**: Floor = ⌊value⌋, Ceiling = ⌈value⌉
2. **Create constraints**:
   - Left branch: xⱼ ≤ ⌊value⌋
   - Right branch: xⱼ ≥ ⌈value⌉
3. **Check variable status** (basic vs. non-basic)

**Step 3: Tableau Modification**
1. **Non-basic variable**: Add constraint row directly
2. **Basic variable**: Apply conflict resolution procedure
3. **Reformulate constraints** if necessary for dual simplex

**Step 4: Solution Process**
1. **Apply dual simplex method** if RHS < 0
2. **Continue regular simplex** if RHS ≥ 0
3. **Check optimality conditions**
4. **Record solution and status**

**TABLEAU TRANSFORMATION RULES:**

**Rule T1: Adding New Constraint Row**
- **Format**: [0, 0, ..., coefficient, ..., ±1] = RHS
- **Slack variable**: +1 for ≤ constraints
- **Excess variable**: -1 for ≥ constraints

**Rule T2: Basic Variable Substitution**
- **Identify basic variable row**: xⱼ appears in row i
- **Extract expression**: xⱼ = bᵢ - Σ(aᵢₖ × xₖ)
- **Substitute into new constraint**
- **Rearrange to standard form**

**Rule T3: Dual Simplex Application**
- **Trigger**: RHS < 0 in any constraint
- **Leaving variable**: Most negative RHS
- **Entering variable**: Minimum ratio test on negative coefficients
- **Pivot**: Standard row operations

**Step 5: Iterate Until Fathomed**
1. **Apply fathoming rules** after each solution
2. **Update incumbent** if better integer solution found
3. **Continue branching** on active nodes

### Phase 3: Understanding Dual vs Primal Transitions in Branch & Bound

#### When Does Each Method Apply?

**Primal Simplex in Branch & Bound:**
- **Use when**: All RHS ≥ 0 (feasible) but z-row has negative coefficients (not optimal)
- **Common scenario**: Left branch (x ≤ k) constraints usually maintain feasibility
- **Process**: Standard primal simplex pivot rules (most negative z-coefficient)

**Dual Simplex in Branch & Bound:**
- **Use when**: Any RHS < 0 (infeasible) regardless of z-row optimality
- **Common scenario**: Right branch (x ≥ k+1) constraints often create negative RHS
- **Process**: Dual simplex pivot rules (most negative RHS, dual ratio test)

#### Step-by-Step Decision Process

**After Adding New Constraint to Sub-problem:**

1. **Check RHS Values:**
   - **All RHS ≥ 0**: Go to Step 2 (check optimality)
   - **Any RHS < 0**: **Use Dual Simplex** immediately

2. **If Feasible, Check Optimality:**
   - **All z-coefficients ≥ 0 (max) or ≤ 0 (min)**: **OPTIMAL** → Fathom node
   - **Has negative z-coefficients (max) or positive (min)**: **Use Primal Simplex**

#### Detailed Examples in Branch & Bound Context

**Left Branch Example: x₁ ≤ 3**
- Parent solution: x₁ = 3.75, x₂ = 2.25, z = 41.25
- New constraint: x₁ + s₄ = 3
- **Result**: Usually maintains feasibility → **Use Primal Simplex**

**Right Branch Example: x₁ ≥ 4**  
- Parent solution: x₁ = 3.75, x₂ = 2.25, z = 41.25
- New constraint: -x₁ + e₄ = -4
- Current x₁ = 3.75 < 4, so constraint violated
- **Result**: Creates negative RHS → **Use Dual Simplex**

#### Transition Flow Chart

```
Add Constraint to Sub-problem
         ↓
   Check RHS Values
         ↓
    Any RHS < 0?
    ↙         ↘
   YES         NO
    ↓           ↓
DUAL SIMPLEX   Check z-row
               ↓
           Optimal?
           ↙     ↘
          YES     NO
           ↓       ↓
        FATHOM   PRIMAL SIMPLEX
```

### Phase 4: Fathoming and Tracking
1. **Evaluate each sub-problem solution** (after dual/primal simplex)
2. **Apply fathoming rules**
3. **Update incumbent solution** if better integer solution found
4. **Continue branching** on remaining active nodes

### Phase 5: Termination
1. **All nodes fathomed**: Algorithm terminates
2. **Return incumbent solution** as optimal IP solution

---

## Worked Example: Oakfield Corporation

### Problem Statement
**Oakfield Corporation** manufactures tables (x₁) and chairs (x₂).

**Resource Requirements**:
- **Labor**: 1 hour per table, 1 hour per chair, 6 hours available
- **Wood**: 9 sq ft per table, 5 sq ft per chair, 45 sq ft available

**Profit**:
- **Tables**: R8 per table
- **Chairs**: R5 per chair

### Integer Programming Model
```
Maximize z = 8x₁ + 5x₂

Subject to:
  x₁ + x₂ ≤ 6      (labor constraint)
  9x₁ + 5x₂ ≤ 45   (wood constraint)
  x₁, x₂ ≥ 0
  x₁, x₂ integers
```

### Step 1: LP Relaxation (Root Node)

**Initial Tableau (T-1)**:
| T-1 | x₁ | x₂ | s₁ | s₂ | rhs | θ |
|-----|----|----|----|----|-----|---|
| z   | -8 | -5 | 0  | 0  | 0   |   |
| 1   | 1  | 1  | 1  | 0  | 6   | 6 |
| 2   | 9  | 5  | 0  | 1  | 45  | 5 |

**After Iteration 1 (T-2)**:
| T-2 | x₁ | x₂     | s₁ | s₂     | rhs | θ       |
|-----|----| ------ |----|--------|----|---------|
| z   | 0  | -5/9   | 0  | 8/9    | 40 |         |
| 1   | 0  | 4/9    | 1  | -1/9   | 1  | 2¼      |
| 2   | 1  | 5/9    | 0  | 1/9    | 5  | 9       |

**Optimal Solution (T-3)**:
| T-3 | x₁ | x₂     | s₁     | s₂     | rhs    |
|-----|----| ------ | ------ | ------ | ------ |
| z   | 0  | 0      | 1¼     | ¾      | 41¼    |
| 1   | 0  | 1      | 2¼     | -¼     | 2¼     |
| 2   | 1  | 0      | -1¼    | ¼      | 3¾     |

**LP Relaxation Result**:
- x₁ = 3¾, x₂ = 2¼
- Maximum z = 41¼
- **Fractional solution** → Continue branching

### Step 2: First Branch (x₁ = 3¾)

**Fractional parts**: x₁ = 0.75, x₂ = 0.25
**Branch on x₁** (both have equal distance from 0.5, choose leftmost variable x₁)

Both fractional parts are ¼ away from 0.5 (0.75 is ¼ above 0.5, 0.25 is ¼ below 0.5). When fractional parts are equidistant from 0.5, we choose the variable with the smaller subscript (x₁).

#### Sub-Problem 1: x₁ ≤ 3
**Add constraint**: x₁ + s₃ = 3

**Conflict resolution**: x₁ is basic in row 2 with value 3¾
Since x₁ is basic, we need to create a new constraint row:
- Original row 2: x₁ = 3¾ (from tableau: [1,0,-1¼,¼] = 3¾)
- New constraint: x₁ + s₃ = 3
- Substituting: 3¾ + s₃ = 3
- Therefore: s₃ = 3 - 3¾ = -¾

Since s₃ = -¾ < 0, this violates non-negativity. We need dual simplex.

**DUAL SIMPLEX METHOD - Step-by-Step Procedure:**

**Step 1: Reformulate constraint**
- Original: x₁ + s₃ = 3, but s₃ = -¾ < 0
- Reformulate: x₁ - s₃ = 3 (where s₃ ≥ 0, representing the violation)

**Step 2: Create new constraint row**
- x₁ is basic in row 2: x₁ = 3¾ + 1¼s₁ - ¼s₂
- Substitute into new constraint: (3¾ + 1¼s₁ - ¼s₂) - s₃ = 3
- Rearranging: 1¼s₁ - ¼s₂ - s₃ = 3 - 3¾ = -¾
- New row: [0, 0, 1¼, -¼, -1] = -¾

**Step 3: Dual simplex pivot selection**
- **Leaving variable rule**: Choose variable with most negative RHS (s₃ with -¾)
- **Entering variable rule**: Among variables with negative coefficients in leaving row, choose minimum ratio |zⱼ - cⱼ|/|aᵢⱼ|
- In new row: s₁ has coefficient 1¼ > 0, s₂ has coefficient -¼ < 0
- Check s₂: ratio calculation for dual simplex pivot

**Step 4: Execute dual simplex iteration**
- Pivot on s₂ column, new constraint row
- Transform tableau to maintain optimality and feasibility

**After dual simplex (T-4)**:
| T-4 | x₁ | x₂ | s₁ | s₂ | s₃ | rhs |
|-----|----|----|----|----|----|----|
| z   | 0  | 0  | 5  | 0  | 3  | 39  |
| 1   | 0  | 1  | 1  | 0  | -1 | 3   |
| 2   | 1  | 0  | 0  | 0  | 1  | 3   |
| 3   | 0  | 0  | -5 | 1  | -4 | 3   |

**Solution**: x₁ = 3, x₂ = 3, z = 39
**Status**: **INTEGER SOLUTION** → **Incumbent = 39**

#### Sub-Problem 2: x₁ ≥ 4 - CORRECT CONSTRAINT CONVERSION

**Step-by-Step Constraint Addition:**
1. **Original branching constraint**: x₁ ≥ 4
2. **Add excess variable**: x₁ - e₃ = 4  
3. **For dual simplex format**: -x₁ + e₃ = -4
4. **Interpretation**: Current solution x₁ = 3¾ violates constraint by ¼ unit

**Why negative RHS?**
- Current x₁ = 3¾ < 4 (constraint violated)
- RHS = -4 indicates infeasibility  
- Dual simplex will restore feasibility

**After dual simplex (T-4)**:
| T-4 | x₁ | x₂  | s₁ | s₂ | e₃  | rhs |
|-----|----|-----|----|----|-----|-----|
| z   | 0  | 0   | 0  | 1  | 1   | 41  |
| 1   | 0  | 1   | 0  | ⅕  | 1⅘  | 1⅘  |
| 2   | 1  | 0   | 0  | 0  | -1  | 4   |
| 3   | 0  | 0   | 1  | -⅕ | -⅘  | ⅕   |

**Solution**: x₁ = 4, x₂ = 1⅘, z = 41
**Status**: **Fractional** → Continue branching

### Step 3: Second Branch (x₂ = 1⅘)

**Branch on x₂** (only fractional variable)

#### Sub-Problem 2.1: x₂ ≤ 1
**After dual simplex (T-6)**:
| T-6 | x₁ | x₂ | s₁ | s₂ | e₃ | s₄ | rhs |
|-----|----|----|----|----|----|----|-----|
| z   | 0  | 0  | 0  | ⅘  | 0  | ⁵⁄₉ | 40⁵⁄₉ |
| 1   | 0  | 1  | 0  | 0  | 0  | 1  | 1   |
| 2   | 1  | 0  | 0  | 0  | 0  | 1  | 4   |
| 3   | 0  | 0  | 1  | 0  | 0  | -1 | 1   |
| 4   | 0  | 0  | 0  | 0  | 1  | 0  | 0   |
| 5   | 0  | 0  | 0  | 1  | 0  | -5 | 4   |

**Solution**: x₁ = 4, x₂ = 1, z = 37
**Status**: **INTEGER SOLUTION** → **Incumbent remains 39**

##### Sub-Problem 2.1.1: x₁ ≤ 4
**Solution**: x₁ = 4, x₂ = 1, z = 37
**Status**: **INTEGER** → **Fathomed (bound: 37 < 39)**

##### Sub-Problem 2.1.2: x₁ ≥ 5
**After dual simplex (T-6)**:
| T-6 | x₁ | x₂ | s₁ | s₂ | e₃ | e₅ | rhs |
|-----|----|----|----|----|----|----|-----|
| z   | 0  | 0  | 0  | 1  | 0  | 1  | 40  |
| 1   | 0  | 1  | 0  | ⅕  | 0  | 1⅘ | 0   |
| 2   | 1  | 0  | 0  | 0  | 0  | -1 | 5   |
| 3   | 0  | 0  | 1  | -⅕ | 0  | -⅘ | 1   |
| 4   | 0  | 0  | 0  | 0  | 1  | 0  | 1   |
| 5   | 0  | 0  | 0  | -⅕ | 0  | -1⅘| 1   |

**Solution**: x₁ = 5, x₂ = 0, z = 40
**Status**: **INTEGER SOLUTION** → **New Incumbent = 40**

#### Sub-Problem 2.2: x₂ ≥ 2
**Infeasible** → **Fathomed**

### Final Result
**Optimal Solution**: x₁ = 5 tables, x₂ = 0 chairs
**Maximum Profit**: z = R40

---

## Decision Rules and Strategies

### Variable Selection for Branching
**Rule Priority (Use in order):**
1. **Closest to 0.5 rule** (PRIMARY - creates balanced branching)
2. **Tie-breaking by subscript** (choose smallest subscript)
3. **Alternative rules** (when strategy varies):
   - Largest fractional part rule
   - Most promising variable (based on objective coefficients)
   - First fractional variable encountered

**Strategic Considerations:**
- **Balanced branching** (closest to 0.5) often reduces tree size
- **Problem-specific heuristics** may outperform general rules
- **Computational efficiency** vs. tree size trade-offs

### Node Selection Strategies
1. **Depth-First Search**: Explore one branch completely
2. **Breadth-First Search**: Explore all nodes at same level
3. **Best-First Search**: Explore node with best bound first
4. **Hybrid approaches**: Combine strategies

### Fathoming Efficiency
- **Early fathoming** reduces computational time
- **Good incumbent solutions** improve bounding
- **Strong LP relaxation bounds** help eliminate nodes quickly

### Computational Considerations
- **Tree size** grows exponentially with problem size
- **Memory requirements** for storing active nodes
- **Time complexity** depends on branching strategy

---

## Practice Exercises

### Exercise 1: Simple Production Problem
```
Maximize z = 3x₁ + 2x₂

Subject to:
  x₁ + x₂ ≤ 10
  6x₁ + 3x₂ ≤ 35
  x₁, x₂ ≥ 0, integers
```

**Tasks**:
1. Solve LP relaxation
2. Build complete branch and bound tree
3. Identify all integer solutions
4. Determine optimal IP solution

### Exercise 2: Investment Selection
```
Maximize z = 40x₁ + 90x₂

Subject to:
  9x₁ + 7x₂ ≤ 56
  7x₁ + 20x₂ ≤ 70
  x₁, x₂ ≥ 0, integers
```

**Tasks**:
1. Compare LP relaxation solution with IP solution
2. Calculate the "price of integrality"
3. Draw complete solution tree
4. Count total number of sub-problems solved

### Exercise 3: Resource Allocation
```
Minimize z = 2x₁ + 3x₂

Subject to:
  3x₁ + 5x₂ ≥ 30
  5x₁ + 2x₂ ≥ 25
  x₁, x₂ ≥ 0, integers
```

**Tasks**:
1. Convert to maximization form
2. Apply branch and bound methodology
3. Handle minimization objective in branching
4. Interpret business implications

---

## Key Takeaways

### Algorithm Strengths
- **Guarantees optimal solution** for integer programming
- **Systematic exploration** of solution space
- **Efficient fathoming** reduces computational burden
- **Applicable to various IP problem types**

### When Branch & Bound Works Best
1. **Problems with good LP relaxation bounds**
2. **Small to medium-sized problems**
3. **When integer solutions are sparse**
4. **Production and resource allocation problems**

### Common Challenges
- **Exponential growth** of search tree
- **Computational complexity** for large problems
- **Memory requirements** for active node storage
- **Choosing effective branching strategies**

### Manual Excel Implementation Tips

#### Setting Up Branch & Bound in Excel
- **Create master worksheet** for tracking all nodes and incumbents
- **Use separate worksheets** for each sub-problem's simplex tableau  
- **Label worksheets clearly**: "Root", "Node_x1≤3", "Node_x1≥4", etc.
- **Create branching tree diagram** on separate sheet for visualization

#### Manual Calculation Process
- **Copy parent tableau** exactly to new worksheet for each sub-problem
- **Add new constraint row** by hand at bottom of tableau
- **Resolve conflicts manually** using row operations (see sensitivity analysis guide)
- **Apply dual simplex by hand** if RHS becomes negative
- **Document each step** with clear annotations

#### Tracking Progress Manually
- **Maintain incumbent table**: Current best integer solution and objective value
- **Track node status**: Active, Fathomed (reason), Integer solution found
- **Calculate bounds accurately** at each node by reading z-row RHS
- **Verify integer constraints** by checking solution values manually
- **Update branching tree** after solving each sub-problem

### Business Applications
- **Production planning**: Integer units of products
- **Project selection**: Binary investment decisions  
- **Scheduling**: Discrete time periods or resources
- **Facility location**: Integer number of facilities
- **Supply chain**: Integer quantities and routes

---

*This comprehensive guide demonstrates the complete Branch & Bound methodology using the Oakfield Corporation example from the Belgium Campus Linear Programming course materials.*
