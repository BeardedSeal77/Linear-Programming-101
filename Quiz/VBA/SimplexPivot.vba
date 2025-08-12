Sub SimplexPivot()
    Dim pivotConstraint As Integer
    Dim pivotCol As String
    Dim currentTable As Range
    Dim newTable As Range
    Dim pivotColIndex As Integer
    Dim pivotElement As Double
    Dim pivotRowIndex As Integer
    Dim i As Integer, j As Integer
    
    ' Check if a range is selected
    If Selection.Cells.Count = 1 Then
        MsgBox "Please select your current table range first, then run the macro."
        Exit Sub
    End If
    
    ' Use selected range as source table
    Set currentTable = Selection
    
    ' Get user inputs for manual pivot
    pivotConstraint = InputBox("Enter constraint number to pivot on:", "Pivot Constraint", "")
    pivotCol = InputBox("Enter pivot column name (e.g., e1, e2, s1):", "Pivot Column", "")
    
    ' Validate inputs
    If pivotConstraint = 0 Or pivotCol = "" Then
        MsgBox "All inputs are required. Operation cancelled."
        Exit Sub
    End If
    
    ' Calculate new table range (2 cells below current table)
    Dim tableHeight As Integer
    Dim tableWidth As Integer
    tableHeight = currentTable.Rows.Count
    tableWidth = currentTable.Columns.Count
    
    Set newTable = currentTable.Offset(tableHeight + 2, 0).Resize(tableHeight, tableWidth)
    
    ' Clear the destination range first
    newTable.Clear
    
    ' Find pivot column index in the header row
    pivotColIndex = 0
    For j = 1 To tableWidth
        If currentTable.Cells(1, j).Value = pivotCol Then
            pivotColIndex = j
            Exit For
        End If
    Next j
    
    If pivotColIndex = 0 Then
        MsgBox "Pivot column '" & pivotCol & "' not found in table header."
        Exit Sub
    End If
    
    ' Find pivot row index by searching for constraint number in first column
    pivotRowIndex = 0
    For i = 2 To tableHeight ' Start from row 2 (skip header)
        If currentTable.Cells(i, 1).Value = pivotConstraint Then
            pivotRowIndex = i
            Exit For
        End If
    Next i
    
    If pivotRowIndex = 0 Then
        MsgBox "Constraint " & pivotConstraint & " not found in first column."
        Exit Sub
    End If
    
    ' Get pivot element
    pivotElement = currentTable.Cells(pivotRowIndex, pivotColIndex).Value
    
    If pivotElement = 0 Then
        MsgBox "Pivot element is zero. Cannot perform pivot operation."
        Exit Sub
    End If
    
    If Not IsNumeric(pivotElement) Then
        MsgBox "Pivot element is not numeric: " & pivotElement
        Exit Sub
    End If
    
    ' Define tolerance for floating point precision
    Const tolerance As Double = 0.0000000001  ' 1E-10
    
    ' Perform pivot operation and write to new table
    For i = 1 To tableHeight
        For j = 1 To tableWidth
            If i = 1 Or j = 1 Then
                ' Copy header row and constraint names column as-is
                newTable.Cells(i, j).Value = currentTable.Cells(i, j).Value
            ElseIf i = pivotRowIndex Then
                ' Pivot row: divide by pivot element (skip first column)
                If IsNumeric(currentTable.Cells(i, j).Value) And currentTable.Cells(i, j).Value <> "" Then
                    Dim pivotResult As Double
                    pivotResult = currentTable.Cells(i, j).Value / pivotElement
                    ' Round to 0 if very small
                    If Abs(pivotResult) < tolerance Then pivotResult = 0
                    newTable.Cells(i, j).Value = pivotResult
                Else
                    newTable.Cells(i, j).Value = currentTable.Cells(i, j).Value
                End If
            Else
                ' Other rows: apply pivot formula (skip first column)
                Dim currentVal As Variant
                Dim pivotColVal As Variant
                Dim pivotRowVal As Variant
                
                currentVal = currentTable.Cells(i, j).Value
                pivotColVal = currentTable.Cells(i, pivotColIndex).Value
                pivotRowVal = currentTable.Cells(pivotRowIndex, j).Value
                
                ' Only perform calculation if all values are numeric
                If IsNumeric(currentVal) And IsNumeric(pivotColVal) And IsNumeric(pivotRowVal) And _
                   currentVal <> "" And pivotColVal <> "" And pivotRowVal <> "" Then
                    Dim calcResult As Double
                    calcResult = currentVal - (pivotColVal * pivotRowVal / pivotElement)
                    ' Round to 0 if very small
                    If Abs(calcResult) < tolerance Then calcResult = 0
                    newTable.Cells(i, j).Value = calcResult
                Else
                    newTable.Cells(i, j).Value = currentVal
                End If
            End If
        Next j
    Next i
    
    ' Now highlight dual simplex pivot in the new table
    Call HighlightDualSimplex(newTable)
    
           
End Sub

Sub HighlightDualSimplex(currentTable As Range)
    Dim tableHeight As Integer
    Dim tableWidth As Integer
    Dim rhsColIndex As Integer
    Dim mostNegativeRHS As Double
    Dim pivotRowIndex As Integer
    Dim pivotColIndex As Integer
    Dim minRatio As Double
    Dim i As Integer, j As Integer
    
    tableHeight = currentTable.Rows.Count
    tableWidth = currentTable.Columns.Count
    
    ' Clear any existing highlighting
    currentTable.Interior.ColorIndex = xlNone
    
    ' Find RHS column (assume it's the last column)
    rhsColIndex = tableWidth
    
    ' Find row with most negative RHS (excluding z row)
    mostNegativeRHS = 0
    pivotRowIndex = 0
    
    For i = 2 To tableHeight ' Skip header row and z row
        If currentTable.Cells(i, 1).Value <> "z" Then
            Dim rhsValue As Variant
            rhsValue = currentTable.Cells(i, rhsColIndex).Value
            
            If IsNumeric(rhsValue) And rhsValue < mostNegativeRHS Then
                mostNegativeRHS = rhsValue
                pivotRowIndex = i
            End If
        End If
    Next i
    
    If pivotRowIndex = 0 Then
        Exit Sub
    End If
    
    ' Find pivot column using minimum ratio test
    ' Ratio = Z_j / a_ij where a_ij < 0 in pivot row
    minRatio = 999999
    pivotColIndex = 0
    
    For j = 2 To tableWidth - 1 ' Skip first column (labels) and RHS column
        Dim pivotRowElement As Variant
        pivotRowElement = currentTable.Cells(pivotRowIndex, j).Value
        
        If IsNumeric(pivotRowElement) And pivotRowElement < 0 Then
            Dim zValue As Variant
            zValue = currentTable.Cells(2, j).Value ' Assume z row is row 2
            
            If IsNumeric(zValue) Then
                Dim ratio As Double
                ratio = Abs(zValue / pivotRowElement)
                
                If ratio < minRatio Then
                    minRatio = ratio
                    pivotColIndex = j
                End If
            End If
        End If
    Next j
    
    If pivotColIndex = 0 Then
        Exit Sub
    End If
    
    ' Highlight pivot row and column (green, accent 6, lighter 60%)
    currentTable.Rows(pivotRowIndex).Interior.Color = RGB(169, 208, 142)
    currentTable.Columns(pivotColIndex).Interior.Color = RGB(169, 208, 142)
           
End Sub