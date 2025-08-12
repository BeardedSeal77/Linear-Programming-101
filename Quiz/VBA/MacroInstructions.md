# Simplex Pivot Macro Instructions

## How to Install the Macro

1. **Open Excel** with your workbook
2. **Press Alt + F11** to open VBA Editor
3. **Right-click on your workbook** in the Project Explorer
4. **Select Insert > Module**
5. **Copy and paste** the entire code from `SimplexPivot.vba`
6. **Save your workbook** as `.xlsm` (Excel Macro-Enabled Workbook)

## How to Use the Macro

1. **Select your current table range** (e.g., AV50:BO63)
2. **Press Alt + F8** or go to Developer tab > Macros
3. **Select "SimplexPivot"** and click Run
4. **Enter the following when prompted:**
   - **Pivot Row:** The row number to pivot on (e.g., `9`)
   - **Pivot Column:** The column header name (e.g., `e2`)

The macro will:
1. Perform the simplex pivot operation
2. create a new pivotted table underneath your current table
