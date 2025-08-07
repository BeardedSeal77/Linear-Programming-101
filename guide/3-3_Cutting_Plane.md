# 3-3 Cutting Plane Algorithm

## Overview

The Cutting Plane Algorithm is a method for solving Integer Programming (IP) problems. It works by iteratively adding constraints ("cuts") to eliminate fractional solutions from the relaxed Linear Programming problem until an integer solution is found.

The algorithm was developed by Ralph Gomory in 1958 and represents one of the first systematic approaches to solving integer programming problems.

## Theoretical Foundation

### Basic Principle
The cutting plane method exploits the fact that every integer programming problem can be solved by adding a finite number of linear constraints (cuts) to its LP relaxation. Each cut:
- **Eliminates** the current fractional optimal solution
- **Preserves** all integer points in the feasible region
- **Tightens** the LP relaxation bound

### Mathematical Framework
For an integer programming problem:
```
max z = cᵀx
s.t. Ax ≤ b
     x ≥ 0, x integer
```

The LP relaxation is:
```
max z = cᵀx  
s.t. Ax ≤ b
     x ≥ 0
```

If the LP solution x* is fractional, we add cuts of the form:
```
πᵀx ≤ π₀
```

Where the cut satisfies:
- πᵀx* > π₀ (current solution violated)
- πᵀx ≤ π₀ for all integer x in original feasible region

## How It Works

1. **Relax the Integer Constraints**: Start by solving the relaxed LP (without integer constraints)
2. **Check Solution**: If all variables requiring integer values are integers, STOP - optimal solution found
3. **Generate a Cut**: If fractional values exist, create a cutting plane constraint
4. **Add Cut and Re-solve**: Add the new constraint and solve again
5. **Repeat**: Continue until an integer solution is obtained

## Gomory Cut Derivation

### Mathematical Derivation

Given an optimal tableau row for a fractional basic variable xᵦ:
```
xᵦ + Σⱼ āⱼxⱼ = b̄
```

Where:
- xᵦ is basic with fractional value b̄
- āⱼ are tableau coefficients  
- xⱼ are non-basic variables

**Step 1: Separate Integer and Fractional Parts**

For any real number r, we can write: r = ⌊r⌋ + frac(r)
Where:
- ⌊r⌋ = floor(r) = largest integer ≤ r
- frac(r) = r - ⌊r⌋ = fractional part ∈ [0,1)

**Step 2: Apply to Tableau Row**

```
xᵦ + Σⱼ (⌊āⱼ⌋ + frac(āⱼ))xⱼ = ⌊b̄⌋ + frac(b̄)
```

Rearranging:
```
xᵦ + Σⱼ ⌊āⱼ⌋xⱼ + Σⱼ frac(āⱼ)xⱼ = ⌊b̄⌋ + frac(b̄)
```

**Step 3: Integrality Argument**

Since xᵦ and all xⱼ must be integer, and ⌊āⱼ⌋, ⌊b̄⌋ are integers:
```
xᵦ + Σⱼ ⌊āⱼ⌋xⱼ = integer
```

Therefore:
```
Σⱼ frac(āⱼ)xⱼ = ⌊b̄⌋ + frac(b̄) - integer = integer + frac(b̄) - integer = frac(b̄)
```

**Step 4: Generate the Cut**

Since frac(āⱼ) ≥ 0 and xⱼ ≥ 0 for all j:
```
Σⱼ frac(āⱼ)xⱼ ≥ 0
```

But we need:
```
Σⱼ frac(āⱼ)xⱼ = frac(b̄) > 0
```

This is impossible since the left side is integer-valued but frac(b̄) is not integer.

**The Gomory Cut:**
```
Σⱼ frac(āⱼ)xⱼ ≥ frac(b̄)
```

This cut:
- Is violated by current fractional solution
- Is satisfied by all integer solutions

## The Cutting Plane Process

### Step 1: Choose Variable to Cut
**Selection Criteria (in order of preference):**
1. **Most fractional**: Choose variable with fractional part closest to 0.5
2. **Lexicographic**: If tied, choose variable with lower subscript
3. **Largest fractional part**: Alternative rule for some implementations

### Step 2: Generate the Cut
From the optimal tableau, for the chosen variable with fractional value:
- Take the constraint row containing that variable
- For each coefficient, separate integer and fractional parts
- Create the cutting constraint using only fractional parts

## Detailed Multi-Cut Example

**Problem:**
```
max z = 7x₁ + 9x₂
s.t. -x₁ + 3x₂ ≤ 6
     7x₁ + x₂ ≤ 35  
     x₁, x₂ ≥ 0
     x₁, x₂ integers
```

### Iteration 1: Initial LP Relaxation

**Step 1:** Solve LP Relaxation
```
Standard form:
max z = 7x₁ + 9x₂
s.t. -x₁ + 3x₂ + s₁ = 6
     7x₁ + x₂ + s₂ = 35
     x₁, x₂, s₁, s₂ ≥ 0
```

