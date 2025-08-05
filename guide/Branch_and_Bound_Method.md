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
**Choose the fractional variable with the largest fractional part**
- If multiple variables have the same fractional part, choose the one with the lower subscript
- Example: If x₁ = 3.75 and x₂ = 4.25, both have fractional part 0.25, so choose x₁

### Rule 2: Creating Sub-Problems
For a fractional variable xⱼ = k.f (where k is integer part, f is fractional part):
- **Sub-problem 1**: Add constraint xⱼ ≤ k (floor value)
- **Sub-problem 2**: Add constraint xⱼ ≥ k+1 (ceiling value)

### Rule 3: Fathoming Conditions
A node is **fathomed** (eliminated) if:
1. **Infeasible**: LP relaxation has no solution
2. **Integer Solution**: All variables are integers (candidate solution)
3. **Bound**: Objective value ≤ current best integer solution (for maximization)

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
1. **Select fractional variable** (largest fractional part rule)
2. **Create two sub-problems**:
   - Lower bound: xⱼ ≤ ⌊value⌋
   - Upper bound: xⱼ ≥ ⌈value⌉
3. **Add constraints to optimal tableau**
4. **Resolve each sub-problem**

### Phase 3: Fathoming and Tracking
1. **Evaluate each sub-problem solution**
2. **Apply fathoming rules**
3. **Update incumbent solution** if better integer solution found
4. **Continue branching** on remaining active nodes

### Phase 4: Termination
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
**Branch on x₁** (larger fractional part)

#### Sub-Problem 1: x₁ ≤ 3
**Add constraint**: x₁ + s₃ = 3

**Conflict resolution**: x₁ is basic in row 2
- Row 2 - Row 3: [1,0,-1¼,¼,0] = 3¾ - 3 = ¾
- New Row 2: [0,0,-1¼,¼,-1] = ¾

**After dual simplex (T-4)**:
| T-4 | x₁ | x₂ | s₁ | s₂ | s₃ | rhs |
|-----|----|----|----|----|----|----|
| z   | 0  | 0  | 5  | 0  | 3  | 39  |
| 1   | 0  | 1  | 1  | 0  | -1 | 3   |
| 2   | 1  | 0  | 0  | 0  | 1  | 3   |
| 3   | 0  | 0  | -5 | 1  | -4 | 3   |

**Solution**: x₁ = 3, x₂ = 3, z = 39
**Status**: **INTEGER SOLUTION** → **Incumbent = 39**

#### Sub-Problem 2: x₁ ≥ 4
**Add constraint**: x₁ - e₃ = 4

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
1. **Largest fractional part rule** (most common)
2. **Most promising variable** (based on objective coefficients)
3. **First fractional variable** encountered
4. **Arbitrary selection** among fractional variables

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

### Excel Implementation Tips
- **Use separate worksheets** for each sub-problem
- **Track incumbent solution** across all nodes
- **Document branching decisions** clearly
- **Verify integer constraints** in final solutions
- **Calculate bounds accurately** at each node

### Business Applications
- **Production planning**: Integer units of products
- **Project selection**: Binary investment decisions  
- **Scheduling**: Discrete time periods or resources
- **Facility location**: Integer number of facilities
- **Supply chain**: Integer quantities and routes

---

*This comprehensive guide demonstrates the complete Branch & Bound methodology using the Oakfield Corporation example from the Belgium Campus Linear Programming course materials.*