# 4-2 Capital Budgeting & Knapsack Problems

## Overview

Capital Budgeting problems involve selecting a subset of investment projects to maximize return while staying within budget constraints. These are also known as **0-1 Knapsack Problems** because each project is either selected (1) or not selected (0) - there's no partial investment allowed.

## Problem Characteristics

- **Binary Decision Variables**: Each investment/project is either fully selected or not at all
- **Budget Constraint**: Limited capital available for investment
- **Net Present Value (NPV)**: Projects provide returns that must be maximized
- **Logical Constraints**: Dependencies between projects (if-then relationships)

## Mathematical Formulation

### Basic Capital Budgeting Model

**Decision Variables:**
```
xᵢ = 1 if project i is selected, 0 otherwise
```

**Objective Function:**
```
Maximize z = Σ NPVᵢ × xᵢ
```

**Budget Constraint:**
```
Σ Costᵢ × xᵢ ≤ Available_Budget
```

**Binary Constraints:**
```
xᵢ ∈ {0, 1} for all i
```

## Worked Example: Stocks & Bonds Investment

**Problem Statement:**
Stocks & Bonds is considering 4 investments with the following data:

| Investment | NPV (R000) | Cost (R000) |
|------------|------------|-------------|
| 1          | 16         | 5           |
| 2          | 22         | 7           |
| 3          | 12         | 4           |
| 4          | 8          | 3           |

Available budget: R14,000

### Basic Model Formulation

**Decision Variables:**
```
x₁ = 1 if invest in project 1, 0 otherwise
x₂ = 1 if invest in project 2, 0 otherwise  
x₃ = 1 if invest in project 3, 0 otherwise
x₄ = 1 if invest in project 4, 0 otherwise
```

**Complete Model:**
```
Maximize z = 16x₁ + 22x₂ + 12x₃ + 8x₄

Subject to:
5x₁ + 7x₂ + 4x₃ + 3x₄ ≤ 14    (Budget constraint)
xᵢ ∈ {0, 1} for i = 1,2,3,4     (Binary constraints)
```

### Solution Analysis
Using enumeration or optimization software:
- **Optimal Solution**: x₁ = 1, x₂ = 1, x₃ = 0, x₄ = 1
- **Total Cost**: 5 + 7 + 0 + 3 = 15 ≤ 14 (INFEASIBLE!)
- **Correct Optimal**: x₁ = 1, x₂ = 1, x₃ = 0, x₄ = 0
- **Total Cost**: 5 + 7 = 12 ≤ 14 ✓
- **Maximum NPV**: 16 + 22 = R38,000

## Advanced Constraints: Logical Dependencies

### 1. At Most K Projects
*"Invest in at most 2 projects"*
```
x₁ + x₂ + x₃ + x₄ ≤ 2
```

### 2. Conditional Investment (If-Then)
*"If invest in project 2, must also invest in project 1"*
```
x₂ ≤ x₁   or   x₂ - x₁ ≤ 0
```

**Truth Table Verification:**
| x₂ | x₁ | Valid? | x₂ ≤ x₁ |
|----|----|---------|----|
| 1  | 1  | ✓      | 1 ≤ 1 ✓ |
| 1  | 0  | ✗      | 1 ≤ 0 ✗ |
| 0  | 1  | ✓      | 0 ≤ 1 ✓ |
| 0  | 0  | ✓      | 0 ≤ 0 ✓ |

### 3. Mutually Exclusive Projects
*"Cannot invest in both project 2 and project 4"*
```
x₂ + x₄ ≤ 1
```

### 4. Either-Or Constraint
*"Must invest in either project 2 or project 3 (or both)"*
```
x₂ + x₃ ≥ 1
```

### 5. Equivalence (If and Only If)
*"Invest in project 1 if and only if invest in project 5"*
```
x₁ = x₅   or   x₁ - x₅ = 0
```

## Complex Example: Football Team Selection

**Problem**: Select 5 players from 7 available players to maximize defensive ability.

**Player Data:**
| Player | Position | Ball-handling | Shooting | Tackling | Defense |
|--------|----------|---------------|----------|----------|---------|
| 1      | B        | 3             | 3        | 1        | 3       |
| 2      | C        | 2             | 1        | 3        | 2       |
| 3      | B-F      | 2             | 3        | 2        | 2       |
| 4      | F-C      | 1             | 3        | 3        | 1       |
| 5      | B-F      | 3             | 3        | 3        | 3       |
| 6      | F-C      | 3             | 1        | 2        | 3       |
| 7      | B-F      | 3             | 2        | 2        | 1       |

### Mathematical Model

**Decision Variables:**
```
xᵢ = 1 if player i is selected, 0 otherwise (i = 1,2,...,7)
```

**Objective Function:**
```
Maximize z = 3x₁ + 2x₂ + 2x₃ + x₄ + 3x₅ + 3x₆ + x₇
```

**Constraints:**

1. **Team Size**: Exactly 5 players
   ```
   x₁ + x₂ + x₃ + x₄ + x₅ + x₆ + x₇ = 5
   ```