**Optimal Tableau:**
```
| Basic | x₁  | x₂  | s₁  | s₂  | RHS  |
|-------|-----|-----|-----|-----|------|
| x₂    | 0   | 1   | 7/22| -1/22| 69/22|
| x₁    | 1   | 0   |-1/22| 3/22 | 99/22|
| z     | 0   | 0   | 46/22|2/22 | 1314/22|
```

**Solution:** x₁ = 99/22 = 4.5, x₂ = 69/22 = 3.136, z = 1314/22 = 59.727

Both variables are fractional, need to cut.

**Step 2:** Select Cut Variable
- x₁ fractional part: frac(4.5) = 0.5
- x₂ fractional part: frac(3.136) = 0.136

Choose x₁ (closest to 0.5).

**Step 3:** Generate Cut from x₁ Row
Row: x₁ - (1/22)s₁ + (3/22)s₂ = 99/22

Separating parts:
- x₁: integer part = 0, fractional part = 0 (x₁ is integer variable)
- s₁ coefficient: -1/22 = -1 + 21/22, fractional part = 21/22
- s₂ coefficient: 3/22 = 0 + 3/22, fractional part = 3/22
- RHS: 99/22 = 4 + 11/22, fractional part = 11/22

**Gomory Cut:** (21/22)s₁ + (3/22)s₂ ≥ 11/22

Multiplying by 22: 21s₁ + 3s₂ ≥ 11

### Iteration 2: LP with First Cut

**Step 4:** Add cut as constraint
```
21s₁ + 3s₂ + s₃ = 11 (adding slack s₃)
```

**New Tableau after Dual Simplex:**
```
| Basic | x₁  | x₂  | s₁  | s₂  | s₃  | RHS |
|-------|-----|-----|-----|-----|-----|-----|
| x₂    | 0   | 1   | 1/3 | 0   | 1/63| 3   |
| x₁    | 1   | 0   | 0   | 1/7 |-1/21| 4   |
| s₃    | 0   | 0   | 7   |-1   | 1   | 1   |
| z     | 0   | 0   | 13  | 2   | 2/3 | 55  |
```

**Solution:** x₁ = 4, x₂ = 3, z = 55

Both variables are now integers! 

**Final Optimal Solution:** x₁ = 4, x₂ = 3, z = 55

### Verification
**Check constraints:**
- -x₁ + 3x₂ = -4 + 9 = 5 ≤ 6 ✓
- 7x₁ + x₂ = 28 + 3 = 31 ≤ 35 ✓
- x₁, x₂ ≥ 0 and integer ✓

## Multi-Cut Example: Requires Several Iterations

**Problem:**
```
max z = 3x₁ + 2x₂
s.t. x₁ + x₂ ≤ 3.5
     4x₁ + 2x₂ ≤ 9
     x₁, x₂ ≥ 0 and integer
```

### Iteration 1: Initial Solution
**LP Relaxation:** x₁ = 1.25, x₂ = 2.25, z = 8.25

**Cut 1 (from x₁):** Generated and added
**New solution:** x₁ = 1, x₂ = 2.5, z = 8

### Iteration 2: Second Cut Needed  
**Cut 2 (from x₂):** Generated and added
**New solution:** x₁ = 1, x₂ = 2, z = 7

**Final Result:** x₁ = 1, x₂ = 2, z = 7 (all integer)

This example required **2 cuts** to reach integer optimality.

## Convergence Criteria and Analysis

### Theoretical Convergence

**Finite Convergence Theorem:** 
The Gomory cutting plane algorithm terminates in a finite number of iterations, provided:
1. Non-degeneracy assumptions hold
2. Exact arithmetic is used
3. Problem has a finite optimal solution

**Proof Sketch:**
- Each cut eliminates at least one fractional vertex
- Feasible region contains finite number of integer points
- Algorithm must eventually reach an integer vertex

### Practical Convergence Considerations

#### Convergence Rate Factors
1. **Problem Structure:**
   - **Well-conditioned problems**: Few cuts needed (2-5 typically)
   - **Ill-conditioned problems**: Many cuts required (10+ iterations)
   - **Near-integer LP solutions**: Fast convergence

2. **Numerical Precision:**
   - **Exact arithmetic**: Guaranteed finite convergence
   - **Floating-point arithmetic**: May cycle or converge slowly
   - **Tolerance settings**: Affect cut generation and termination

3. **Cut Selection Strategy:**
   - **Most fractional rule**: Generally good performance
   - **Deepest cut**: May reduce iterations but increase computation per iteration

#### Termination Criteria

**Primary Criterion:**
```
All integer variables xᵢ satisfy: |xᵢ - round(xᵢ)| ≤ ε
```
Where ε is numerical tolerance (typically 10⁻⁶).

