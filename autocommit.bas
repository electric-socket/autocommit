Option _Explicit

Width 15, 9




Print "������������ķ"
Print "�            �"
Print "� Click here �"
Print "�  to commit �"
Print "�            �"
Print "������������Ľ"
Print "Ready"
Do
    If _MouseInput Then
        If _MouseButton(1) Then

        End If
    End If

Loop Until InKey$ <> ""
End




