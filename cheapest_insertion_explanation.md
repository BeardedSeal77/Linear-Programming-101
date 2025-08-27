## Cheapest Insertion Algorithm Explanation

### Step 1: Initial Tour
We start with the **shortest edge in the entire distance matrix**: x₅₁ = 58 (Rohan → Gondor)

This creates our initial tour: **5 → 1 → 5** (Rohan → Gondor → Rohan)
- Current tour length: 58 + 116 = 174

### Step 2: Insert Remaining Cities
We still need to visit cities **2, 3, 4, and 6**.

For each unvisited city, we test inserting it at **every possible position** in the current tour:

#### Current tour: 5 → 1 → 5
We can insert a new city in these positions:
1. **Between 5 and 1**: 5 → [new city] → 1 → 5
2. **Between 1 and 5**: 5 → 1 → [new city] → 5

#### Testing City 2 (Isengard):
- Insert between 5→1: 5 → **2** → 1 → 5
  - Cost: x₅₂ + x₂₁ - x₅₁ = 158 + 132 - 58 = **232**
- Insert between 1→5: 5 → 1 → **2** → 5  
  - Cost: x₁₂ + x₂₅ - x₁₅ = 264 + 79 - 116 = **227** ← **Cheapest for city 2**

#### Testing City 3 (Rivendell):
- Insert between 5→1: 5 → **3** → 1 → 5
  - Cost: x₅₃ + x₃₁ - x₅₁ = 303 + 217 - 58 = **462**
- Insert between 1→5: 5 → 1 → **3** → 5
  - Cost: x₁₃ + x₃₅ - x₁₅ = 434 + 606 - 116 = **924** 

#### Testing City 4 (Lothlorien):
- Insert between 5→1: 5 → **4** → 1 → 5
  - Cost: x₅₄ + x₄₁ - x₅₁ = 392 + 164 - 58 = **498**
- Insert between 1→5: 5 → 1 → **4** → 5
  - Cost: x₁₄ + x₄₅ - x₁₅ = 328 + 196 - 116 = **408**

#### Testing City 6 (Mordor):
- Insert between 5→1: 5 → **6** → 1 → 5
  - Cost: x₅₆ + x₆₁ - x₅₁ = 441 + 87 - 58 = **470**
- Insert between 1→5: 5 → 1 → **6** → 5
  - Cost: x₁₆ + x₆₅ - x₁₅ = 174 + 662 - 116 = **720**

### Step 3: Choose Cheapest Insertion
The cheapest insertion is **City 2 between 1→5** with cost **227**.

New tour: **5 → 1 → 2 → 5**
New tour length: 174 + 227 = 401

### Continue Process
Repeat this process for the remaining unvisited cities (3, 4, 6) until all cities are included in the tour.