# Cutting Plane Algorithm

## 3a) Solve the Integer Programming Model using the Cutting Plane Algorithm

## Starting Point: Optimal LP Relaxation Solution

We start with the optimal table after solving the primal LP relaxation:

| Basis | x1 | x2 | x3 | x4 | x5 | x6 | s1 | s2 | s3 | s4 | s5 | s6 | s7 | RHS |
|-------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| z | 0.2 | 0 | 0 | 0 | 0 | 0 | 0.2 | 0 | 1.4 | 1.8 | 2.2 | 0 | 2 | 15.4 |
| x5 | 1.1 | 0 | 0 | 0 | 1 | 0 | 0.1 | 0 | -0.8 | -0.6 | -1.4 | 0 | -1 | 0.2 |
| x2 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| x3 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 1 |
| x4 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 |
| x1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 1 |
| s6 | -1.1 | 0 | 0 | 0 | 0 | 0 | -0.1 | 0 | 0.8 | 0.6 | 1.4 | 1 | 1 | 0.8 |
| x6 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |

**Current Solution:** x1=1, x2=1, x3=1, x4=1, x5=0.2, x6=1, z=15.4

## Step 1: Identify Fractional Decision Variables

Looking at the RHS column for **decision variables only**:
- x5 = 0.2 (fractional decision variable)
- s6 = 0.8 (slack variable - ignore for cutting plane)

**Important:** We only consider fractional decision variables (x1, x2, etc.), not slack variables (s1, s2, etc.).

## Step 2: Generate Cutting Plane

Since x5 is the only fractional decision variable, we use the **x5 row** to generate our cut.

From the x5 row: x5 = 1.1x1 + 0x2 + 0x3 + 0x4 + x5 + 0x6 + 0.1s1 + 0s2 - 0.8s3 - 0.6s4 - 1.4s5 + 0s6 - s7 + 0.2

## Step 3: Create Gomory Cut - Detailed Process

**Step 3a: Break down the x5 row into integers and fractions**

| Component | x1  | x2 | x3 | x4 | x5 | x6 | s1  | s2 | s3   | s4   | s5   | s6 | s7 | RHS |
|-----------|-----|----|----|----|----|----|----|----| -----|------|------|----|----|-----|
| Original  | 1.1 | 0  | 0  | 0  | 1  | 0  | 0.1| 0  | -0.8 | -0.6 | -1.4 | 0  | -1 | 0.2 |
| Integers  | 1   | 0  | 0  | 0  | 1  | 0  | 0  | 0  | -1   | -1   | -2   | 0  | -1 | 0   |
| Fractions | 0.1 | 0  | 0  | 0  | 0  | 0  | 0.1| 0  | 0.2  | 0.4  | 0.6  | 0  | 0  | 0.2 |

**Step 3b: Extract fractional parts (all must be positive)**

**Rule:** 
- If coefficient ≥ 0: fractional part = coefficient - floor(coefficient)
- If coefficient < 0: fractional part = coefficient - floor(coefficient)

**Calculations:**
- x1: 1.1 → 1.1 - 1 = 0.1
- s1: 0.1 → 0.1 - 0 = 0.1  
- s3: -0.8 → -0.8 - (-1) = 0.2 *(shift down to -1)*
- s4: -0.6 → -0.6 - (-1) = 0.4 *(shift down to -1)*
- s5: -1.4 → -1.4 - (-2) = 0.6 *(shift down to -2)*
- s7: -1.0 → -1.0 - (-1) = 0.0 *(exactly -1, no fraction)*
- RHS: 0.2 → 0.2 - 0 = 0.2

**Step 3c: Cutting plane constraint:**
0.1x1 + 0.1s1 + 0.2s3 + 0.4s4 + 0.6s5 + s8 = 0.2

Where s8 is the new slack variable.

## Step 4: Add Cut to Tableau

**Key Points:**
1. **Row 1 (x5 constraint) stays exactly as is** - we don't modify the original constraint
2. We create a **new row 8** with the cutting plane constraint
3. The cutting plane is written as: **-0.1x1 - 0.1s1 - 0.2s3 - 0.4s4 - 0.6s5 + s8 = -0.2**

