# 4-1 Task Assignment & Hungarian Algorithm

## Overview

The Task Assignment Problem (also known as the Assignment Problem) is a special case of Integer Programming where we need to assign agents to tasks in an optimal way. Each agent can be assigned to exactly one task, and each task can be assigned to exactly one agent.

## Problem Characteristics

- **One-to-One Assignment**: Each agent gets exactly one task, each task gets exactly one agent
- **Binary Decision Variables**: xᵢⱼ = 1 if agent i is assigned to task j, 0 otherwise
- **Square Cost Matrix**: Usually n agents and n tasks (if not, add dummy rows/columns)
- **Optimization Goal**: Minimize total cost or maximize total benefit

## Mathematical Formulation

### Decision Variables
xᵢⱼ = 1 if agent i is assigned to task j, 0 otherwise

### Objective Function
```
Minimize z = Σᵢ Σⱼ cᵢⱼ × xᵢⱼ
```
where cᵢⱼ is the cost of assigning agent i to task j

### Constraints

**Agent Constraints** (each agent gets exactly one task):
```
Σⱼ xᵢⱼ = 1    for all i
```

**Task Constraints** (each task gets exactly one agent):
```
Σᵢ xᵢⱼ = 1    for all j
```

**Binary Constraints**:
```
xᵢⱼ ∈ {0, 1}    for all i, j
```

## Hungarian Algorithm Steps

### Step 1: Matrix Preparation
- Add dummy rows/columns if matrix is not square
- Use large costs (M) for impossible assignments

### Step 2: Row Reduction
- Subtract the minimum value in each row from all elements in that row

### Step 3: Column Reduction
- Subtract the minimum value in each column from all elements in that column

### Step 4: Optimality Test
- Draw minimum number of lines to cover all zeros
- If number of lines = matrix size → **OPTIMAL** (go to Step 6)
- If number of lines < matrix size → **NOT OPTIMAL** (go to Step 5)

### Step 5: Matrix Modification
- **5a**: Find smallest uncovered element (call it 'a')
- **5b**: Subtract 'a' from all uncovered elements
- **5c**: Add 'a' to all elements covered by two lines
- **5d**: Leave elements covered by one line unchanged
- Return to Step 4

### Step 6: Solution Assignment
- Select zeros to form optimal assignment
- Calculate total cost using original matrix values

## Worked Example: Agent Assignment

**Problem**: Assign agents A, B, C to tasks α, β, γ

**Cost Matrix**:
```
      α   β   γ
  A   1   2   4
  B   5   3   4  
  C   5   4   8
```

**Mathematical Model**:
```
minimize z = x₁₁ + 2x₁₂ + 4x₁₃ + 5x₂₁ + 3x₂₂ + 4x₂₃ + 5x₃₁ + 4x₃₂ + 8x₃₃

s.t.  x₁₁ + x₁₂ + x₁₃ = 1    (Agent A gets one task)
      x₂₁ + x₂₂ + x₂₃ = 1    (Agent B gets one task)  
      x₃₁ + x₃₂ + x₃₃ = 1    (Agent C gets one task)
      
      x₁₁ + x₂₁ + x₃₁ = 1    (Task α gets one agent)
      x₁₂ + x₂₂ + x₃₂ = 1    (Task β gets one agent)
      x₁₃ + x₂₃ + x₃₃ = 1    (Task γ gets one agent)
      
      xᵢⱼ ∈ {0, 1}
```

### Hungarian Algorithm Solution:

**Step 1**: Matrix is already square, no dummy needed

**Step 2**: Row Reduction
```
Original:        After Row Reduction:
  1  2  4    →      0  1  3
  5  3  4    →      2  0  1  
  5  4  8    →      1  0  4
```

**Step 3**: Column Reduction
```
After Row:       After Column:
  0  1  3    →      0  1  2
  2  0  1    →      2  0  0
  1  0  4    →      1  0  3
```

**Step 4**: Optimality Test
- Draw lines to cover all zeros
- Need 3 lines to cover all zeros = matrix size (3)
- **OPTIMAL!**

**Step 5**: Select Assignments
```
Final Matrix:    Selected Zeros:
  0  1  2         [0] 1  2     → A → α
  2  0 [0]        2  [0] 0     → B → β  
  1 [0] 3         1   0  3     → C → β (conflict!)
```

Resolve conflicts by selecting:
- A → α (cost = 1)
- B → γ (cost = 4) 
- C → β (cost = 4)

**Total Cost**: 1 + 4 + 4 = 9

## Exercise Example: Employee Job Assignment

**Problem**: 5 employees available for 4 jobs with given time requirements

**Time Matrix**:
```
      Job1  Job2  Job3  Job4
Emp1   22    18    30    18
Emp2   18     -    27    22  
Emp3   26    20    28    28
Emp4   16    22     -    14
Emp5   21     -    25    28
```

**Solution Approach**:
1. **Add Dummy Column**: Since 5 employees and 4 jobs, add dummy job with cost 0
2. **Handle Dashes**: Replace impossible assignments (-) with very large cost (M)
3. **Apply Hungarian Algorithm**: Follow the 6-step process
4. **Interpret Results**: One employee will be unassigned (gets dummy job)

## Key Applications

### Business Applications
- **Staff Scheduling**: Assign workers to shifts
- **Project Management**: Assign team members to tasks
- **Resource Allocation**: Assign machines to jobs

### Transportation
- **Vehicle Routing**: Assign drivers to routes
- **Delivery Assignment**: Assign packages to delivery personnel

### Sports & Entertainment
- **Team Selection**: Assign players to positions
- **Event Scheduling**: Assign venues to events

## Advantages of Hungarian Algorithm

1. **Guaranteed Optimality**: Always finds the optimal solution
2. **Polynomial Time**: O(n³) complexity
3. **Handles Special Cases**: Unbalanced problems (with dummies)
4. **No Integer Constraints Needed**: LP relaxation gives integer solution

## Comparison with Other Methods

| Method | Time Complexity | Memory | Optimal? |
|--------|----------------|--------|----------|
| Hungarian | O(n³) | O(n²) | Yes |
| Branch & Bound | Exponential | High | Yes |
| Greedy | O(n²) | O(n²) | No |
| Simplex | O(n³) | O(n²) | Yes |

## When to Use Hungarian Algorithm

**Best For**:
- Pure assignment problems (one-to-one)
- Square or near-square cost matrices
- Problems requiring guaranteed optimal solution

**Not Suitable For**:
- Multiple assignments per agent
- Complex additional constraints
- Very large problems (n > 1000)

## Special Cases

### Maximization Problems
- Convert to minimization by using: new_cost = M - original_cost
- Where M is larger than the maximum original cost

### Unbalanced Problems
- More agents than tasks: Add dummy tasks with cost 0
- More tasks than agents: Add dummy agents with cost 0

### Forbidden Assignments
- Use very large cost (M) instead of infinity
- Algorithm will avoid these assignments if possible