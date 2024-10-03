Option _Explicit

Width 15, 9




Print "ÖÄÄÄÄÄÄÄÄÄÄÄÄ·"
Print "º            º"
Print "º Click here º"
Print "º  to commit º"
Print "º            º"
Print "ÓÄÄÄÄÄÄÄÄÄÄÄÄ½"
Print "Ready"
Do
    If _MouseInput Then
        If _MouseButton(1) Then

        End If
    End If

Loop Until InKey$ <> ""
End




