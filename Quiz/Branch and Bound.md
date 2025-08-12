# Branch & Bound Method - Knapsack Problem

## Problem Statement

Captain America needs to select supplies for transport. Each supply can be taken (1) or not taken (0).

### Knapsack Formulation

**Maximize:** z = 2x1 + 3x2 + 3x3 + 5x4 + 2x5 + 4x6

**Subject to:** 11x1 + 8x2 + 6x3 + 14x4 + 10x5 + 10x6 ≤ 40

**Where:** xi ∈ {0,1} for i = 1,2,3,4,5,6

### Available Supplies

| Supply (Variable) | Weight | Worth | Worth/Weight Ratio |
|-------------------|--------|-------|-------------------|
| Medical supplies (x1) | 11 | 2 | 2/11 = 0.18 |
| Ammunition (x2) | 8 | 3 | 3/8 = 0.375 |
| Food rations (x3) | 6 | 3 | 3/6 = 0.5 |
| Weapons (x4) | 14 | 5 | 5/14 = 0.357 |
| Water (x5) | 10 | 2 | 2/10 = 0.2 |
| Tents (x6) | 10 | 4 | 4/10 = 0.4 |

## Step 1: Rank Items by Worth/Weight Ratio

**Ranking (highest ratio first):**
1. x3 (Food rations): 0.5
2. x6 (Tents): 0.4  
3. x2 (Ammunition): 0.375
4. x4 (Weapons): 0.357
5. x5 (Water): 0.2
6. x1 (Medical supplies): 0.18

## Step 2: Calculate Upper Bound using Fractional Knapsack

**Goal:** Fill knapsack by taking items in ratio order (best ratios first) until we reach capacity of 40.

**Step-by-step filling:**

### Step 1: Take x3 (Food rations) completely
- Take: x3 = 1 (full item)
- Weight used: 6
- Worth gained: 3
- **Total weight so far: 6**
- **Total worth so far: 3** 
- **Remaining capacity: 40 - 6 = 34**

### Step 2: Take x6 (Tents) completely  
- Take: x6 = 1 (full item)
- Weight used: 10
- Worth gained: 4
- **Total weight so far: 6 + 10 = 16**
- **Total worth so far: 3 + 4 = 7**
- **Remaining capacity: 40 - 16 = 24**

### Step 3: Take x2 (Ammunition) completely
- Take: x2 = 1 (full item)  
- Weight used: 8
- Worth gained: 3
- **Total weight so far: 16 + 8 = 24**
- **Total worth so far: 7 + 3 = 10**
- **Remaining capacity: 40 - 24 = 16**

### Step 4: Take x4 (Weapons) completely
- Take: x4 = 1 (full item)
- Weight used: 14  
- Worth gained: 5
- **Total weight so far: 24 + 14 = 38**
- **Total worth so far: 10 + 5 = 15**
- **Remaining capacity: 40 - 38 = 2**

### Step 5: Take x5 (Water) partially
- x5 needs weight 10, but we only have 2 capacity left
- Take: x5 = 2/10 = 0.2 (partial item)
- Weight used: 2 (all remaining capacity)
- Worth gained: 0.2 × 2 = 0.4
- **Total weight so far: 38 + 2 = 40** (knapsack full!)
- **Total worth so far: 15 + 0.4 = 15.4**
- **Remaining capacity: 40 - 40 = 0**

### Step 6: Cannot take x1 (Medical supplies)
- x1 needs weight 11, but we have 0 capacity left
- Take: x1 = 0

**Final fractional knapsack solution:**
- x1 = 0, x2 = 1, x3 = 1, x4 = 1, x5 = 0.2, x6 = 1
- **Upper Bound = 15.4** (this is our maximum possible Z value)

## Step 3: Branch & Bound Tree

### Node 0 (Root)
- **Solution:** x1=0, x2=1, x3=1, x4=1, x5=0.2, x6=1
- **Upper Bound:** 15.4
- **Status:** Fractional (x5=0.2)

### Branching on x5

Create two branches:
- **Node 1:** x5 = 0 (don't take Water)  
- **Node 2:** x5 = 1 (take Water)

### Node 1: x5 = 0

**Constraint:** 11x1 + 8x2 + 6x3 + 14x4 + 10x6 ≤ 40

Using fractional knapsack with x5 = 0:
1. Take x3 = 1: Weight = 6, Worth = 3, Remaining = 34
2. Take x6 = 1: Weight = 16, Worth = 7, Remaining = 24
3. Take x2 = 1: Weight = 24, Worth = 10, Remaining = 16  
4. Take x4 = 1: Weight = 38, Worth = 15, Remaining = 2
5. Take x1 = 2/11 = 0.18: Weight = 40, Worth = 15.36

**Upper Bound:** 15.36
**Status:** Fractional (x1=0.18)

### Node 2: x5 = 1  

**Constraint:** 11x1 + 8x2 + 6x3 + 14x4 + 10x6 ≤ 30 (since x5 takes 10)

Using fractional knapsack with x5 = 1:
1. Take x3 = 1: Weight = 6, Worth = 3, Remaining = 24
2. Take x6 = 1: Weight = 16, Worth = 7, Remaining = 14
3. Take x2 = 1: Weight = 24, Worth = 10, Remaining = 6
4. Cannot take x4 (needs 14 > 6)
5. Cannot take x1 (needs 11 > 6)

**Upper Bound:** 2+3+4+2 = 11
**Solution:** x1=0, x2=1, x3=1, x4=0, x5=1, x6=1
**Status:** Integer solution!

### Node 1.1: x5 = 0, x1 = 0

**Constraint:** 8x2 + 6x3 + 14x4 + 10x6 ≤ 40

Fractional knapsack:
1. Take x3 = 1: Weight = 6, Worth = 3, Remaining = 34
2. Take x6 = 1: Weight = 16, Worth = 7, Remaining = 24
3. Take x2 = 1: Weight = 24, Worth = 10, Remaining = 16
4. Take x4 = 1: Weight = 38, Worth = 15, Remaining = 2

**Upper Bound:** 15
**Solution:** x1=0, x2=1, x3=1, x4=1, x5=0, x6=1
**Status:** Integer solution!

### Node 1.2: x5 = 0, x1 = 1

**Constraint:** 8x2 + 6x3 + 14x4 + 10x6 ≤ 29 (since x1 takes 11)

Fractional knapsack:
1. Take x3 = 1: Weight = 6, Worth = 3, Remaining = 23
2. Take x6 = 1: Weight = 16, Worth = 7, Remaining = 13
3. Take x2 = 1: Weight = 24, Worth = 10, Remaining = 5
4. Cannot take x4 (needs 14 > 5)

**Upper Bound:** 2+3+4+2 = 12
**Solution:** x1=1, x2=1, x3=1, x4=0, x5=0, x6=1
**Status:** Integer solution!

## Final Solution

**Best Integer Solutions Found:**
- Node 1.1: z = 15 (x1=0, x2=1, x3=1, x4=1, x5=0, x6=1)
- Node 2: z = 11 (x1=0, x2=1, x3=1, x4=0, x5=1, x6=1)  
- Node 1.2: z = 12 (x1=1, x2=1, x3=1, x4=0, x5=0, x6=1)

**Optimal Solution:**
- **Take:** Ammunition (x2=1), Food rations (x3=1), Weapons (x4=1), Tents (x6=1)
- **Don't take:** Medical supplies (x1=0), Water (x5=0)
- **Total weight:** 8+6+14+10 = 38 ≤ 40
- **Maximum worth:** 3+3+5+4 = 15