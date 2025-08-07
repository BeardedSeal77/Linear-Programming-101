# 3-3 Cutting Plane Algorithm

## Overview

The Cutting Plane Algorithm is a method for solving Integer Programming (IP) problems. It works by iteratively adding constraints ("cuts") to eliminate fractional solutions from the relaxed Linear Programming problem until an integer solution is found.

## How It Works

1. **Relax the Integer Constraints**: Start by solving the relaxed LP (without integer constraints)
2. **Check Solution**: If all variables requiring integer values are integers, STOP - optimal solution found
3. **Generate a Cut**: If fractional values exist, create a cutting plane constraint
4. **Add Cut and Re-solve**: Add the new constraint and solve again
5. **Repeat**: Continue until an integer solution is obtained

## The Cutting Plane Process

### Step 1: Choose Variable to Cut
- Choose the variable with fractional value **closest to 0.5**
- If multiple variables have the same distance from 0.5, choose the one with the **lower subscript**

### Step 2: Generate the Cut
From the optimal tableau, for the chosen variable with fractional value:
- Take the constraint row containing that variable
- For each coefficient, separate integer and fractional parts
- Create the cutting constraint using only fractional parts

## Worked Example: Oakfield Corporation

**Problem:**
```
max z = 5x₁ + 2x₂
s.t. 3x₁ + x₂ ≤ 12
     x₁ + x₂ ≤ 5
     x₁, x₂ ≥ 0
     x₁, x₂ integers
```

### Solution Process

**Step 1:** Solve relaxed LP
- Optimal solution: x₁ = 1, x₂ = 2.25, z = 9.5
- Since x₂ = 2.25 is fractional, we need to cut

**Step 2:** Generate cut on x₂
From the optimal tableau row for x₂:
- x₂ = 2¼ - ¼s₁ + ¼s₂

**Step 3:** Create cutting constraint
- Fractional parts: ¼, -¼, +¼
- Cut: -¼s₁ + ¼s₂ ≤ -¼
- Multiply by -4: s₁ - s₂ ≥ 1
- Add slack: s₁ - s₂ - s₃ = 1

**Step 4:** Solve with cut added
- New optimal solution: x₁ = 1, x₂ = 2, z = 9
- All variables are integers → OPTIMAL SOLUTION FOUND

## Key Rules for Cutting Plane Algorithm

1. **Variable Selection**: Choose variable closest to 0.5 from integer value
2. **Cut Generation**: Use fractional parts of coefficients in tableau row
3. **Constraint Form**: Cut is always ≤ 0 (for maximization problems)
4. **Termination**: Stop when all integer variables have integer values

## Alternative Example: Pure Integer Problem

**Problem:**
```
max z = 5x₁ + 2x₂
s.t. 3x₁ + x₂ ≤ 12
     x₁ + x₂ ≤ 5
     x₁, x₂ ≥ 0
     x₁, x₂ integers
```

**Solution Steps:**
1. **Initial LP Solution**: x₁ = 3.75, x₂ = 1.25, z = 21.25
2. **Choose Cut Variable**: x₁ (distance from integer = 0.25) vs x₂ (distance = 0.25)
   - Since both equal distance, choose x₁ (lower subscript)
3. **Generate Cut**: From x₁ tableau row, create cutting constraint
4. **Add Cut and Re-solve**: Continue until integer solution found
5. **Final Result**: x₁ = 3, x₂ = 1, z = 17

## When to Use Cutting Plane Algorithm

- **Pure Integer Programming**: All variables must be integers
- **Mixed Integer Programming**: Some variables must be integers
- **Small to Medium Problems**: More efficient than Branch & Bound for certain problem types
- **When Few Cuts Needed**: Algorithm works best when solution is close to integer values

## Advantages and Disadvantages

**Advantages:**
- Systematic approach to finding integer solutions
- Guaranteed to find optimal integer solution
- Works well when relaxed solution is close to integer values

**Disadvantages:**
- Can require many iterations (many cuts)
- May become computationally expensive for large problems
- Numerical stability issues with many cuts added

## Comparison with Branch & Bound

| Aspect | Cutting Plane | Branch & Bound |
|--------|---------------|----------------|
| Approach | Add constraints | Divide problem space |
| Memory Usage | Single problem | Multiple subproblems |
| Iterations | Potentially many | Systematic tree search |
| Best For | Problems near integer solutions | General integer programming |