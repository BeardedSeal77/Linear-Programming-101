# Location IP Problem: Warehouse Selection

## Problem Statement

A company is considering opening warehouses in four cities: Sydney, Perth, Brisbane, and Melbourne. Each warehouse can ship 100 units per week. The company needs to determine which warehouses to open to meet regional demands at minimum cost.

## Data

### Weekly Fixed Costs (AU$)
- Sydney: $400
- Perth: $500
- Brisbane: $300
- Melbourne: $150

### Weekly Demand (units)
- Region 1: 80 units
- Region 2: 70 units
- Region 3: 40 units

### Shipping Costs (AU$ per unit)
| From/To     | Region 1 | Region 2 | Region 3 |
|-------------|----------|----------|----------|
| Sydney      | 20       | 40       | 50       |
| Perth       | 48       | 15       | 26       |
| Brisbane    | 26       | 35       | 18       |
| Melbourne   | 24       | 50       | 35       |

### Capacity
- Each warehouse: 100 units per week

## Constraints
1. If the Sydney warehouse is opened, then the Perth warehouse must be opened
2. At most two warehouses can be opened
3. Either the Melbourne or the Perth warehouse must be opened

## Mathematical Formulation

### Decision Variables

#### Binary Variables (Warehouse Selection)
- y₁ = 1 if Sydney warehouse is opened, 0 otherwise
- y₂ = 1 if Perth warehouse is opened, 0 otherwise
- y₃ = 1 if Brisbane warehouse is opened, 0 otherwise
- y₄ = 1 if Melbourne warehouse is opened, 0 otherwise

#### Continuous Variables (Shipping Quantities)
- x₁₁ = units shipped from Sydney to Region 1
- x₁₂ = units shipped from Sydney to Region 2
- x₁₃ = units shipped from Sydney to Region 3
- x₂₁ = units shipped from Perth to Region 1
- x₂₂ = units shipped from Perth to Region 2
- x₂₃ = units shipped from Perth to Region 3
- x₃₁ = units shipped from Brisbane to Region 1
- x₃₂ = units shipped from Brisbane to Region 2
- x₃₃ = units shipped from Brisbane to Region 3
- x₄₁ = units shipped from Melbourne to Region 1
- x₄₂ = units shipped from Melbourne to Region 2
- x₄₃ = units shipped from Melbourne to Region 3

### Objective Function
Minimize Total Cost = Fixed Costs + Shipping Costs

**Minimize:**
400y₁ + 500y₂ + 300y₃ + 150y₄ + 
20x₁₁ + 40x₁₂ + 50x₁₃ + 
48x₂₁ + 15x₂₂ + 26x₂₃ + 
26x₃₁ + 35x₃₂ + 18x₃₃ + 
24x₄₁ + 50x₄₂ + 35x₄₃

### Constraints

#### Demand Constraints
- x₁₁ + x₂₁ + x₃₁ + x₄₁ = 80  (Region 1 demand)
- x₁₂ + x₂₂ + x₃₂ + x₄₂ = 70  (Region 2 demand)
- x₁₃ + x₂₃ + x₃₃ + x₄₃ = 40  (Region 3 demand)

#### Capacity Constraints
- x₁₁ + x₁₂ + x₁₃ ≤ 100y₁  (Sydney capacity)
- x₂₁ + x₂₂ + x₂₃ ≤ 100y₂  (Perth capacity)
- x₃₁ + x₃₂ + x₃₃ ≤ 100y₃  (Brisbane capacity)
- x₄₁ + x₄₂ + x₄₃ ≤ 100y₄  (Melbourne capacity)

#### Special Constraints
- y₁ ≤ y₂  (If Sydney opens, Perth must open)
- y₁ + y₂ + y₃ + y₄ ≤ 2  (At most two warehouses)
- y₂ + y₄ ≥ 1  (Either Perth or Melbourne must open)

#### Non-negativity and Binary Constraints
- xᵢⱼ ≥ 0 for all i,j
- yᵢ ∈ {0,1} for i = 1,2,3,4

## Excel Solver Setup

### Variable Table Structure

| Variable Type | Variable | Description | Value |
|---------------|----------|-------------|-------|
| **Binary Variables** | | | |
| Warehouse | y₁ | Sydney Open (0/1) | |
| Warehouse | y₂ | Perth Open (0/1) | |
| Warehouse | y₃ | Brisbane Open (0/1) | |
| Warehouse | y₄ | Melbourne Open (0/1) | |
| **Shipping Variables** | | | |
| Sydney | x₁₁ | Sydney → Region 1 | |
| Sydney | x₁₂ | Sydney → Region 2 | |
| Sydney | x₁₃ | Sydney → Region 3 | |
| Perth | x₂₁ | Perth → Region 1 | |
| Perth | x₂₂ | Perth → Region 2 | |
| Perth | x₂₃ | Perth → Region 3 | |
| Brisbane | x₃₁ | Brisbane → Region 1 | |
| Brisbane | x₃₂ | Brisbane → Region 2 | |
| Brisbane | x₃₃ | Brisbane → Region 3 | |
| Melbourne | x₄₁ | Melbourne → Region 1 | |
| Melbourne | x₄₂ | Melbourne → Region 2 | |
| Melbourne | x₄₃ | Melbourne → Region 3 | |

### Objective Function Calculation

| Cost Component | Formula | Value |
|----------------|---------|-------|
| Fixed Costs | 400*y₁ + 500*y₂ + 300*y₃ + 150*y₄ | |
| Shipping Costs | 20*x₁₁ + 40*x₁₂ + ... + 35*x₄₃ | |
| **Total Cost** | Fixed Costs + Shipping Costs | |

### Constraint Table

| Constraint Type | LHS | Operator | RHS | Description |
|-----------------|-----|----------|-----|-------------|
| Demand | x₁₁ + x₂₁ + x₃₁ + x₄₁ | = | 80 | Region 1 demand |
| Demand | x₁₂ + x₂₂ + x₃₂ + x₄₂ | = | 70 | Region 2 demand |
| Demand | x₁₃ + x₂₃ + x₃₃ + x₄₃ | = | 40 | Region 3 demand |
| Capacity | x₁₁ + x₁₂ + x₁₃ | ≤ | 100*y₁ | Sydney capacity |
| Capacity | x₂₁ + x₂₂ + x₂₃ | ≤ | 100*y₂ | Perth capacity |
| Capacity | x₃₁ + x₃₂ + x₃₃ | ≤ | 100*y₃ | Brisbane capacity |
| Capacity | x₄₁ + x₄₂ + x₄₃ | ≤ | 100*y₄ | Melbourne capacity |
| Logic | y₁ | ≤ | y₂ | If Sydney, then Perth |
| Limit | y₁ + y₂ + y₃ + y₄ | ≤ | 2 | Max 2 warehouses |
| Required | y₂ + y₄ | ≥ | 1 | Perth or Melbourne |

## Solution Approach

1. Set up the Excel solver table with variables, objective function, and constraints
2. Set binary constraints for warehouse selection variables (y₁, y₂, y₃, y₄)
3. Set non-negativity constraints for shipping variables
4. Use Excel Solver to minimize total cost
5. Analyze the optimal solution for warehouse locations and shipping patterns

## Next Steps

Ready to work through the Excel implementation step by step!