2. **Position Requirements**:
   - At least 4 backfield players: `x₁ + x₃ + x₅ + x₇ ≥ 4`
   - At least 2 forward players: `x₃ + x₄ + x₅ + x₆ + x₇ ≥ 2`  
   - At least 1 center player: `x₂ + x₄ + x₆ ≥ 1`

3. **Skill Requirements** (average ≥ 2):
   ```
   Ball-handling: (3x₁ + 2x₂ + 2x₃ + x₄ + 3x₅ + 3x₆ + 3x₇)/5 ≥ 2
   Shooting: (3x₁ + x₂ + 3x₃ + 3x₄ + 3x₅ + x₆ + 2x₇)/5 ≥ 2
   Tackling: (x₁ + 3x₂ + 2x₃ + 3x₄ + 3x₅ + 2x₆ + 2x₇)/5 ≥ 2
   ```

4. **Logical Constraints**:
   - If player 3 starts, player 6 cannot: `x₃ + x₆ ≤ 1`
   - If player 1 starts, players 4 and 5 must: `x₄ ≥ x₁` and `x₅ ≥ x₁`
   - Either player 2 or 3 must start: `x₂ + x₃ ≥ 1`

## Real-World Applications

### Investment Portfolio Selection
- **Projects**: Stocks, bonds, real estate, startups
- **Constraints**: Budget, risk limits, sector diversification
- **Objective**: Maximize expected return or minimize risk

### Resource Allocation
- **Projects**: R&D initiatives, marketing campaigns, facility upgrades  
- **Constraints**: Budget, human resources, time
- **Objective**: Maximize ROI or strategic value

### Project Selection in IT
- **Projects**: Software upgrades, security implementations, new features
- **Constraints**: Budget, developer hours, infrastructure capacity
- **Objective**: Maximize business value or user satisfaction

## Common Constraint Patterns

### 1. Mandatory Inclusion
*"Project X must be selected"*
```
xₓ = 1
```

### 2. Mandatory Exclusion  
*"Project Y cannot be selected"*
```
xᵧ = 0
```

### 3. Minimum Selection
*"Select at least 3 projects from group A"*
```
Σ(xᵢ for i ∈ Group_A) ≥ 3
```

### 4. Maximum Selection
*"Select at most 2 projects from group B"*  
```
Σ(xᵢ for i ∈ Group_B) ≤ 2
```

### 5. Conditional Requirements
*"If select project A, must also select projects B and C"*
```
xᵦ ≥ xₐ
xᴄ ≥ xₐ
```

## Solution Approaches

### 1. Complete Enumeration
- **Suitable For**: Small problems (≤ 20 variables)
- **Method**: Check all 2ⁿ possible combinations
- **Advantage**: Guarantees optimal solution
- **Disadvantage**: Exponential time complexity

### 2. Branch & Bound
- **Suitable For**: Medium problems (20-100 variables)
- **Method**: Systematic tree search with bounds
- **Advantage**: Optimal solution with pruning
- **Disadvantage**: Can be slow for large problems

### 3. Dynamic Programming
- **Suitable For**: Single constraint knapsack
- **Method**: Build solution incrementally
- **Advantage**: Polynomial time for single constraint
- **Disadvantage**: Limited to specific problem structures

### 4. Heuristic Methods
- **Suitable For**: Large problems (100+ variables)
- **Methods**: Greedy algorithms, genetic algorithms
- **Advantage**: Fast solutions for large problems
- **Disadvantage**: No guarantee of optimality

## Sensitivity Analysis

After finding optimal solution, analyze:

1. **Shadow Price of Budget**: How much would increasing budget by R1 improve NPV?
2. **Critical Projects**: Which projects are in all optimal solutions?
3. **Marginal Projects**: Which projects are barely included/excluded?
4. **Constraint Impact**: Which constraints are most restrictive?

## Extensions and Variants

### 1. Multiple Resource Constraints
```
Σ Labor_Hours_i × xᵢ ≤ Available_Labor
Σ Equipment_i × xᵢ ≤ Available_Equipment  
Σ Budget_i × xᵢ ≤ Available_Budget
```

### 2. Multi-Period Capital Budgeting
- Projects span multiple time periods
- Budget constraints for each period
- Cash flows occur over time

### 3. Portfolio Optimization
- Include risk measures (variance, VaR)
- Correlation between investments
- Diversification requirements

### 4. Integer Multiples
- Allow selecting multiple units of same project
- Upper bounds on quantities
- Economies of scale considerations

## Key Success Factors

1. **Clear Objective**: Define what you're optimizing (NPV, ROI, strategic value)
2. **Realistic Constraints**: Include all relevant limitations and dependencies
3. **Accurate Data**: Ensure cost and benefit estimates are reliable
4. **Sensitivity Analysis**: Test robustness of solution to parameter changes
5. **Implementation Feasibility**: Consider practical aspects of selected projects

## Common Pitfalls

1. **Ignoring Dependencies**: Missing logical relationships between projects
2. **Over-constraining**: Adding too many restrictions leading to infeasibility
3. **Poor Data Quality**: Garbage in, garbage out
4. **Single Period Focus**: Ignoring multi-period implications
5. **Neglecting Risk**: Focusing only on expected returns without considering uncertainty