# Discrete Programming (Integer Programming) Guide

## Table of Contents
1. [Introduction to Integer Programming](#introduction-to-integer-programming)
2. [Types of Integer Programming Problems](#types-of-integer-programming-problems)
3. [LP Relaxation Method](#lp-relaxation-method)
4. [Branch and Bound Algorithm](#branch-and-bound-algorithm)
5. [Cutting Plane Methods](#cutting-plane-methods)
6. [Worked Example: Oakfield Corporation](#worked-example-oakfield-corporation)
7. [Advanced Applications](#advanced-applications)
8. [Practice Exercises](#practice-exercises)

---

## Introduction to Integer Programming

### What is Integer Programming?
**Integer Programming (IP)** is a mathematical optimization technique where some or all decision variables must take integer (whole number) values. This adds complexity to linear programming by introducing discrete constraints.

### Why Integer Programming?
Many real-world problems require discrete decisions:
- **Production**: Cannot produce 2.5 machines
- **Personnel**: Cannot hire 3.7 employees  
- **Investment**: Cannot build 0.3 of a factory
- **Scheduling**: Tasks are either assigned or not

### Key Differences from Linear Programming
| Aspect | Linear Programming | Integer Programming |
|--------|-------------------|-------------------|
| **Variables** | Continuous (any real value) | Integer (whole numbers) |
| **Feasible Region** | Smooth, continuous | Discrete points |
| **Solution Method** | Simplex Algorithm | Branch & Bound, Cutting Planes |
| **Computational Complexity** | Polynomial time | NP-hard |
| **Optimal Solution** | At vertices of polytope | At integer points |

### Computational Complexity Comparison
| Problem Size | LP Solution Time | IP Solution Time | Difficulty Ratio |
|--------------|------------------|------------------|------------------|
| Small (10-50 variables) | Seconds | Seconds-Minutes | 10x - 100x |
| Medium (100-500 variables) | Minutes | Minutes-Hours | 100x - 1000x |
| Large (1000+ variables) | Minutes-Hours | Hours-Days | 1000x+ |

**Key Insight**: IP solution time grows **exponentially** with problem size, while LP grows **polynomially**.

### When Integrality Matters Most
| Industry | Application | Impact of Non-Integer Solution |
|----------|-------------|-------------------------------|
| **Manufacturing** | Production quantities | Cannot produce 2.3 machines |
| **Logistics** | Vehicle routing | Cannot use 1.7 trucks |
| **Finance** | Project selection | Cannot invest in 0.4 of a project |
| **Healthcare** | Staff scheduling | Cannot hire 15.6 nurses |
| **Telecommunications** | Network design | Cannot build 0.8 of a cell tower |

---

## Types of Integer Programming Problems

### Pure Integer Programming (PIP)
**All variables** must be integers.
```
Maximize z = 3x₁ + 2x₂
Subject to:
  x₁ + 2x₂ ≤ 8
  2x₁ + x₂ ≤ 10
  x₁, x₂ ≥ 0 and integer
```

### Mixed Integer Programming (MIP)
**Some variables** are integers, others are continuous.
```
Maximize z = 5x₁ + 3x₂ + 2x₃
Subject to:
  x₁ + x₂ + x₃ ≤ 10
  2x₁ + x₂ ≤ 8
  x₁, x₂ ≥ 0 and integer
  x₃ ≥ 0 (continuous)
```

### Binary Integer Programming (BIP)
**Variables are restricted to 0 or 1** (binary).
```
Maximize z = 4x₁ + 3x₂ + 2x₃
Subject to:
  2x₁ + x₂ + 3x₃ ≤ 5
  x₁ + 2x₂ + x₃ ≤ 4
  x₁, x₂, x₃ ∈ {0, 1}
```

### Business Applications by IP Type

#### Pure Integer Programming (PIP) - Real-World Examples
**Manufacturing Sector:**
- **Production planning**: Number of units to produce (must be whole)
- **Batch sizing**: Number of production batches (discrete quantities)
- **Machine scheduling**: Integer time slots for operations

**When to use PIP:**
- All decision variables represent indivisible quantities
- High setup costs make fractional solutions impractical
- Regulatory requirements mandate integer values

#### Mixed Integer Programming (MIP) - Business Cases
**Supply Chain Management:**
- **Facility location + capacity**: Binary location decisions with continuous flow variables
- **Production + inventory**: Integer production levels with continuous inventory
- **Transportation**: Binary route selection with continuous shipment quantities

**When to use MIP:**
- Some decisions are binary (yes/no) while others are continuous
- Combining strategic (integer) and operational (continuous) decisions
- Different decision variables have different practical constraints

#### Binary Integer Programming (BIP) - Strategic Applications
**Project Portfolio Management:**
- **Capital budgeting**: xᵢ = 1 if project i is funded, 0 otherwise
- **Technology selection**: yⱼ = 1 if technology j is adopted, 0 otherwise
- **Mergers & Acquisitions**: zₖ = 1 if company k is acquired, 0 otherwise

**Facility and Network Design:**
- **Location selection**: wᵢ = 1 if facility built at location i, 0 otherwise
- **Network topology**: eᵢⱼ = 1 if link between nodes i and j exists, 0 otherwise
- **Service deployment**: sⱼ = 1 if service offered at location j, 0 otherwise

**When to use BIP:**
- All-or-nothing decisions dominate the problem
- High fixed costs make partial solutions impractical
- Strategic decisions with no middle ground

---

## LP Relaxation Method

### What is LP Relaxation?
**LP Relaxation** removes integer constraints, solving the problem as a regular linear program. This provides:
- **Upper bound** for maximization problems
- **Lower bound** for minimization problems
- **Starting point** for integer programming algorithms

### Step-by-Step Process

#### Step 1: Formulate Integer Program
```
Original IP:
Maximize z = 8x₁ + 5x₂
Subject to:
  x₁ + x₂ ≤ 6
  9x₁ + 5x₂ ≤ 45
  x₁, x₂ ≥ 0 and integer
```

#### Step 2: Create LP Relaxation
```
LP Relaxation:
Maximize z = 8x₁ + 5x₂
Subject to:
  x₁ + x₂ ≤ 6
  9x₁ + 5x₂ ≤ 45
  x₁, x₂ ≥ 0 (remove integer constraint)
```

#### Step 3: Solve LP Relaxation
Using simplex method or graphical method.

#### Step 4: Analyze Results
- **If solution is integer**: Optimal IP solution found
- **If solution is fractional**: Use Branch & Bound or Cutting Planes

### Relationship Between LP and IP Solutions
- **IP Optimal Value ≤ LP Relaxation Optimal Value** (for maximization)
- **IP Optimal Value ≥ LP Relaxation Optimal Value** (for minimization)
- **Gap size** indicates difficulty of integer problem

---

## Branch and Bound Algorithm

### Core Concept
**Systematically explore** integer solutions by creating a tree of subproblems, using LP relaxation bounds to eliminate unpromising branches.

### Algorithm Steps

#### Step 1: Solve LP Relaxation
- If integer solution → **STOP** (optimal found)
- If fractional solution → continue to Step 2

#### Step 2: Select Branching Variable
Choose fractional variable xⱼ with value vⱼ (not integer).

#### Step 3: Create Subproblems
- **Branch 1**: Add constraint xⱼ ≤ ⌊vⱼ⌋ (floor of vⱼ)
- **Branch 2**: Add constraint xⱼ ≥ ⌈vⱼ⌉ (ceiling of vⱼ)

#### Step 4: Solve Subproblems
Solve LP relaxation for each branch.

#### Step 5: Bounding
- **Fathom branch if**:
  - Infeasible
  - Worse than current best integer solution
  - Optimal solution is integer

#### Step 6: Select Next Node
Choose unfathomed node with best bound.

#### Step 7: Repeat
Continue until all nodes are fathomed.

### Branch and Bound Tree Example

```
                    LP Relaxation
                   x₁=3.89, x₂=2.11
                      z = 41.67
                         /    \
                       /        \
              x₁ ≤ 3                x₁ ≥ 4
           x₁=3, x₂=3.6               x₁=4, x₂=1.8
             z = 42                    z = 41
               /    \                    /    \
        x₂ ≤ 3      x₂ ≥ 4      x₂ ≤ 1      x₂ ≥ 2
      x₁=3,x₂=3   Infeasible   x₁=4,x₂=1   x₁=4,x₂=2
        z = 39                   z = 37    Infeasible
     (Integer!)                (Integer!)
```

### Branching Strategies
1. **Most fractional**: Choose variable closest to 0.5
2. **First fractional**: Choose first fractional variable encountered
3. **Last fractional**: Choose last fractional variable
4. **Strong branching**: Evaluate impact of each potential branch

---

## Cutting Plane Methods

### Gomory Cutting Planes
**Add constraints** that eliminate fractional solutions while preserving all integer points.

### Gomory Cut Generation

#### Step 1: Solve LP Relaxation
Obtain optimal tableau with fractional solution.

#### Step 2: Select Cut Source Row
Choose tableau row with fractional basic variable.

#### Step 3: Generate Cut
For row: xᵦ + ∑ aⱼxⱼ = b

**Gomory Cut**: ∑ frac(aⱼ)xⱼ ≥ frac(b)

Where frac(x) = x - ⌊x⌋ (fractional part)

#### Step 4: Add Cut to Problem
Include new constraint in tableau.

#### Step 5: Re-solve
Use dual simplex to find new solution.

#### Step 6: Repeat
Continue until integer solution found.

### Cut Example
If tableau row is: x₁ + 0.67x₃ + 0.33x₄ = 2.67

**Gomory cut**: 0.67x₃ + 0.33x₄ ≥ 0.67

---

## Worked Example: Oakfield Corporation

### Problem Statement
The Oakfield Corporation manufactures tables and chairs.

**Resource Requirements**:
- **Table**: 1 hour labour, 9 m² wood, profit = R8
- **Chair**: 1 hour labour, 5 m² wood, profit = R5

**Available Resources**:
- **Labour**: 6 hours
- **Wood**: 45 m²

**Special Condition**: Only chairs must be integer (tables can be fractional).

### Mathematical Formulation

#### Integer Programming Model
```
Maximize z = 8x₁ + 5x₂

Subject to:
  x₁ + x₂ ≤ 6      (labour constraint)
  9x₁ + 5x₂ ≤ 45   (wood constraint)
  x₁ ≥ 0           (continuous)
  x₂ ≥ 0 and integer (discrete)
```

### Solution Process

#### Step 1: LP Relaxation
```
Maximize z = 8x₁ + 5x₂
Subject to:
  x₁ + x₂ ≤ 6
  9x₁ + 5x₂ ≤ 45
  x₁, x₂ ≥ 0
```

**LP Solution**: x₁ = 3.89, x₂ = 2.11, z = 41.67

#### Step 2: Check Integer Requirements
- x₁ = 3.89 (fractional, but allowed)
- x₂ = 2.11 (fractional, must be integer)

**Need to apply integer programming methods**

#### Step 3: Branch and Bound Application

**Node 1**: Original LP Relaxation
- Solution: x₁ = 3.89, x₂ = 2.11, z = 41.67
- x₂ is fractional → Branch on x₂

**Branch A**: Add x₂ ≤ 2
- New constraints: x₁ + x₂ ≤ 6, 9x₁ + 5x₂ ≤ 45, x₂ ≤ 2
- Solution: x₁ = 4.44, x₂ = 2, z = 45.56

**Branch B**: Add x₂ ≥ 3  
- New constraints: x₁ + x₂ ≤ 6, 9x₁ + 5x₂ ≤ 45, x₂ ≥ 3
- Solution: x₁ = 3.33, x₂ = 3, z = 41.67

#### Step 4: Solve Branch Subproblems Correctly

**Branch A** (x₂ ≤ 2):
- **Constraints**: 
  - x₁ + x₂ ≤ 6 (labour)
  - 9x₁ + 5x₂ ≤ 45 (wood)
  - x₂ ≤ 2 (branching constraint)
  - x₁, x₂ ≥ 0

- **Solution Process**:
  - At x₂ = 2: labour constraint becomes x₁ + 2 ≤ 6 → x₁ ≤ 4
  - At x₂ = 2: wood constraint becomes 9x₁ + 10 ≤ 45 → x₁ ≤ 3.89
  - **Binding constraint**: Wood (more restrictive)
  - **Optimal**: x₁ = 3.89, x₂ = 2
  - **Objective value**: z = 8(3.89) + 5(2) = 31.12 + 10 = **41.12**

**Branch B** (x₂ ≥ 3):
- **Constraints**: 
  - x₁ + x₂ ≤ 6 (labour)
  - 9x₁ + 5x₂ ≤ 45 (wood)
  - x₂ ≥ 3 (branching constraint)
  - x₁, x₂ ≥ 0

- **Solution Process**:
  - At x₂ = 3: labour constraint becomes x₁ + 3 ≤ 6 → x₁ ≤ 3
  - At x₂ = 3: wood constraint becomes 9x₁ + 15 ≤ 45 → x₁ ≤ 3.33
  - **Binding constraint**: Labour (more restrictive)
  - **Optimal**: x₁ = 3, x₂ = 3
  - **Objective value**: z = 8(3) + 5(3) = 24 + 15 = **39**

#### Step 5: Compare and Select Optimal Solution

| Branch | Solution | Objective Value | Feasibility Check |
|--------|----------|----------------|-------------------|
| **A** | x₁ = 3.89, x₂ = 2 | z = 41.12 | ✓ All constraints satisfied |
| **B** | x₁ = 3, x₂ = 3 | z = 39.00 | ✓ All constraints satisfied |

**Verification of Branch A**:
- Labour used: 3.89 + 2 = 5.89 ≤ 6 ✓
- Wood used: 9(3.89) + 5(2) = 35.01 + 10 = 45.01 ≈ 45 ✓ (within rounding)
- x₂ = 2 is integer ✓
- x₁ = 3.89 can be fractional (problem allows this)

#### Step 6: Optimal Solution
**Best mixed-integer solution**: 
- **Tables**: x₁ = 3.89 ≈ **3.89 tables**
- **Chairs**: x₂ = **2 chairs** (integer as required)
- **Maximum profit**: z = **R41.12**

### Business Interpretation
- **Production plan**: Manufacture 3.89 tables and exactly 2 chairs
- **Resource utilization**: 
  - Labour: 5.89/6 = **98.2% utilized**
  - Wood: 45.01/45 = **100% utilized** (fully binding)
- **Fractional production**: 3.89 tables could represent 3 complete tables plus 0.89 of a table in progress
- **Practical implementation**: Start 4 tables, complete 3, leaving the 4th 89% finished

---

## Advanced Applications

### Capital Budgeting (0-1 Programming)
```
Maximize NPV = ∑ pᵢxᵢ
Subject to: ∑ cᵢxᵢ ≤ Budget
           xᵢ ∈ {0, 1} for all i
```

### Assignment Problems
```
Minimize Cost = ∑∑ cᵢⱼxᵢⱼ
Subject to: ∑ xᵢⱼ = 1 (each worker assigned once)
           ∑ xᵢⱼ = 1 (each job filled once)
           xᵢⱼ ∈ {0, 1}
```

### Facility Location
```
Minimize Cost = ∑ fⱼyⱼ + ∑∑ cᵢⱼxᵢⱼ
Subject to: ∑ xᵢⱼ = 1 (demand satisfied)
           xᵢⱼ ≤ yⱼ (facility must be open)
           yⱼ ∈ {0, 1}, xᵢⱼ ≥ 0
```

### Set Covering Problems
```
Minimize Cost = ∑ cⱼxⱼ
Subject to: ∑ aᵢⱼxⱼ ≥ 1 (each requirement covered)
           xⱼ ∈ {0, 1}
```

---

## Practice Exercises

### Exercise 1: Production Planning
A company produces two products with the following data:

| Product | Profit | Machine Hours | Labor Hours |
|---------|--------|---------------|-------------|
| A       | R12    | 3             | 2           |
| B       | R8     | 2             | 3           |

**Available**: 15 machine hours, 18 labor hours
**Constraint**: Both products must be produced in integer quantities

**Tasks**:
1. Formulate as integer programming problem
2. Solve LP relaxation
3. Apply branch and bound method
4. Find optimal integer solution

### Exercise 2: Investment Selection
An investor has R100,000 to invest in 4 projects:

| Project | Cost (R'000) | NPV (R'000) |
|---------|--------------|-------------|
| 1       | 30           | 15          |
| 2       | 25           | 12          |
| 3       | 40           | 20          |
| 4       | 35           | 18          |

**Constraint**: Each project is either fully funded or not funded at all.

**Tasks**:
1. Formulate as binary integer program
2. Identify all feasible combinations
3. Find optimal portfolio
4. Calculate total NPV

### Exercise 3: Cutting Stock Problem
A paper mill needs to cut rolls of paper (100 cm wide) into smaller widths:
- 30 cm width: need 50 rolls
- 40 cm width: need 30 rolls  
- 25 cm width: need 40 rolls

**Cutting patterns available**:
- Pattern 1: 3 × 30cm + 1 × 10cm (waste)
- Pattern 2: 2 × 40cm + 1 × 20cm (waste)
- Pattern 3: 1 × 30cm + 1 × 40cm + 1 × 25cm + 5cm (waste)
- Pattern 4: 4 × 25cm

**Tasks**:
1. Formulate as integer programming problem
2. Minimize number of parent rolls used
3. Ensure demand requirements are met
4. Find optimal cutting plan

### Exercise 4: Workforce Scheduling
A call center needs the following minimum staff:

| Time Slot    | Minimum Staff |
|--------------|---------------|
| 8-12         | 15            |
| 12-16        | 20            |
| 16-20        | 18            |
| 20-24        | 12            |

**Shift options** (8-hour shifts):
- Shift A: 8-16 (cost R500)
- Shift B: 12-20 (cost R600)  
- Shift C: 16-24 (cost R550)
- Shift D: 20-4 (cost R650)

**Tasks**:
1. Formulate as integer programming problem
2. Minimize total staffing cost
3. Meet minimum requirements for each time slot
4. Find optimal staffing plan

---

## Key Takeaways

### When to Use Integer Programming
1. **Decision variables represent discrete quantities**
2. **Yes/no decisions** (binary variables)
3. **Indivisible resources** or activities
4. **Logical constraints** requiring integer solutions

### Solution Approach Selection
- **Small problems**: Complete enumeration
- **Binary problems**: Branch and bound
- **Large MIP**: Commercial solvers (CPLEX, Gurobi)
- **Special structure**: Specialized algorithms

### Computational Considerations
- **IP is NP-hard**: Solution time grows exponentially
- **Good bounds are crucial**: Tight LP relaxation helps
- **Problem formulation matters**: Different formulations have different computational difficulty
- **Commercial solvers essential**: For real-world applications

### Common Pitfalls
1. **Ignoring integrality gap**: LP solution may be far from IP solution
2. **Poor formulation**: Weak LP relaxation leads to slow solution
3. **Over-constraining**: Too many integer variables increases difficulty
4. **Scaling issues**: Large coefficients can cause numerical problems

---

*This guide provides a comprehensive foundation for understanding and solving discrete programming problems. The combination of theory, methodology, and practical examples prepares you for real-world integer programming applications.*