**Secondary Criteria:**
1. **Maximum iterations**: Prevent infinite loops due to numerical issues
2. **Degeneracy detection**: Stop if consecutive solutions are identical
3. **Improvement threshold**: Stop if objective improvement < threshold

### Computational Performance Analysis

#### Best Case Scenarios
- **Characteristics**: LP solution close to integer, well-separated integer points
- **Performance**: 1-3 cuts required
- **Industries**: Simple scheduling, basic resource allocation

#### Average Case Scenarios  
- **Characteristics**: Moderate integrality gap, standard constraint structure
- **Performance**: 5-10 cuts required
- **Industries**: Production planning, logistics optimization

#### Worst Case Scenarios
- **Characteristics**: Large integrality gap, dense constraint matrix
- **Performance**: 20+ cuts required, may not be practical
- **Industries**: Complex network design, large-scale facility location

### Numerical Stability Issues

**Common Problems:**
1. **Cut accumulation**: Many cuts lead to numerical difficulties
2. **Coefficient growth**: Cut coefficients become very large
3. **Near-parallel cuts**: Cuts become nearly dependent

**Mitigation Strategies:**
1. **Cut management**: Remove inactive cuts periodically
2. **Coefficient scaling**: Normalize cut coefficients
3. **Restart procedures**: Periodically restart with best integer solution found

## Advanced Cut Generation Techniques

### Mixed Integer Gomory Cuts
For mixed integer programs, generate cuts that respect continuous variable bounds:

**Modified cut formula:**
```
Σⱼ∈I frac(āⱼ)xⱼ + Σⱼ∈C min(frac(āⱼ), 1-frac(āⱼ))xⱼ ≥ frac(b̄)
```

Where:
- I = set of integer variables
- C = set of continuous variables

### Strengthened Gomory Cuts
Enhance basic Gomory cuts by:
1. **Coefficient lifting**: Improve cut coefficients
2. **Cut combination**: Combine multiple cuts intelligently
3. **Problem-specific modifications**: Exploit special structure

## When to Use Cutting Plane Algorithm

### Ideal Applications
- **Pure Integer Programming**: All variables must be integers
- **Problems close to integer solutions**: LP relaxation gives near-integer values
- **Small to medium problems**: Computational overhead manageable
- **Research and education**: Understand cutting plane theory

### Advantages
- **Systematic approach**: Guaranteed to find optimal integer solution
- **Single problem focus**: Works with one LP throughout process
- **Memory efficient**: No tree structure like branch-and-bound
- **Good for tight problems**: When LP relaxation is close to IP optimum

### Disadvantages  
- **Slow convergence**: Can require many iterations
- **Numerical instability**: Accumulation of cuts causes precision issues
- **Not scalable**: Becomes impractical for large problems
- **Limited to Gomory cuts**: Basic implementation uses only one cut type

## Comparison with Other Methods

### Cutting Plane vs Branch-and-Bound

| Aspect | Cutting Plane | Branch-and-Bound |
|--------|---------------|------------------|
| **Approach** | Add constraints | Divide solution space |
| **Memory Usage** | Single problem | Multiple subproblems |
| **Convergence** | Can be slow | More predictable |
| **Best For** | Problems near integer solutions | General integer programming |
| **Scalability** | Limited | Better for large problems |
| **Implementation** | Simpler | More complex |

### Modern Hybrid Approaches
**Cut-and-Branch:**
1. Generate cuts at root node
2. Apply branch-and-bound to remaining fractional variables
3. Generate cuts at selected nodes in branch-and-bound tree

**Benefits:**
- Combines strengths of both methods
- Used in commercial solvers (CPLEX, Gurobi)
- Achieves better performance than either method alone

---

## Key Takeaways

### Theoretical Insights
1. **Finite convergence**: Algorithm guaranteed to terminate
2. **Cut validity**: Gomory cuts preserve all integer solutions
3. **Optimality**: Finds true integer optimum (not heuristic)

### Practical Guidelines
1. **Use for small-medium problems**: Computational limitations for large instances
2. **Check LP relaxation gap**: Large gaps suggest many cuts needed
3. **Monitor numerical stability**: Watch for coefficient growth
4. **Consider hybrid approaches**: Cutting planes + branch-and-bound

### Implementation Considerations
1. **Tolerance settings**: Balance accuracy vs. convergence speed  
2. **Cut management**: Remove inactive cuts to maintain numerical stability
3. **Termination criteria**: Use multiple stopping conditions
4. **Preprocessing**: Strengthen formulation before applying cuts

The cutting plane algorithm remains a fundamental technique in integer programming, providing both theoretical insights and practical solutions for appropriately sized problems. While modern solvers use more sophisticated hybrid approaches, understanding pure cutting plane methods is essential for advanced optimization study and research.