**Why negative coefficients?**
The Gomory cut constraint 0.1x1 + 0.1s1 + 0.2s3 + 0.4s4 + 0.6s5 + s8 = 0.2 gets rearranged for the tableau format:
- Move all variables to left side: 0.1x1 + 0.1s1 + 0.2s3 + 0.4s4 + 0.6s5 - s8 = 0.2
- For standard form tableau, we need: -0.1x1 - 0.1s1 - 0.2s3 - 0.4s4 - 0.6s5 + s8 = -0.2

**New tableau with cutting plane added (before pivoting):**

| Basis | x1   | x2 | x3 | x4 | x5 | x6 | s1   | s2 | s3   | s4   | s5   | s6 | s7 | s8   | RHS  |
|-------|------|----|----|----|----|----|----- |----|------|------|------|----|----|------|------|
| z     | 0.2  | 0  | 0  | 0  | 0  | 0  | 0.2  | 0  | 1.4  | 1.8  | 2.2  | 0  | 2  | 0    | 15.4 |
| x5    | 1.1  | 0  | 0  | 0  | 1  | 0  | 0.1  | 0  | -0.8 | -0.6 | -1.4 | 0  | -1 | 0    | 0.2  |
| x2    | 1    | 0  | 0  | 0  | 0  | 0  | 0    | 1  | 0    | 0    | 0    | 0  | 0  | 0    | 1    |
| x3    | 0    | 1  | 0  | 0  | 0  | 0  | 0    | 0  | 1    | 0    | 0    | 0  | 0  | 0    | 1    |
| x4    | 0    | 0  | 1  | 0  | 0  | 0  | 0    | 0  | 0    | 1    | 0    | 0  | 0  | 0    | 1    |
| x1    | 0    | 0  | 0  | 1  | 0  | 0  | 0    | 0  | 0    | 0    | 1    | 0  | 0  | 0    | 1    |
| s6    | -1.1 | 0  | 0  | 0  | 0  | 0  | -0.1 | 0  | 0.8  | 0.6  | 1.4  | 1  | 1  | 0    | 0.8  |
| x6    | 0    | 0  | 0  | 0  | 0  | 1  | 0    | 0  | 0    | 0    | 0    | 0  | 1  | 0    | 1    |
| s8    | -0.1 | 0  | 0  | 0  | 0  | 0  | -0.1 | 0  | -0.2 | -0.4 | -0.6 | 0  | 0  | 1    | -0.2 |

## Step 5: Dual Simplex Method

Since adding the cutting plane makes the solution infeasible (RHS = -0.2 < 0), we use the **dual simplex method** to regain feasibility.

### Dual Simplex Rules:

**1. Pivot Row Selection (Leaving Variable):**
- Choose the row with the **most negative RHS value**
- Current candidates: s8 = -0.2
- **Choose s8 row** (most negative RHS)

**2. Pivot Column Selection (Entering Variable):**
- Only consider columns where the pivot row has **negative coefficients**
- For s8 row, negative coefficients in: x1(-0.1), s1(-0.1), s3(-0.2), s4(-0.4), s5(-0.6)
- Calculate ratio: **|z-row coefficient / pivot row coefficient|**
- Choose column with **smallest ratio**

**Ratios for s8 row:**
- x1: |0.2 / (-0.1)| = |-2| = 2
- s1: |0.2 / (-0.1)| = |-2| = 2  
- s3: |1.4 / (-0.2)| = |-7| = 7
- s4: |1.8 / (-0.4)| = |-4.5| = 4.5
- s5: |2.2 / (-0.6)| = |-3.67| = 3.67

**Smallest ratio: 2**

Choose either x1 or s1 column (both have ratio -2). Let's choose **x1 column**.

**Pivot element: -0.1** (intersection of s8 row and x1 column)

Fill in the blanks for the table before the first cut including the new constraint included:
